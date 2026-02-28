/// 레슨 모델 (일일 묵상)
class Lesson {
  final String id;
  final String pathId;
  final int dayNumber;
  final String title;
  final String bibleBook;
  final int bibleChapter;
  final int bibleVerseStart;
  final int bibleVerseEnd;
  final String bibleText;
  final String backgroundExplanation;
  final String selahQuestion;
  final DateTime createdAt;

  const Lesson({
    required this.id,
    required this.pathId,
    required this.dayNumber,
    required this.title,
    required this.bibleBook,
    required this.bibleChapter,
    required this.bibleVerseStart,
    required this.bibleVerseEnd,
    required this.bibleText,
    required this.backgroundExplanation,
    required this.selahQuestion,
    required this.createdAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'] as String,
      pathId: json['path_id'] as String,
      dayNumber: json['day_number'] as int,
      title: json['title'] as String,
      bibleBook: json['bible_book'] as String,
      bibleChapter: json['bible_chapter'] as int,
      bibleVerseStart: json['bible_verse_start'] as int,
      bibleVerseEnd: json['bible_verse_end'] as int,
      bibleText: json['bible_text'] as String,
      backgroundExplanation: json['background_explanation'] as String,
      selahQuestion: json['selah_question'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// 성경 구절 레퍼런스 (예: "요한복음 3:16-17")
  String get bibleReference {
    if (bibleVerseStart == bibleVerseEnd) {
      return '$bibleBook $bibleChapter:$bibleVerseStart';
    }
    return '$bibleBook $bibleChapter:$bibleVerseStart-$bibleVerseEnd';
  }
}

/// 퀴즈 모델
class Quiz {
  final String id;
  final String lessonId;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final int orderIndex;

  const Quiz({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.orderIndex,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'] as String,
      lessonId: json['lesson_id'] as String,
      question: json['question'] as String,
      options: List<String>.from(json['options'] as List),
      correctIndex: json['correct_index'] as int,
      explanation: json['explanation'] as String,
      orderIndex: json['order_index'] as int? ?? 0,
    );
  }
}

/// 사용자 학습 진행 모델
class UserProgress {
  final String id;
  final String userId;
  final String lessonId;
  final String pathId;
  final bool completed;
  final int quizScore;
  final int faithPointsEarned;
  final String? selahResponse;
  final String? mood;
  final String? prayerNote;
  final DateTime? completedAt;

  const UserProgress({
    required this.id,
    required this.userId,
    required this.lessonId,
    required this.pathId,
    this.completed = false,
    this.quizScore = 0,
    this.faithPointsEarned = 0,
    this.selahResponse,
    this.mood,
    this.prayerNote,
    this.completedAt,
  });

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      lessonId: json['lesson_id'] as String,
      pathId: json['path_id'] as String,
      completed: json['completed'] as bool? ?? false,
      quizScore: json['quiz_score'] as int? ?? 0,
      faithPointsEarned: json['faith_points_earned'] as int? ?? 0,
      selahResponse: json['selah_response'] as String?,
      mood: json['mood'] as String?,
      prayerNote: json['prayer_note'] as String?,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
    );
  }
}
