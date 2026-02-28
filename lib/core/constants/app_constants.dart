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
  static const List<String> levelNames = [
    '갈아엎은 땅', // 1
    '씨앗을 품은 땅', // 2
    '새싹이 돋는 땅', // 3
    '자라나는 밭', // 4
    '꽃피는 정원', // 5
    '열매 맺는 동산', // 6
    '좋은 땅', // 7
    '풍성한 밭', // 8
    '복된 동산', // 9
    '에덴 동산', // 10
  ];

  static const List<int> levelThresholds = [
    0, // Lv1
    100, // Lv2
    300, // Lv3
    600, // Lv4
    1000, // Lv5
    1500, // Lv6
    2200, // Lv7
    3000, // Lv8
    4000, // Lv9
    5500, // Lv10
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

  // ─── 램비 인사말 ───
  static const List<String> lambyGreetings = [
    '좋은 아침이에요! 오늘도 말씀과 함께해요~',
    '반가워! 오늘은 어떤 말씀을 만날까?',
    '돌아왔구나! 함께 묵상하자~',
    '오늘 하루도 주님과 동행해요!',
    '에덴에 온 걸 환영해! 오늘도 파이팅!',
  ];

  // ─── 램비 격려말 ───
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
