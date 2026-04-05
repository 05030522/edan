/// 프로젝트 에덴 앱 상수값
class AppConstants {
  AppConstants._();

  // ─── 앱 정보 ───
  static const String appName = '에덴';
  static const String appNameFull = 'Eden - 에덴';
  static const String appVersion = '1.0.0';
  static const String appSlogan = '매일 5분, 에덴에서 만나요';

  // ─── 게임화 설정 ───
  static const int faithPointsPerLesson = 10;
  static const int faithPointsPerQuizCorrect = 5;
  static const int faithPointsPerSelah = 5;
  static const int faithPointsStreakBonus = 50;
  static const int faithPointsPerfectDay = 10;

  // ─── 스트릭 설정 ───
  static const int graceDayRechargeInterval = 7; // 7일마다 Grace Day 충전
  static const int maxGraceDays = 1; // 최대 1개 보유
  static const int streakDangerHour = 21; // 오후 9시 알림

  // ─── 레벨 시스템 ───
  // 일평균 ~35 FP 기준, 총 에덴 도달까지 약 16개월
  static const List<String> levelNames = [
    '갈아엎은 땅',   // Lv1  - 시작
    '씨앗 심기',     // Lv2  - 관심
    '새싹',         // Lv3  - 초기 성장
    '뿌리 내림',     // Lv4  - 안정
    '자라는 나무',   // Lv5  - 이해
    '꽃 피움',       // Lv6  - 적용
    '열매 맺음',     // Lv7  - 습관
    '울창한 나무',   // Lv8  - 지속
    '작은 숲',       // Lv9  - 영향
    '에덴',         // Lv10 - 완성
  ];

  static const List<int> levelThresholds = [
    0,      // Lv1  갈아엎은 땅  — 시작
    100,    // Lv2  씨앗 심기    — ~3일      (Δ100)
    350,    // Lv3  새싹        — ~1주      (Δ250)
    750,    // Lv4  뿌리 내림   — ~2주      (Δ400)
    1400,   // Lv5  자라는 나무  — ~3주      (Δ650)
    2500,   // Lv6  꽃 피움     — ~1달      (Δ1100)
    4300,   // Lv7  열매 맺음   — ~1.5달    (Δ1800)
    7000,   // Lv8  울창한 나무  — ~2.5달    (Δ2700)
    11000,  // Lv9  작은 숲     — ~4달      (Δ4000)
    17000,  // Lv10 에덴        — ~5.5달    (Δ6000)
  ];

  // ─── 스트릭 마일스톤 ───
  static const Map<int, int> streakMilestoneRewards = {
    3: 10,
    7: 25,
    14: 50,
    30: 100,
    100: 300,
    365: 1000,
  };

  // ─── 루양 인사말 (시간대별) ───
  // 한국 시간(KST, UTC+9) 기준
  static const Map<String, List<String>> lambyGreetingsByTime = {
    'morning': [  // 06:00 ~ 11:59
      '좋은 아침이에요! 오늘도 말씀과 함께해요~',
      '상쾌한 아침이야! 말씀으로 하루를 시작하자~',
      '굿모닝! 오늘 하루도 주님과 동행해요!',
    ],
    'afternoon': [  // 12:00 ~ 17:59
      '점심 잘 먹었어? 잠깐 말씀 한 구절 어때?',
      '오후에도 힘내! 말씀이 힘이 되어줄 거야~',
      '반가워! 오늘은 어떤 말씀을 만날까?',
    ],
    'evening': [  // 18:00 ~ 21:59
      '오늘 하루 수고했어! 말씀으로 마무리하자~',
      '저녁이야~ 하루를 돌아보며 묵상해볼까?',
      '돌아왔구나! 함께 묵상하자~',
    ],
    'night': [  // 22:00 ~ 05:59
      '이 밤, 말씀과 함께 평안한 시간 보내요~',
      '조용한 밤이야. 주님과 대화해볼까?',
      '늦은 시간에도 찾아와줬구나! 고마워~',
    ],
  };

  /// 한국 시간 기준 시간대 인사말 반환
  static String getGreetingByTime() {
    // UTC+9 (한국 시간)
    final kstHour = DateTime.now().toUtc().add(const Duration(hours: 9)).hour;
    final String timeKey;
    if (kstHour >= 6 && kstHour < 12) {
      timeKey = 'morning';
    } else if (kstHour >= 12 && kstHour < 18) {
      timeKey = 'afternoon';
    } else if (kstHour >= 18 && kstHour < 22) {
      timeKey = 'evening';
    } else {
      timeKey = 'night';
    }
    final greetings = lambyGreetingsByTime[timeKey]!;
    final index = DateTime.now().day % greetings.length;
    return greetings[index];
  }

  // 하위 호환용
  static const List<String> lambyGreetings = [
    '좋은 아침이에요! 오늘도 말씀과 함께해요~',
    '반가워! 오늘은 어떤 말씀을 만날까?',
    '돌아왔구나! 함께 묵상하자~',
    '오늘 하루도 주님과 동행해요!',
    '에덴에 온 걸 환영해! 오늘도 파이팅!',
  ];

  // ─── 루양 격려말 ───
  static const List<String> lambyEncouragements = [
    '잘하고 있어! 계속 함께해~',
    '말씀이 마음에 심겨지고 있어!',
    '하나님이 기뻐하실 거야!',
    '오늘도 한 걸음 더 성장했어!',
    '나도 이 말씀 좋았어~ 함께 읽으니까 더 좋다!',
  ];

  // ─── 스트릭 끊김 위로 메시지 ───
  static const List<String> streakBreakComforts = [
    '괜찮아~ 하나님의 은혜는 새 날마다 새로워! 다시 시작하자!',
    '쉬어가는 것도 괜찮아. 에덴은 항상 여기 있어~',
    '포기하지 않은 것 자체가 대단해! 다시 함께하자~',
    '넘어져도 다시 일어나는 게 진짜 믿음이야!',
  ];

  // ─── Grace Day 메시지 ───
  static const String graceDayUsedMessage =
      '은혜의 날이 사용되었어요. 하루 쉬어가도 괜찮아~ 오늘도 함께해요!';

  // ─── 일일 퀘스트 ───
  static const List<Map<String, dynamic>> dailyQuests = [
    {
      'title': '오늘의 묵상 완료하기',
      'reward': 10,
      'type': 'lesson_complete',
    },
    {
      'title': '셀라 묵상 기록 남기기',
      'reward': 5,
      'type': 'selah_record',
    },
    {
      'title': '한 줄 기도 적기',
      'reward': 5,
      'type': 'prayer_record',
    },
  ];
}
