/// 사용자 프로필 모델
class UserProfile {
  final String id;
  final String displayName;
  final String? churchId;
  final String? churchName;
  final int faithPoints;
  final int currentLevel;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastStudyDate;
  final bool darkMode;
  final bool notificationEnabled;
  final String notificationTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserProfile({
    required this.id,
    required this.displayName,
    this.churchId,
    this.churchName,
    this.faithPoints = 0,
    this.currentLevel = 1,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastStudyDate,
    this.darkMode = false,
    this.notificationEnabled = true,
    this.notificationTime = '08:00',
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      displayName: json['display_name'] as String? ?? '',
      churchId: json['church_id'] as String?,
      churchName: json['church_name'] as String?,
      faithPoints: json['faith_points'] as int? ?? 0,
      currentLevel: json['current_level'] as int? ?? 1,
      currentStreak: json['current_streak'] as int? ?? 0,
      longestStreak: json['longest_streak'] as int? ?? 0,
      lastStudyDate: json['last_study_date'] != null
          ? DateTime.parse(json['last_study_date'] as String)
          : null,
      darkMode: json['dark_mode'] as bool? ?? false,
      notificationEnabled: json['notification_enabled'] as bool? ?? true,
      notificationTime: json['notification_time'] as String? ?? '08:00',
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': displayName,
      'church_id': churchId,
      'faith_points': faithPoints,
      'current_level': currentLevel,
      'current_streak': currentStreak,
      'longest_streak': longestStreak,
      'last_study_date': lastStudyDate?.toIso8601String(),
      'dark_mode': darkMode,
      'notification_enabled': notificationEnabled,
      'notification_time': notificationTime,
    };
  }

  UserProfile copyWith({
    String? displayName,
    String? churchId,
    String? churchName,
    int? faithPoints,
    int? currentLevel,
    int? currentStreak,
    int? longestStreak,
    DateTime? lastStudyDate,
    bool? darkMode,
    bool? notificationEnabled,
    String? notificationTime,
  }) {
    return UserProfile(
      id: id,
      displayName: displayName ?? this.displayName,
      churchId: churchId ?? this.churchId,
      churchName: churchName ?? this.churchName,
      faithPoints: faithPoints ?? this.faithPoints,
      currentLevel: currentLevel ?? this.currentLevel,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      lastStudyDate: lastStudyDate ?? this.lastStudyDate,
      darkMode: darkMode ?? this.darkMode,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      notificationTime: notificationTime ?? this.notificationTime,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }
}
