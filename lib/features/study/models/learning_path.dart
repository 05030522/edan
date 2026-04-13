/// 학습 경로 모델
class LearningPath {
  final String id;
  final String title;
  final String description;
  final int totalDays;
  final String difficulty; // 'beginner', 'intermediate', 'advanced'
  final bool isActive;
  final DateTime createdAt;

  const LearningPath({
    required this.id,
    required this.title,
    required this.description,
    required this.totalDays,
    required this.difficulty,
    this.isActive = true,
    required this.createdAt,
  });

  factory LearningPath.fromJson(Map<String, dynamic> json) {
    return LearningPath(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      totalDays: json['total_days'] as int,
      difficulty: json['difficulty'] as String,
      isActive: json['is_active'] as bool? ?? true,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'total_days': totalDays,
    'difficulty': difficulty,
    'is_active': isActive,
  };

  String get difficultyLabel {
    switch (difficulty) {
      case 'beginner':
        return '입문';
      case 'intermediate':
        return '중급';
      case 'advanced':
        return '심화';
      default:
        return '입문';
    }
  }
}
