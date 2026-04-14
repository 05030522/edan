import '../models/quiz_question.dart';

/// 마가복음 퀴즈 데이터 (16단위 x 5문제 = 80문제)
class MarkQuizData {
  static const Map<int, QuizSet> quizSets = {
    // ━━━ Unit 30 → mark-lesson-1: 마가복음 1장 ━━━
    1: QuizSet(
      lessonId: 'mark-lesson-1',
      title: '마가복음 1장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-1-1',
          question: '세례 요한이 전한 메시지는 무엇인가?',
          options: ['율법을 지켜라', '회개하라', '기도하라', '금식하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-1-2',
          question: '예수께서 세례를 받으신 곳은 어디인가?',
          options: ['갈릴리', '요단강', '예루살렘', '사마리아'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-1-3',
          question: '세례 받을 때 하늘에서 들린 음성은 무엇인가?',
          options: ['기도하라', '내 사랑하는 아들이다', '순종하라', '회개하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-1-4',
          question: '예수께서 시험을 받으신 기간은 얼마인가?',
          options: ['7일', '40일', '3일', '12일'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-1-5',
          question: '예수께서 처음 제자들을 부르신 곳은 어디인가?',
          options: ['예루살렘', '갈릴리 해변', '광야', '성전'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 31 → mark-lesson-2: 마가복음 2장 ━━━
    2: QuizSet(
      lessonId: 'mark-lesson-2',
      title: '마가복음 2장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-2-1',
          question: '중풍병자를 데려온 사람들은 어떻게 했는가?',
          options: ['기다림', '지붕을 뜯음', '문을 두드림', '기도함'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-2-2',
          question: '예수께서 먼저 선포하신 것은 무엇인가?',
          options: ['치유', '죄 사함', '축복', '돈'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-2-3',
          question: '예수께서 부르신 세리는 누구인가?',
          options: ['베드로', '레위', '요한', '야고보'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-2-4',
          question: '금식에 대해 예수께서 하신 말씀은 무엇인가?',
          options: ['항상 해야 함', '신랑이 함께 있을 때는 하지 않음', '금지', '필요 없음'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-2-5',
          question: '안식일은 누구를 위해 있는가?',
          options: ['하나님', '사람', '제사장', '왕'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 32 → mark-lesson-3: 마가복음 3장 ━━━
    3: QuizSet(
      lessonId: 'mark-lesson-3',
      title: '마가복음 3장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-3-1',
          question: '안식일에 손 마른 사람을 고치신 이유는 무엇인가?',
          options: ['법', '선을 행하기 위해', '시험', '규칙'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-3-2',
          question: '예수를 따르던 무리는 어디서 왔는가?',
          options: ['한 지역', '여러 지역', '성전', '광야'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-3-3',
          question: '열두 제자를 세운 목적은 무엇인가?',
          options: ['통치', '함께 있게 하고 보내기 위해', '재물', '교육'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-3-4',
          question: '바알세불 논쟁에서 예수의 핵심 가르침은 무엇인가?',
          options: ['분쟁', '스스로 분쟁하면 망함', '권력', '힘'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-3-5',
          question: '예수의 가족은 누구라고 하셨는가?',
          options: ['혈통', '하나님의 뜻을 행하는 자', '제자', '유대인'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 33 → mark-lesson-4: 마가복음 4장 ━━━
    4: QuizSet(
      lessonId: 'mark-lesson-4',
      title: '마가복음 4장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-4-1',
          question: '씨 뿌리는 비유에서 좋은 땅은 무엇인가?',
          options: ['농부', '말씀을 듣고 받아들이는 사람', '씨앗', '물'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-4-2',
          question: '등불은 어디에 두어야 하는가?',
          options: ['숨김', '드러냄', '땅', '상자'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-4-3',
          question: '겨자씨 비유는 무엇을 설명하는가?',
          options: ['믿음', '하나님 나라', '재물', '기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-4-4',
          question: '제자들이 두려워한 이유는 무엇인가?',
          options: ['어둠', '풍랑', '배고픔', '적'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-4-5',
          question: '예수께서 바람을 꾸짖으시자 어떻게 되었는가?',
          options: ['더 강해짐', '잠잠해짐', '멈춤', '사라짐'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 34 → mark-lesson-5: 마가복음 5장 ━━━
    5: QuizSet(
      lessonId: 'mark-lesson-5',
      title: '마가복음 5장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-5-1',
          question: '귀신 들린 사람이 살던 곳은 어디인가?',
          options: ['성전', '무덤 사이', '집', '거리'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-5-2',
          question: '귀신의 이름은 무엇이었는가?',
          options: ['사탄', '군대', '악령', '바알'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-5-3',
          question: '귀신은 어디로 들어갔는가?',
          options: ['양', '돼지', '소', '사람'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-5-4',
          question: '혈루증 여인이 만진 것은 무엇인가?',
          options: ['손', '옷자락', '발', '머리'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-5-5',
          question: '야이로의 딸은 어떻게 되었는가?',
          options: ['병', '살아남', '죽었다가 살아남', '도망감'],
          correctIndex: 2,
        ),
      ],
    ),
    // ━━━ Unit 35 → mark-lesson-6: 마가복음 6장 ━━━
    6: QuizSet(
      lessonId: 'mark-lesson-6',
      title: '마가복음 6장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-6-1',
          question: '예수께서 고향에서 배척받은 이유는 무엇인가?',
          options: ['가난', '믿음 없음', '병', '거리'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-6-2',
          question: '열두 제자를 보내실 때 무엇을 금하셨는가?',
          options: ['신발', '지팡이 외에 아무것도', '음식', '옷'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-6-3',
          question: '세례 요한은 어떻게 죽임을 당했는가?',
          options: ['병', '참수', '전쟁', '사고'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-6-4',
          question: '예수께서 몇 명을 먹이셨는가?',
          options: ['3000명', '5000명', '7000명', '1000명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-6-5',
          question: '제자들이 떡 사건을 깨닫지 못한 이유는 무엇인가?',
          options: ['피곤', '마음이 둔함', '배고픔', '무지'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 36 → mark-lesson-7: 마가복음 7장 ━━━
    7: QuizSet(
      lessonId: 'mark-lesson-7',
      title: '마가복음 7장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-7-1',
          question: '사람을 더럽게 하는 것은 무엇인가?',
          options: ['음식', '마음에서 나오는 것', '손', '환경'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-7-2',
          question: '예수께서 책망하신 것은 무엇인가?',
          options: ['율법', '전통에 치우침', '기도', '금식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-7-3',
          question: '가나안 여인의 믿음은 어떻게 평가되었는가?',
          options: ['약함', '크다', '없음', '부족'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-7-4',
          question: '귀먹고 말 더듬는 사람을 어떻게 고치셨는가?',
          options: ['기도', '말씀으로', '손짓', '약'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-7-5',
          question: '"에바다"의 의미는 무엇인가?',
          options: ['닫혀라', '열려라', '치유', '평안'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 37 → mark-lesson-8: 마가복음 8장 ━━━
    8: QuizSet(
      lessonId: 'mark-lesson-8',
      title: '마가복음 8장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-8-1',
          question: '예수께서 몇 명을 또 먹이셨는가?',
          options: ['2000명', '4000명', '6000명', '8000명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-8-2',
          question: '바리새인들이 요구한 것은 무엇인가?',
          options: ['돈', '표적', '음식', '권세'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-8-3',
          question: '제자들이 떡을 걱정한 이유는 무엇인가?',
          options: ['부족', '믿음 부족', '돈 없음', '길 없음'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-8-4',
          question: '베드로는 예수를 누구라 고백했는가?',
          options: ['선지자', '그리스도', '왕', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-8-5',
          question: '예수께서 가르치신 제자의 삶은 무엇인가?',
          options: ['성공', '자기 부인', '안전', '부'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 38 → mark-lesson-9: 마가복음 9장 ━━━
    9: QuizSet(
      lessonId: 'mark-lesson-9',
      title: '마가복음 9장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-9-1',
          question: '변화산에서 나타난 인물은 누구인가?',
          options: ['아브라함', '모세와 엘리야', '다윗', '이사야'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-9-2',
          question: '하나님이 하신 말씀은 무엇인가?',
          options: ['순종하라', '내 사랑하는 아들이다', '기도하라', '기다려라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-9-3',
          question: '제자들이 귀신을 쫓지 못한 이유는 무엇인가?',
          options: ['힘 부족', '믿음 부족', '시간 부족', '지식 부족'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-9-4',
          question: '예수께서 강조하신 섬김의 태도는 무엇인가?',
          options: ['지배', '낮아짐', '경쟁', '힘'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-9-5',
          question: '가장 큰 자는 어떤 사람인가?',
          options: ['강한 자', '섬기는 자', '부자', '지식인'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 39 → mark-lesson-10: 마가복음 10장 ━━━
    10: QuizSet(
      lessonId: 'mark-lesson-10',
      title: '마가복음 10장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-10-1',
          question: '하나님이 짝지어 주신 것을 어떻게 하라고 하셨는가?',
          options: ['나누라', '나누지 말라', '바꾸라', '무시하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-10-2',
          question: '어린아이를 대하는 태도는 무엇인가?',
          options: ['무시', '받아들임', '제한', '훈계'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-10-3',
          question: '부자가 천국에 들어가기 어려운 이유는 무엇인가?',
          options: ['죄', '재물 집착', '약함', '무지'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-10-4',
          question: '인자가 온 목적은 무엇인가?',
          options: ['심판', '섬기고 생명을 주기', '통치', '교육'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-10-5',
          question: '맹인이 외친 말은 무엇인가?',
          options: ['도와달라', '다윗의 자손 예수여', '살려달라', '고쳐달라'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 40 → mark-lesson-11: 마가복음 11장 ━━━
    11: QuizSet(
      lessonId: 'mark-lesson-11',
      title: '마가복음 11장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-11-1',
          question: '예수께서 입성할 때 탄 것은 무엇인가?',
          options: ['말', '나귀', '수레', '낙타'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-11-2',
          question: '사람들이 외친 말은 무엇인가?',
          options: ['아멘', '호산나', '할렐루야', '찬양'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-11-3',
          question: '성전에서 하신 일은 무엇인가?',
          options: ['기도', '장사하는 자들을 내쫓음', '설교', '휴식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-11-4',
          question: '무화과나무를 저주한 이유는 무엇인가?',
          options: ['병', '열매 없음', '나이', '위치'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-11-5',
          question: '기도할 때 필요한 태도는 무엇인가?',
          options: ['의심', '믿음', '걱정', '두려움'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 41 → mark-lesson-12: 마가복음 12장 ━━━
    12: QuizSet(
      lessonId: 'mark-lesson-12',
      title: '마가복음 12장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-12-1',
          question: '포도원 농부 비유의 의미는 무엇인가?',
          options: ['농사', '거절된 아들', '재물', '노동'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-12-2',
          question: '가장 큰 계명은 무엇인가?',
          options: ['율법', '하나님 사랑', '제사', '금식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-12-3',
          question: '둘째 계명은 무엇인가?',
          options: ['규칙', '이웃 사랑', '헌금', '봉사'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-12-4',
          question: '가이사의 것은 누구에게 돌리라고 했는가?',
          options: ['하나님', '가이사', '왕', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-12-5',
          question: '가난한 과부의 헌금은 어떻게 평가되었는가?',
          options: ['적음', '가장 많음', '부족', '의미 없음'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 42 → mark-lesson-13: 마가복음 13장 ━━━
    13: QuizSet(
      lessonId: 'mark-lesson-13',
      title: '마가복음 13장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-13-1',
          question: '마지막 때의 징조 중 하나는 무엇인가?',
          options: ['평화', '전쟁', '안정', '풍요'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-13-2',
          question: '많은 사람이 어떻게 되는가?',
          options: ['성장', '미혹됨', '성공', '평안'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-13-3',
          question: '끝까지 견디는 자는 어떻게 되는가?',
          options: ['실패', '구원 받음', '고통', '심판'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-13-4',
          question: '인자의 오심은 무엇과 같다고 하셨는가?',
          options: ['비', '번개', '바람', '불'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-13-5',
          question: '깨어 있으라고 하신 이유는 무엇인가?',
          options: ['시간 알기', '때를 모르기 때문', '준비', '두려움'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 43 → mark-lesson-14: 마가복음 14장 ━━━
    14: QuizSet(
      lessonId: 'mark-lesson-14',
      title: '마가복음 14장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-14-1',
          question: '예수를 판 사람은 누구인가?',
          options: ['베드로', '가룟 유다', '요한', '야고보'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-14-2',
          question: '마지막 만찬에서 떡은 무엇을 의미하는가?',
          options: ['음식', '몸', '죄', '축복'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-14-3',
          question: '잔은 무엇을 의미하는가?',
          options: ['물', '피', '기쁨', '생명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-14-4',
          question: '베드로는 몇 번 부인했는가?',
          options: ['2번', '3번', '1번', '4번'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-14-5',
          question: '겟세마네에서 예수의 기도는 무엇이었는가?',
          options: ['승리', '아버지 뜻대로', '회피', '분노'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 44 → mark-lesson-15: 마가복음 15장 ━━━
    15: QuizSet(
      lessonId: 'mark-lesson-15',
      title: '마가복음 15장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-15-1',
          question: '예수를 재판한 총독은 누구인가?',
          options: ['헤롯', '빌라도', '가이사', '바울'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-15-2',
          question: '예수를 조롱할 때 씌운 것은 무엇인가?',
          options: ['왕관', '가시관', '모자', '천'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-15-3',
          question: '십자가에 달린 장소는 어디인가?',
          options: ['성전', '골고다', '갈릴리', '광야'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-15-4',
          question: '십자가 위에서 하신 말은 무엇인가?',
          options: ['감사합니다', '엘리 엘리 라마 사박다니', '할렐루야', '아멘'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-15-5',
          question: '성전 휘장은 어떻게 되었는가?',
          options: ['그대로', '찢어짐', '사라짐', '불탐'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 45 → mark-lesson-16: 마가복음 16장 ━━━
    16: QuizSet(
      lessonId: 'mark-lesson-16',
      title: '마가복음 16장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mkq-16-1',
          question: '무덤에 간 사람은 누구인가?',
          options: ['제자', '막달라 마리아', '베드로', '요한'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-16-2',
          question: '천사가 전한 소식은 무엇인가?',
          options: ['죽음', '부활', '심판', '전쟁'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-16-3',
          question: '제자들에게 주신 명령은 무엇인가?',
          options: ['숨으라', '복음을 전하라', '기다려라', '모이라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-16-4',
          question: '믿는 자들에게 따르는 표적은 무엇인가?',
          options: ['돈', '귀신을 쫓아냄', '권력', '명예'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mkq-16-5',
          question: '예수께서 어디로 올라가셨는가?',
          options: ['산', '하늘', '성전', '바다'],
          correctIndex: 1,
        ),
      ],
    ),
  };

  static QuizSet? getQuizForUnit(int unit) {
    return quizSets[unit];
  }

  static QuizSet getQuizForLesson(String lessonId) {
    final match = RegExp(r'mark-lesson-(\d+)').firstMatch(lessonId);
    if (match != null) {
      final unit = int.tryParse(match.group(1)!);
      if (unit != null && quizSets.containsKey(unit)) {
        return quizSets[unit]!;
      }
    }
    return quizSets.values.first;
  }
}
