import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 연속 묵상 목표 관리 프로바이더
///
/// 사용자가 직접 선택한 목표를 SharedPreferences에 저장합니다.
/// 목표가 설정되지 않았다면 기본값(7일)을 사용합니다.
class StreakGoalState {
  /// 사용자가 선택한 목표 일수 (null이면 아직 설정 안 함 — 기본값 사용)
  final int? customGoal;

  /// 마지막으로 '스트릭 깨짐 안내'를 본 날짜 (같은 날 중복 안내 방지)
  final DateTime? lastBrokenNoticeShownAt;

  const StreakGoalState({
    this.customGoal,
    this.lastBrokenNoticeShownAt,
  });

  StreakGoalState copyWith({
    int? customGoal,
    DateTime? lastBrokenNoticeShownAt,
    bool clearCustomGoal = false,
  }) {
    return StreakGoalState(
      customGoal: clearCustomGoal ? null : (customGoal ?? this.customGoal),
      lastBrokenNoticeShownAt:
          lastBrokenNoticeShownAt ?? this.lastBrokenNoticeShownAt,
    );
  }
}

/// 목표 선택지 (일수)
const List<int> kStreakGoalOptions = [7, 14, 30, 100, 365];

class StreakGoalNotifier extends StateNotifier<StreakGoalState> {
  static const _keyCustomGoal = 'streak_goal_custom';
  static const _keyLastBrokenNotice = 'streak_broken_notice_shown_at';

  StreakGoalNotifier() : super(const StreakGoalState()) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final customGoal = prefs.getInt(_keyCustomGoal);
      final lastNoticeMs = prefs.getInt(_keyLastBrokenNotice);
      state = StreakGoalState(
        customGoal: customGoal,
        lastBrokenNoticeShownAt: lastNoticeMs != null
            ? DateTime.fromMillisecondsSinceEpoch(lastNoticeMs)
            : null,
      );
    } catch (e) {
      debugPrint('streak goal 로드 실패: $e');
    }
  }

  /// 목표 직접 설정
  Future<void> setGoal(int days) async {
    state = state.copyWith(customGoal: days);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyCustomGoal, days);
    } catch (e) {
      debugPrint('streak goal 저장 실패: $e');
    }
  }

  /// 목표 초기화 (자동 계산으로 되돌리기)
  Future<void> clearGoal() async {
    state = state.copyWith(clearCustomGoal: true);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyCustomGoal);
    } catch (e) {
      debugPrint('streak goal 초기화 실패: $e');
    }
  }

  /// 현재 적용할 목표 일수 계산
  /// - customGoal이 있으면 사용
  /// - 없으면 현재 스트릭보다 큰 가장 가까운 기본 옵션
  int resolveGoal(int currentStreak) {
    if (state.customGoal != null) return state.customGoal!;
    return kStreakGoalOptions.firstWhere(
      (g) => g > currentStreak,
      orElse: () => kStreakGoalOptions.last,
    );
  }

  /// '스트릭 깨짐 안내'를 오늘 보였다고 기록
  Future<void> markBrokenNoticeShown() async {
    final now = DateTime.now();
    state = state.copyWith(lastBrokenNoticeShownAt: now);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyLastBrokenNotice, now.millisecondsSinceEpoch);
    } catch (e) {
      debugPrint('streak broken notice 저장 실패: $e');
    }
  }

  /// 오늘 이미 안내를 보여줬는지 확인
  bool wasBrokenNoticeShownToday() {
    final last = state.lastBrokenNoticeShownAt;
    if (last == null) return false;
    final now = DateTime.now();
    return last.year == now.year &&
        last.month == now.month &&
        last.day == now.day;
  }
}

final streakGoalProvider =
    StateNotifierProvider<StreakGoalNotifier, StreakGoalState>(
  (ref) => StreakGoalNotifier(),
);

/// 스트릭이 깨진 상태인지 판단 (lastStudyDate 기준 2일 이상 경과)
///
/// 반환값: 쉰 일수 (0이면 깨지지 않음, 1 이상이면 그만큼 쉼)
int calcStreakBreakDays({
  required DateTime? lastStudyDate,
  required int currentStreak,
}) {
  if (lastStudyDate == null) return 0;
  if (currentStreak <= 0) return 0;
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final last =
      DateTime(lastStudyDate.year, lastStudyDate.month, lastStudyDate.day);
  final diff = today.difference(last).inDays;
  // diff == 0: 오늘 했음, 1: 어제 했음 (아직 안 끊김), 2+: 끊김
  if (diff >= 2) return diff - 1; // 쉰 일수
  return 0;
}
