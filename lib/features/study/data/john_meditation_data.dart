import '../models/lesson_data.dart';

/// 요한복음 묵상 데이터 (1~2장 반영, 나머지 장은 준비 중)
class JohnMeditationData {
  static const List<LessonContent> lessons = [
    LessonContent(
      lessonId: 'john-lesson-1',
      pathId: 'path-john',
      title: '말씀이신 예수님과 빛',
      scriptureReference: '요한복음 1장',
      scriptureText:
          '요한복음은 예수님을 "말씀"으로 소개하며 시작해요. '
          '이 말씀은 하나님과 함께 계셨고 곧 하나님이셨어요. '
          '예수님은 세상의 빛으로 오셨지만 사람들은 그 빛을 알아보지 못했어요. '
          '그러나 예수님을 영접한 사람들에게는 하나님의 자녀가 되는 권세가 주어져요. '
          '이 장은 예수님이 누구신지와 그분을 받아들이는 것이 얼마나 중요한지를 보여줘요.',
      meditationGuide: '나는 예수님을 진짜 받아들이고 있나요?',
    ),
    LessonContent(
      lessonId: 'john-lesson-2',
      pathId: 'path-john',
      title: '변화와 참된 예배',
      scriptureReference: '요한복음 2장',
      scriptureText:
          '예수님은 가나의 혼인잔치에서 물을 포도주로 바꾸시는 첫 기적을 행하세요. '
          '이를 통해 예수님의 영광이 드러나고 제자들이 믿게 돼요. '
          '또한 성전을 깨끗하게 하시며 하나님을 향한 참된 예배를 강조하세요. '
          '사람들은 표적을 보고 믿으려 하지만 예수님은 중심을 보세요. '
          '이 장은 변화와 예배의 본질을 보여줘요.',
      meditationGuide: '나는 하나님이 주시는 변화를 경험하고 있나요?',
    ),
  ];
}
