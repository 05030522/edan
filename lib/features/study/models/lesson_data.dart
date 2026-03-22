/// 레슨 콘텐츠 데이터 모델
class LessonContent {
  final String lessonId;
  final String pathId;
  final String title;
  final String scriptureReference;
  final String scriptureText;
  final String? meditationGuide;

  const LessonContent({
    required this.lessonId,
    required this.pathId,
    required this.title,
    required this.scriptureReference,
    required this.scriptureText,
    this.meditationGuide,
  });
}

/// 레슨 콘텐츠 데이터 저장소
class LessonDataStore {
  static const List<LessonContent> lessons = [
    // ─── 경로 1: 신앙의 첫걸음 ───
    LessonContent(
      lessonId: 'lesson-1',
      pathId: 'path-1',
      title: '홍해를 여시는 하나님',
      scriptureReference: '출애굽기 14:16',
      scriptureText:
          '지팡이를 들고 손을 바다 위로 내밀어 그것이 갈라지게 하라. '
          '이스라엘 자손이 바다 가운데서 마른 땅으로 행하리라.',
      meditationGuide: '두려움 앞에서도 나아가라 하시는 하나님의 음성을 묵상해보세요.',
    ),
    LessonContent(
      lessonId: 'lesson-2',
      pathId: 'path-1',
      title: '하나님의 사랑',
      scriptureReference: '요한복음 3:16',
      scriptureText:
          '하나님이 세상을 이처럼 사랑하사 독생자를 주셨으니 '
          '이는 그를 믿는 자마다 멸망하지 않고 영생을 얻게 하려 하심이라.',
      meditationGuide: '나를 향한 하나님의 크신 사랑을 느껴보세요.',
    ),
    LessonContent(
      lessonId: 'lesson-3',
      pathId: 'path-1',
      title: '선한 목자',
      scriptureReference: '시편 23:1-3',
      scriptureText:
          '여호와는 나의 목자시니 내게 부족함이 없으리로다. '
          '그가 나를 푸른 풀밭에 누이시며 쉴 만한 물가로 인도하시는도다. '
          '내 영혼을 소생시키시고 자기 이름을 위하여 의의 길로 인도하시는도다.',
      meditationGuide: '하나님이 나의 삶을 인도하시는 방법을 묵상해보세요.',
    ),
    LessonContent(
      lessonId: 'lesson-4',
      pathId: 'path-1',
      title: '모든 것이 합력',
      scriptureReference: '로마서 8:28',
      scriptureText:
          '우리가 알거니와 하나님을 사랑하는 자 곧 그의 뜻대로 부르심을 입은 자들에게는 '
          '모든 것이 합력하여 선을 이루느니라.',
      meditationGuide: '어려운 상황 속에서도 하나님의 선한 계획을 신뢰해보세요.',
    ),

    // ─── 경로 2: 불안을 넘어 평안으로 ───
    LessonContent(
      lessonId: 'lesson-1',
      pathId: 'path-2',
      title: '평안을 주시는 하나님',
      scriptureReference: '빌립보서 4:6-7',
      scriptureText:
          '아무 것도 염려하지 말고 다만 모든 일에 기도와 간구로, '
          '너희 구할 것을 감사함으로 하나님께 아뢰라. '
          '그리하면 모든 지각에 뛰어난 하나님의 평강이 '
          '그리스도 예수 안에서 너희 마음과 생각을 지키시리라.',
      meditationGuide: '염려를 내려놓고 하나님의 평안 안에 머물러 보세요.',
    ),
    LessonContent(
      lessonId: 'lesson-2',
      pathId: 'path-2',
      title: '두려워하지 말라',
      scriptureReference: '이사야 41:10',
      scriptureText:
          '두려워하지 말라 내가 너와 함께 함이라 '
          '놀라지 말라 나는 네 하나님이 됨이라 '
          '내가 너를 굳세게 하리라 참으로 너를 도와주리라 '
          '참으로 나의 의로운 오른손으로 너를 붙들리라.',
      meditationGuide: '하나님이 함께하신다는 약속 안에서 두려움을 내려놓아 보세요.',
    ),
  ];

  /// pathId와 lessonId로 레슨 콘텐츠 찾기
  static LessonContent? getLesson(String pathId, String lessonId) {
    try {
      return lessons.firstWhere(
        (l) => l.pathId == pathId && l.lessonId == lessonId,
      );
    } catch (_) {
      return null;
    }
  }

  /// pathId로 해당 경로의 모든 레슨 가져오기
  static List<LessonContent> getLessonsForPath(String pathId) {
    return lessons.where((l) => l.pathId == pathId).toList();
  }

  /// 기본 레슨 (찾지 못했을 때)
  static const LessonContent defaultLesson = LessonContent(
    lessonId: 'default',
    pathId: 'default',
    title: '하나님의 사랑',
    scriptureReference: '요한복음 3:16',
    scriptureText:
        '하나님이 세상을 이처럼 사랑하사 독생자를 주셨으니 '
        '이는 그를 믿는 자마다 멸망하지 않고 영생을 얻게 하려 하심이라.',
  );
}
