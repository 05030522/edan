/// 주간 퀘스트 정의
///
/// id: 고유 식별자
/// title: 사용자에게 보여줄 제목
/// description: 상세 설명
/// conditionType: 진행 카운터 종류 (meditation_week, prayer_week, bible_week, perfect_day_week, all_task_week)
/// target: 달성 목표 값
/// rewardFp: 완료 시 보상 달란트
/// iconName: icon_helper.dart에서 매핑되는 아이콘 이름
class WeeklyQuestDef {
  final String id;
  final String title;
  final String description;
  final String conditionType;
  final int target;
  final int rewardFp;
  final String iconName;

  const WeeklyQuestDef({
    required this.id,
    required this.title,
    required this.description,
    required this.conditionType,
    required this.target,
    required this.rewardFp,
    required this.iconName,
  });
}

/// 주간 퀘스트 풀 (매주 이 중 3개가 랜덤 배정됨)
const kWeeklyQuestPool = <WeeklyQuestDef>[
  WeeklyQuestDef(
    id: 'wq_meditation_5',
    title: '말씀과 함께',
    description: '이번 주 묵상 5번 완료하기',
    conditionType: 'meditation_week',
    target: 5,
    rewardFp: 30,
    iconName: 'menu_book',
  ),
  WeeklyQuestDef(
    id: 'wq_meditation_7',
    title: '매일의 말씀',
    description: '이번 주 7일 모두 묵상하기',
    conditionType: 'meditation_week',
    target: 7,
    rewardFp: 60,
    iconName: 'menu_book',
  ),
  WeeklyQuestDef(
    id: 'wq_prayer_5',
    title: '기도의 손',
    description: '이번 주 기도 5번 올리기',
    conditionType: 'prayer_week',
    target: 5,
    rewardFp: 25,
    iconName: 'volunteer_activism',
  ),
  WeeklyQuestDef(
    id: 'wq_bible_5',
    title: '성경과 가까이',
    description: '이번 주 말씀 읽기 5번 완료',
    conditionType: 'bible_week',
    target: 5,
    rewardFp: 25,
    iconName: 'auto_stories',
  ),
  WeeklyQuestDef(
    id: 'wq_perfect_3',
    title: '경건의 습관',
    description: '이번 주 퍼펙트 데이 3회 달성',
    conditionType: 'perfect_day_week',
    target: 3,
    rewardFp: 50,
    iconName: 'emoji_events',
  ),
  WeeklyQuestDef(
    id: 'wq_perfect_5',
    title: '꾸준한 동행',
    description: '이번 주 퍼펙트 데이 5회 달성',
    conditionType: 'perfect_day_week',
    target: 5,
    rewardFp: 100,
    iconName: 'emoji_events',
  ),
  WeeklyQuestDef(
    id: 'wq_all_10',
    title: '활짝 피어나는 믿음',
    description: '이번 주 활동 총 10개 완료',
    conditionType: 'all_task_week',
    target: 10,
    rewardFp: 40,
    iconName: 'spa',
  ),
];

WeeklyQuestDef? findQuestDef(String id) {
  for (final q in kWeeklyQuestPool) {
    if (q.id == id) return q;
  }
  return null;
}
