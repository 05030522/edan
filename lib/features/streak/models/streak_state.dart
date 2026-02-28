/// 스트릭 상태 모델
class StreakState {
  final int currentStreak;
  final int longestStreak;
  final int totalStudyDays;
  final int graceDaysRemaining;
  final bool graceDayUsedToday;
  final DateTime? lastStudyDate;
  final List<DateTime> studyCalendar;

  const StreakState({
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalStudyDays = 0,
    this.graceDaysRemaining = 1,
    this.graceDayUsedToday = false,
    this.lastStudyDate,
    this.studyCalendar = const [],
  });

  factory StreakState.fromJson(Map<String, dynamic> json) {
    return StreakState(
      currentStreak: json['current_streak'] as int? ?? 0,
      longestStreak: json['longest_streak'] as int? ?? 0,
      totalStudyDays: json['total_study_days'] as int? ?? 0,
      graceDaysRemaining: json['grace_days_remaining'] as int? ?? 1,
      graceDayUsedToday: json['grace_day_used_today'] as bool? ?? false,
      lastStudyDate: json['last_study_date'] != null
          ? DateTime.parse(json['last_study_date'] as String)
          : null,
    );
  }

  /// 스트릭 상태 판단
  bool get isActive => currentStreak > 0;

  /// 스트릭 불꽃 크기 (마일스톤 기반)
  StreakFlameSize get flameSize {
    if (currentStreak >= 30) return StreakFlameSize.rainbow;
    if (currentStreak >= 14) return StreakFlameSize.large;
    if (currentStreak >= 7) return StreakFlameSize.medium;
    if (currentStreak >= 3) return StreakFlameSize.small;
    return StreakFlameSize.none;
  }

  StreakState copyWith({
    int? currentStreak,
    int? longestStreak,
    int? totalStudyDays,
    int? graceDaysRemaining,
    bool? graceDayUsedToday,
    DateTime? lastStudyDate,
    List<DateTime>? studyCalendar,
  }) {
    return StreakState(
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalStudyDays: totalStudyDays ?? this.totalStudyDays,
      graceDaysRemaining: graceDaysRemaining ?? this.graceDaysRemaining,
      graceDayUsedToday: graceDayUsedToday ?? this.graceDayUsedToday,
      lastStudyDate: lastStudyDate ?? this.lastStudyDate,
      studyCalendar: studyCalendar ?? this.studyCalendar,
    );
  }
}

/// 스트릭 불꽃 크기
enum StreakFlameSize {
  none,
  small, // 3일+
  medium, // 7일+
  large, // 14일+
  rainbow, // 30일+
}
