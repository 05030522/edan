/// 퀘스트 모델
class Quest {
  final String id;
  final String title;
  final String? description;
  final String type; // 'daily', 'weekly', 'special', 'challenge'
  final String conditionType;
  final int conditionValue;
  final int rewardFp;
  final String? rewardItemId;
  final bool isActive;
  final String? season;

  const Quest({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    required this.conditionType,
    required this.conditionValue,
    this.rewardFp = 0,
    this.rewardItemId,
    this.isActive = true,
    this.season,
  });

  factory Quest.fromJson(Map<String, dynamic> json) {
    return Quest(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      conditionType: json['condition_type'] as String,
      conditionValue: json['condition_value'] as int,
      rewardFp: json['reward_fp'] as int? ?? 0,
      rewardItemId: json['reward_item_id'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      season: json['season'] as String?,
    );
  }

  String get typeLabel {
    switch (type) {
      case 'daily':
        return '일일';
      case 'weekly':
        return '주간';
      case 'special':
        return '특별';
      case 'challenge':
        return '도전';
      default:
        return '';
    }
  }
}

/// 사용자 퀘스트 진행 모델
class UserQuest {
  final String id;
  final String userId;
  final String questId;
  final int progress;
  final bool completed;
  final DateTime? completedAt;
  final DateTime assignedDate;
  final Quest? quest;

  const UserQuest({
    required this.id,
    required this.userId,
    required this.questId,
    this.progress = 0,
    this.completed = false,
    this.completedAt,
    required this.assignedDate,
    this.quest,
  });

  factory UserQuest.fromJson(Map<String, dynamic> json) {
    return UserQuest(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      questId: json['quest_id'] as String,
      progress: json['progress'] as int? ?? 0,
      completed: json['completed'] as bool? ?? false,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
      assignedDate: DateTime.parse(json['assigned_date'] as String),
      quest: json['quest'] != null
          ? Quest.fromJson(json['quest'] as Map<String, dynamic>)
          : null,
    );
  }

  double get progressPercent {
    if (quest == null) return 0;
    return (progress / quest!.conditionValue).clamp(0.0, 1.0);
  }
}

/// 업적 모델
class Achievement {
  final String id;
  final String title;
  final String description;
  final String iconName;
  final String conditionType;
  final int conditionValue;
  final int rewardFp;
  final bool isHidden;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.iconName,
    required this.conditionType,
    required this.conditionValue,
    this.rewardFp = 0,
    this.isHidden = false,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      iconName: json['icon_name'] as String,
      conditionType: json['condition_type'] as String,
      conditionValue: json['condition_value'] as int,
      rewardFp: json['reward_fp'] as int? ?? 0,
      isHidden: json['is_hidden'] as bool? ?? false,
    );
  }
}

/// 사용자 업적 (달성된 업적)
class UserAchievement {
  final String id;
  final String userId;
  final String achievementId;
  final DateTime unlockedAt;
  final Achievement? achievement;

  const UserAchievement({
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.unlockedAt,
    this.achievement,
  });

  factory UserAchievement.fromJson(Map<String, dynamic> json) {
    return UserAchievement(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      achievementId: json['achievement_id'] as String,
      unlockedAt: DateTime.parse(json['unlocked_at'] as String),
      achievement: json['achievement'] != null
          ? Achievement.fromJson(json['achievement'] as Map<String, dynamic>)
          : null,
    );
  }
}
