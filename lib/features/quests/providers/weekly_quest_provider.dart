import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/weekly_quest_definitions.dart';

/// 개별 주간 퀘스트 진행 상태
class ActiveWeeklyQuest {
  final String defId;
  final int progress;
  final bool rewardClaimed;

  const ActiveWeeklyQuest({
    required this.defId,
    this.progress = 0,
    this.rewardClaimed = false,
  });

  WeeklyQuestDef? get def => findQuestDef(defId);

  bool get isCompleted {
    final target = def?.target ?? 0;
    return target > 0 && progress >= target;
  }

  double get progressPercent {
    final target = def?.target ?? 0;
    if (target == 0) return 0;
    return (progress / target).clamp(0.0, 1.0);
  }

  ActiveWeeklyQuest copyWith({int? progress, bool? rewardClaimed}) {
    return ActiveWeeklyQuest(
      defId: defId,
      progress: progress ?? this.progress,
      rewardClaimed: rewardClaimed ?? this.rewardClaimed,
    );
  }

  Map<String, dynamic> toJson() => {
    'defId': defId,
    'progress': progress,
    'rewardClaimed': rewardClaimed,
  };

  factory ActiveWeeklyQuest.fromJson(Map<String, dynamic> json) {
    return ActiveWeeklyQuest(
      defId: json['defId'] as String,
      progress: json['progress'] as int? ?? 0,
      rewardClaimed: json['rewardClaimed'] as bool? ?? false,
    );
  }
}

/// 주간 퀘스트 상태
class WeeklyQuestState {
  final List<ActiveWeeklyQuest> quests;
  final String assignedWeek;

  const WeeklyQuestState({this.quests = const [], this.assignedWeek = ''});

  WeeklyQuestState copyWith({
    List<ActiveWeeklyQuest>? quests,
    String? assignedWeek,
  }) {
    return WeeklyQuestState(
      quests: quests ?? this.quests,
      assignedWeek: assignedWeek ?? this.assignedWeek,
    );
  }
}

/// 주간 퀘스트 프로바이더
class WeeklyQuestNotifier extends StateNotifier<WeeklyQuestState> {
  static const _keyState = 'weekly_quest_state';
  static const _keyWeek = 'weekly_quest_assigned_week';
  static const _questsPerWeek = 3;

  WeeklyQuestNotifier() : super(const WeeklyQuestState()) {
    _load();
  }

  /// 현재 ISO 주차 식별자 (e.g., "2026-W16")
  static String currentWeekId() {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, 1, 1);
    final daysDiff = now.difference(firstDay).inDays;
    final weekNum = ((daysDiff + firstDay.weekday) / 7).ceil();
    return '${now.year}-W$weekNum';
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final week = prefs.getString(_keyWeek);
      final json = prefs.getString(_keyState);

      final nowWeek = currentWeekId();

      if (week == nowWeek && json != null) {
        final list = jsonDecode(json) as List;
        final quests = list
            .map((e) => ActiveWeeklyQuest.fromJson(e as Map<String, dynamic>))
            .toList();
        state = WeeklyQuestState(quests: quests, assignedWeek: nowWeek);
      } else {
        // 새 주차 → 새 퀘스트 배정
        await _assignNewWeek(nowWeek);
      }
    } catch (e) {
      debugPrint('주간 퀘스트 로드 실패: $e');
    }
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyWeek, state.assignedWeek);
      await prefs.setString(
        _keyState,
        jsonEncode(state.quests.map((q) => q.toJson()).toList()),
      );
    } catch (e) {
      debugPrint('주간 퀘스트 저장 실패: $e');
    }
  }

  /// 새 주차 퀘스트 배정 (결정론적 랜덤 — 같은 주에 재설치해도 동일)
  Future<void> _assignNewWeek(String weekId) async {
    final seed = weekId.hashCode.abs();
    final pool = List<WeeklyQuestDef>.from(kWeeklyQuestPool);
    // Fisher-Yates with deterministic seed
    for (int i = pool.length - 1; i > 0; i--) {
      final j = (seed + i * 2654435769) % (i + 1);
      final temp = pool[i];
      pool[i] = pool[j];
      pool[j] = temp;
    }
    final picked = pool.take(_questsPerWeek).toList();
    final quests = picked
        .map((def) => ActiveWeeklyQuest(defId: def.id))
        .toList();

    state = WeeklyQuestState(quests: quests, assignedWeek: weekId);
    await _save();
  }

  /// 조건 타입에 해당하는 퀘스트 진행도 증가
  Future<void> incrementProgress(String conditionType, {int delta = 1}) async {
    bool changed = false;
    final updated = state.quests.map((q) {
      final def = q.def;
      if (def == null ||
          def.conditionType != conditionType ||
          q.rewardClaimed ||
          q.progress >= def.target) {
        return q;
      }
      changed = true;
      final next = (q.progress + delta).clamp(0, def.target);
      return q.copyWith(progress: next);
    }).toList();

    if (changed) {
      state = state.copyWith(quests: updated);
      await _save();
    }
  }

  /// 보상 수령 → 완료 표시. 실제 FP 지급은 호출 측에서 처리.
  Future<int> claimReward(String defId) async {
    final idx = state.quests.indexWhere((q) => q.defId == defId);
    if (idx == -1) return 0;
    final q = state.quests[idx];
    if (q.rewardClaimed || !q.isCompleted) return 0;

    final reward = q.def?.rewardFp ?? 0;
    final updated = [...state.quests];
    updated[idx] = q.copyWith(rewardClaimed: true);
    state = state.copyWith(quests: updated);
    await _save();
    return reward;
  }
}

final weeklyQuestProvider =
    StateNotifierProvider<WeeklyQuestNotifier, WeeklyQuestState>((ref) {
      return WeeklyQuestNotifier();
    });
