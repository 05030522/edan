import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/models/user_profile.dart';
import '../../quests/models/quest.dart';
import '../data/achievement_definitions.dart';

/// 업적 상태
class AchievementState {
  final Set<String> unlockedIds;
  final Map<String, DateTime> unlockDates;

  const AchievementState({
    this.unlockedIds = const {},
    this.unlockDates = const {},
  });

  AchievementState copyWith({
    Set<String>? unlockedIds,
    Map<String, DateTime>? unlockDates,
  }) {
    return AchievementState(
      unlockedIds: unlockedIds ?? this.unlockedIds,
      unlockDates: unlockDates ?? this.unlockDates,
    );
  }

  bool isUnlocked(String id) => unlockedIds.contains(id);

  int get unlockedCount => unlockedIds.length;
  int get totalCount => kAchievements.length;
}

/// 업적 프로바이더
class AchievementNotifier extends StateNotifier<AchievementState> {
  static const _keyUnlocked = 'unlocked_achievements';

  AchievementNotifier() : super(const AchievementState()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_keyUnlocked);
      if (json == null) return;

      final map = jsonDecode(json) as Map<String, dynamic>;
      final ids = <String>{};
      final dates = <String, DateTime>{};

      for (final entry in map.entries) {
        ids.add(entry.key);
        dates[entry.key] = DateTime.fromMillisecondsSinceEpoch(
          entry.value as int,
        );
      }

      state = AchievementState(unlockedIds: ids, unlockDates: dates);
    } catch (e) {
      debugPrint('업적 데이터 로드 실패: $e');
    }
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final map = <String, int>{};
      for (final id in state.unlockedIds) {
        map[id] =
            state.unlockDates[id]?.millisecondsSinceEpoch ??
            DateTime.now().millisecondsSinceEpoch;
      }
      await prefs.setString(_keyUnlocked, jsonEncode(map));
    } catch (e) {
      debugPrint('업적 데이터 저장 실패: $e');
    }
  }

  /// 조건 체크 후 새로 달성된 업적 반환
  Future<List<Achievement>> checkAndUnlock({
    required UserProfile profile,
  }) async {
    final newlyUnlocked = <Achievement>[];

    // SharedPreferences 인스턴스 1회 획득 + 카운터 동시 읽기
    final prefs = await SharedPreferences.getInstance();
    final meditationCount = prefs.getInt('total_meditation_count') ?? 0;
    final prayerCount = prefs.getInt('total_prayer_count') ?? 0;
    final bibleCount = prefs.getInt('total_bible_count') ?? 0;

    for (final achievement in kAchievements) {
      if (state.isUnlocked(achievement.id)) continue;

      bool met = false;
      switch (achievement.conditionType) {
        case 'meditation_count':
          met = meditationCount >= achievement.conditionValue;
        case 'prayer_count':
          met = prayerCount >= achievement.conditionValue;
        case 'bible_count':
          met = bibleCount >= achievement.conditionValue;
        case 'streak':
          met = profile.currentStreak >= achievement.conditionValue;
        case 'level':
          met = profile.currentLevel >= achievement.conditionValue;
        case 'total_fp':
          met = profile.faithPoints >= achievement.conditionValue;
      }

      if (met) {
        newlyUnlocked.add(achievement);
      }
    }

    if (newlyUnlocked.isNotEmpty) {
      final newIds = {...state.unlockedIds};
      final newDates = {...state.unlockDates};
      final now = DateTime.now();

      for (final a in newlyUnlocked) {
        newIds.add(a.id);
        newDates[a.id] = now;
      }

      state = AchievementState(unlockedIds: newIds, unlockDates: newDates);
      await _save();
    }

    return newlyUnlocked;
  }
}

/// 활동 카운터 증가 유틸
Future<void> incrementActivityCounter(String type) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'total_${type}_count';
  final current = prefs.getInt(key) ?? 0;
  await prefs.setInt(key, current + 1);
}

/// 프로바이더 정의
final achievementProvider =
    StateNotifierProvider<AchievementNotifier, AchievementState>((ref) {
      return AchievementNotifier();
    });
