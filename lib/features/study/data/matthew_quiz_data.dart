import '../models/quiz_question.dart';

/// 마태복음 퀴즈 데이터 (29단위 x 5문제 = 145문제) - xlsx에서 자동 생성
class MatthewQuizData {
  static const Map<int, QuizSet> quizSets = {
    1: QuizSet(
      lessonId: 'matthew-lesson-1',
      title: '마태복음 1장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-1-1',
          question: '예수 그리스도는 누구의 자손으로 소개되는가?',
          options: ['모세와 아론', '아브라함과 다윗', '이삭과 야곱', '요셉과 엘리'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-1-2',
          question: '다말에게서 태어난 인물은 누구인가?',
          options: ['헤스론', '베레스와 세라', '보아스', '오벳'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-1-3',
          question: '보아스는 누구에게서 오벳을 낳았는가?',
          options: ['라합', '룻', '마리아', '다말'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-1-4',
          question: '다음 중 다윗 이후 계보에 포함되지 않는 인물은 누구인가?',
          options: ['솔로몬', '모세', '르호보암', '요셉'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-1-5',
          question: '전체 계보는 어떻게 구분되는가?',
          options: ['10대씩 세 구간', '14대씩 세 구간', '12대씩 세 구간', '7대씩 여섯 구간'],
          correctIndex: 1,
        ),
      ],
    ),
    2: QuizSet(
      lessonId: 'matthew-lesson-2',
      title: '마태복음 1장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-2-1',
          question: '마리아는 누구와 정혼한 상태였는가?',
          options: ['베드로', '요셉', '요한', '야고보'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-2-2',
          question: '마리아의 잉태는 어떻게 이루어졌는가?',
          options: ['사람의 방법으로', '성령으로', '꿈으로', '우연히'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-2-3',
          question: '요셉이 처음에 하려고 했던 행동은 무엇인가?',
          options: ['공개적으로 고발한다', '조용히 관계를 끊으려 한다', '바로 결혼한다', '도망간다'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-2-4',
          question: '천사가 요셉에게 전한 아기의 이름은 무엇인가?',
          options: ['임마누엘', '예수', '다윗', '엘리야'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-2-5',
          question: '“임마누엘”의 의미는 무엇인가?',
          options: ['하나님이 심판하신다', '하나님이 우리와 함께 계신다', '하나님이 멀리 계신다', '하나님이 침묵하신다'],
          correctIndex: 1,
        ),
      ],
    ),
    3: QuizSet(
      lessonId: 'matthew-lesson-3',
      title: '마태복음 2장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-3-1',
          question: '동방 박사들이 예수님을 찾아온 이유는 무엇인가?',
          options: ['왕을 보기 위해', '경배하기 위해', '여행 중에', '명령을 받아서'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-3-2',
          question: '헤롯 왕이 예수님의 탄생 소식을 듣고 보인 반응은 무엇인가?',
          options: ['기뻐했다', '두려워하고 소동했다', '무시했다', '축하했다'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-3-3',
          question: '박사들이 예수님께 드린 것이 아닌 것은 무엇인가?',
          options: ['황금', '은', '유향', '몰약'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-3-4',
          question: '하나님은 박사들에게 무엇을 통해 헤롯에게 돌아가지 말라고 알려주셨는가?',
          options: ['편지', '꿈', '천사 직접 방문', '사람'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-3-5',
          question: '요셉이 가족을 데리고 피한 곳은 어디인가?',
          options: ['갈릴리', '애굽', '사마리아', '예루살렘'],
          correctIndex: 1,
        ),
      ],
    ),
    4: QuizSet(
      lessonId: 'matthew-lesson-4',
      title: '마태복음 3장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-4-1',
          question: '세례 요한이 전한 핵심 메시지는 무엇인가?',
          options: ['율법을 지켜라', '회개하라 천국이 가까이 왔다', '기도하라', '제사를 드려라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-4-2',
          question: '세례 요한은 어디에서 사역을 했는가?',
          options: ['예루살렘 성전', '유대 광야', '갈릴리', '사마리아'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-4-3',
          question: '세례 요한이 강조한 것은 무엇인가?',
          options: ['형식적인 신앙', '회개의 열매', '제사', '혈통'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-4-4',
          question: '세례 요한이 말한 자신보다 크신 분은 누구인가?',
          options: ['모세', '예수님', '다윗', '엘리야'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-4-5',
          question: '예수님이 세례를 받으신 이유는 무엇인가?',
          options: ['사람들에게 보이기 위해', '모든 의를 이루기 위해', '죄를 씻기 위해', '요한을 돕기 위해'],
          correctIndex: 1,
        ),
      ],
    ),
    5: QuizSet(
      lessonId: 'matthew-lesson-5',
      title: '마태복음 4장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-5-1',
          question: '예수께서 시험을 받기 위해 어디로 이끌리셨는가?',
          options: ['갈릴리', '광야', '예루살렘', '베들레헴'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-5-2',
          question: '예수께서 금식하신 기간은 얼마인가?',
          options: ['7일', '40일', '3일', '12일'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-5-3',
          question: '마귀가 돌들로 무엇이 되게 하라고 시험했는가?',
          options: ['물', '떡', '금', '나무'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-5-4',
          question: '마귀가 예수를 어디로 데려가 성전 꼭대기에 세웠는가?',
          options: ['갈릴리', '예루살렘', '나사렛', '사마리아'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-5-5',
          question: '예수께서 처음으로 제자들을 부르신 곳은 어디인가?',
          options: ['요단강', '갈릴리 해변', '광야', '예루살렘 성전'],
          correctIndex: 1,
        ),
      ],
    ),
    6: QuizSet(
      lessonId: 'matthew-lesson-6',
      title: '마태복음 5장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-6-1',
          question: '예수께서 산에서 가르치신 설교는 무엇이라 불리는가?',
          options: ['평지 설교', '산상수훈', '성전 설교', '광야 설교'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-6-2',
          question: '심령이 가난한 자는 무엇을 소유한다고 하셨는가?',
          options: ['땅', '천국', '재물', '명예'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-6-3',
          question: '온유한 자는 무엇을 받을 것이라 하셨는가?',
          options: ['하늘', '땅', '권력', '지혜'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-6-4',
          question: '예수께서 제자들을 무엇에 비유하셨는가?',
          options: ['불', '세상의 소금', '물', '돌'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-6-5',
          question: '원수를 어떻게 대하라고 가르치셨는가?',
          options: ['피하라', '사랑하라', '무시하라', '벌하라'],
          correctIndex: 1,
        ),
      ],
    ),
    7: QuizSet(
      lessonId: 'matthew-lesson-7',
      title: '마태복음 6장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-7-1',
          question: '구제할 때 어떻게 하라고 하셨는가?',
          options: ['알리라', '은밀하게 하라', '크게 외쳐라', '기록하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-7-2',
          question: '기도할 때 어떻게 하라고 하셨는가?',
          options: ['길거리에서', '골방에서', '성전에서만', '크게'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-7-3',
          question: '예수께서 가르치신 기도의 이름은 무엇인가?',
          options: ['왕의 기도', '주기도문', '감사기도', '축복기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-7-4',
          question: '무엇을 먼저 구하라고 하셨는가?',
          options: ['돈', '하나님 나라와 의', '건강', '성공'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-7-5',
          question: '내일 일을 어떻게 하라고 하셨는가?',
          options: ['계획하라', '염려하지 말라', '준비하라', '기록하라'],
          correctIndex: 1,
        ),
      ],
    ),
    8: QuizSet(
      lessonId: 'matthew-lesson-8',
      title: '마태복음 7장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-8-1',
          question: '남을 판단하기 전에 먼저 해야 할 것은 무엇인가?',
          options: ['말하기', '자신을 돌아보기', '기도하기', '떠나기'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-8-2',
          question: '구하는 자는 어떻게 된다고 하셨는가?',
          options: ['실패한다', '받는다', '기다린다', '잃는다'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-8-3',
          question: '좁은 문으로 들어가야 하는 이유는 무엇인가?',
          options: ['쉽기 때문에', '생명으로 인도하기 때문에', '넓기 때문에', '안전해서'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-8-4',
          question: '좋은 나무는 무엇을 맺는가?',
          options: ['잎', '좋은 열매', '꽃', '씨앗'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-8-5',
          question: '반석 위에 집을 지은 사람은 무엇을 의미하는가?',
          options: ['부자', '말씀을 듣고 행하는 사람', '제사장', '왕'],
          correctIndex: 1,
        ),
      ],
    ),
    9: QuizSet(
      lessonId: 'matthew-lesson-9',
      title: '마태복음 8장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-9-1',
          question: '예수께서 고치신 나병 환자는 무엇을 받았는가?',
          options: ['돈', '깨끗함', '명예', '집'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-9-2',
          question: '백부장의 믿음은 무엇으로 칭찬받았는가?',
          options: ['행위', '큰 믿음', '지식', '재물'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-9-3',
          question: '예수께서 바다를 잔잔하게 하신 것은 무엇인가?',
          options: ['기도', '말씀', '손짓', '바람'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-9-4',
          question: '귀신 들린 자들이 있던 곳은 어디인가?',
          options: ['성전', '거라사', '갈릴리', '사마리아'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-9-5',
          question: '귀신들은 어디로 들어갔는가?',
          options: ['양', '돼지', '소', '사람'],
          correctIndex: 1,
        ),
      ],
    ),
    10: QuizSet(
      lessonId: 'matthew-lesson-10',
      title: '마태복음 9장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-10-1',
          question: '중풍병자에게 먼저 선포된 것은 무엇인가?',
          options: ['치유', '죄 사함', '축복', '돈'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-10-2',
          question: '예수께서 부르신 세리는 누구인가?',
          options: ['베드로', '마태', '요한', '야고보'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-10-3',
          question: '새 포도주는 어디에 담아야 하는가?',
          options: ['낡은 부대', '새 부대', '병', '그릇'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-10-4',
          question: '혈루증 여인은 무엇을 만졌는가?',
          options: ['손', '옷자락', '발', '얼굴'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-10-5',
          question: '예수께서 보신 무리는 무엇과 같다고 하셨는가?',
          options: ['군대', '목자 없는 양', '나무', '강'],
          correctIndex: 1,
        ),
      ],
    ),
    11: QuizSet(
      lessonId: 'matthew-lesson-11',
      title: '마태복음 10장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-11-1',
          question: '예수께서 제자들에게 주신 권세는 무엇인가?',
          options: ['병 고치는 능력', '더러운 영을 쫓아내는 권세', '재물 얻는 능력', '통치 권세'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-11-2',
          question: '열두 제자를 파송하며 어디로 가지 말라고 하셨는가?',
          options: ['유대', '이방인의 길', '갈릴리', '사마리아'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-11-3',
          question: '제자들이 전해야 할 메시지는 무엇인가?',
          options: ['회개하라', '천국이 가까이 왔다', '율법을 지켜라', '기도하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-11-4',
          question: '박해를 받을 때 어떻게 하라고 하셨는가?',
          options: ['싸우라', '피하라', '숨으라', '포기하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-11-5',
          question: '몸은 죽여도 무엇은 죽이지 못한다고 하셨는가?',
          options: ['마음', '영혼', '생각', '믿음'],
          correctIndex: 1,
        ),
      ],
    ),
    12: QuizSet(
      lessonId: 'matthew-lesson-12',
      title: '마태복음 11장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-12-1',
          question: '세례 요한은 누구에 대해 질문했는가?',
          options: ['엘리야', '예수님', '모세', '다윗'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-12-2',
          question: '예수께서 세례 요한을 무엇이라 부르셨는가?',
          options: ['왕', '선지자', '제사장', '제자'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-12-3',
          question: '예수께서 “수고하고 무거운 짐 진 자들아”라고 부르신 이유는 무엇인가?',
          options: ['심판하려고', '쉬게 하려고', '시험하려고', '벌하려고'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-12-4',
          question: '예수의 멍에는 어떠하다고 하셨는가?',
          options: ['무겁다', '쉽다', '어렵다', '위험하다'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-12-5',
          question: '예수의 짐은 어떠하다고 하셨는가?',
          options: ['크다', '가볍다', '무겁다', '복잡하다'],
          correctIndex: 1,
        ),
      ],
    ),
    13: QuizSet(
      lessonId: 'matthew-lesson-13',
      title: '마태복음 12장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-13-1',
          question: '안식일의 주인은 누구라고 하셨는가?',
          options: ['모세', '인자', '다윗', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-13-2',
          question: '바리새인들이 예수를 비난한 이유는 무엇인가?',
          options: ['기도 안 해서', '안식일에 일해서', '율법을 몰라서', '세금을 안 내서'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-13-3',
          question: '더러운 귀신이 나갔다가 다시 돌아오는 이유는 무엇인가?',
          options: ['기도 때문', '빈 집 상태', '병 때문', '죄 때문'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-13-4',
          question: '예수의 형제와 어머니는 누구라고 하셨는가?',
          options: ['가족', '하나님의 뜻을 행하는 자', '제자', '유대인'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-13-5',
          question: '나무는 무엇으로 알 수 있다고 하셨는가?',
          options: ['잎', '열매', '뿌리', '색'],
          correctIndex: 1,
        ),
      ],
    ),
    14: QuizSet(
      lessonId: 'matthew-lesson-14',
      title: '마태복음 13장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-14-1',
          question: '씨 뿌리는 비유에서 좋은 땅은 무엇을 의미하는가?',
          options: ['농부', '말씀을 듣고 깨닫는 사람', '씨앗', '물'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-14-2',
          question: '겨자씨 비유는 무엇을 설명하는가?',
          options: ['믿음', '천국', '사랑', '율법'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-14-3',
          question: '누룩 비유는 무엇을 의미하는가?',
          options: ['죄', '천국의 확장', '재물', '시험'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-14-4',
          question: '밭에 감추인 보화는 무엇과 같은가?',
          options: ['재물', '천국', '집', '사람'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-14-5',
          question: '좋은 물고기는 어떻게 처리되는가?',
          options: ['버린다', '모은다', '나눈다', '숨긴다'],
          correctIndex: 1,
        ),
      ],
    ),
    15: QuizSet(
      lessonId: 'matthew-lesson-15',
      title: '마태복음 14장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-15-1',
          question: '세례 요한은 어떻게 죽임을 당했는가?',
          options: ['병', '참수', '전쟁', '사고'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-15-2',
          question: '예수께서 오병이어로 먹이신 사람 수는?',
          options: ['1000명', '5000명', '3000명', '7000명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-15-3',
          question: '베드로가 물 위를 걷다가 빠진 이유는 무엇인가?',
          options: ['바람', '믿음이 적어서', '피곤해서', '배고파서'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-15-4',
          question: '예수께서 물 위를 걸으신 시간은 언제인가?',
          options: ['낮', '밤 사경', '아침', '저녁'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-15-5',
          question: '사람들이 예수의 옷자락만 만져도 어떻게 되었는가?',
          options: ['피곤해짐', '나음', '넘어짐', '울음'],
          correctIndex: 1,
        ),
      ],
    ),
    16: QuizSet(
      lessonId: 'matthew-lesson-16',
      title: '마태복음 15장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-16-1',
          question: '사람을 더럽게 하는 것은 무엇인가?',
          options: ['음식', '마음에서 나오는 것', '손', '환경'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-16-2',
          question: '가나안 여인의 믿음은 어떻게 평가되었는가?',
          options: ['약하다', '크다', '없다', '부족하다'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-16-3',
          question: '예수께서 또 몇 명을 먹이셨는가?',
          options: ['2000명', '4000명', '6000명', '8000명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-16-4',
          question: '제자들이 떡을 걱정했을 때 예수께서 책망하신 이유는?',
          options: ['게을러서', '믿음이 적어서', '돈이 없어서', '몰라서'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-16-5',
          question: '바리새인의 누룩은 무엇을 의미하는가?',
          options: ['음식', '잘못된 가르침', '축복', '기도'],
          correctIndex: 1,
        ),
      ],
    ),
    17: QuizSet(
      lessonId: 'matthew-lesson-17',
      title: '마태복음 16장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-17-1',
          question: '바리새인과 사두개인이 구한 것은 무엇인가?',
          options: ['기적', '표적', '말씀', '율법'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-17-2',
          question: '예수께서 경계하라고 하신 누룩은 무엇인가?',
          options: ['음식', '바리새인과 사두개인의 가르침', '재물', '권력'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-17-3',
          question: '베드로는 예수를 누구라 고백했는가?',
          options: ['선지자', '그리스도', '왕', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-17-4',
          question: '예수께서 교회를 세우겠다고 하신 반석은 무엇인가?',
          options: ['건물', '베드로의 신앙 고백', '율법', '성전'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-17-5',
          question: '자기 십자가를 지고 따르라는 의미는 무엇인가?',
          options: ['고통 회피', '자기 부인', '성공 추구', '안전 추구'],
          correctIndex: 1,
        ),
      ],
    ),
    18: QuizSet(
      lessonId: 'matthew-lesson-18',
      title: '마태복음 17장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-18-1',
          question: '변화산에서 함께 나타난 인물은 누구인가?',
          options: ['아브라함', '모세와 엘리야', '다윗', '이사야'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-18-2',
          question: '하나님이 하신 말씀은 무엇인가?',
          options: ['들어라', '이는 내 사랑하는 아들이다', '기도하라', '순종하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-18-3',
          question: '제자들이 귀신을 쫓아내지 못한 이유는 무엇인가?',
          options: ['힘 부족', '믿음 부족', '시간 부족', '지식 부족'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-18-4',
          question: '겨자씨만한 믿음은 무엇을 할 수 있는가?',
          options: ['돈을 벌게 한다', '산을 옮긴다', '병을 낫게 한다', '길을 만든다'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-18-5',
          question: '성전세를 낸 방법은 무엇인가?',
          options: ['돈 빌림', '물고기 입에서 동전', '기도', '헌금'],
          correctIndex: 1,
        ),
      ],
    ),
    19: QuizSet(
      lessonId: 'matthew-lesson-19',
      title: '마태복음 18장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-19-1',
          question: '천국에서 큰 자는 누구인가?',
          options: ['강한 자', '어린아이 같은 자', '부자', '지식 있는 자'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-19-2',
          question: '잃은 양 비유에서 목자의 행동은 무엇인가?',
          options: ['포기', '찾는다', '기다린다', '팔아버린다'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-19-3',
          question: '형제가 죄를 범하면 어떻게 해야 하는가?',
          options: ['무시', '권면', '벌', '공개'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-19-4',
          question: '몇 번까지 용서하라고 하셨는가?',
          options: ['3번', '70번씩 7번', '10번', '무제한'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-19-5',
          question: '일만 달란트 빚진 자 비유의 핵심은 무엇인가?',
          options: ['돈', '용서', '법', '심판'],
          correctIndex: 1,
        ),
      ],
    ),
    20: QuizSet(
      lessonId: 'matthew-lesson-20',
      title: '마태복음 19장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-20-1',
          question: '하나님이 짝지어 주신 것을 어떻게 하라고 하셨는가?',
          options: ['나누라', '나누지 말라', '바꾸라', '무시하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-20-2',
          question: '어린아이를 대하는 태도는 무엇인가?',
          options: ['무시', '받아들임', '제한', '훈계'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-20-3',
          question: '부자가 천국에 들어가기 어려운 이유는 무엇인가?',
          options: ['죄 때문', '재물 집착', '약함', '무지'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-20-4',
          question: '낙타가 어디로 들어가는 것이 더 쉽다고 하셨는가?',
          options: ['문', '바늘귀', '집', '길'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-20-5',
          question: '마지막이 먼저 되고 먼저가 마지막 된다는 의미는 무엇인가?',
          options: ['순서 변화', '하나님 나라의 역전', '경쟁', '시간'],
          correctIndex: 1,
        ),
      ],
    ),
    21: QuizSet(
      lessonId: 'matthew-lesson-21',
      title: '마태복음 20장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-21-1',
          question: '포도원 품꾼 비유의 핵심은 무엇인가?',
          options: ['노력', '은혜', '시간', '계약'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-21-2',
          question: '마지막에 온 자들도 무엇을 받았는가?',
          options: ['적은 임금', '동일한 임금', '벌', '칭찬'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-21-3',
          question: '예수께서 섬김에 대해 하신 말씀은 무엇인가?',
          options: ['지배하라', '섬겨라', '명령하라', '피하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-21-4',
          question: '인자가 온 목적은 무엇인가?',
          options: ['심판', '섬기고 생명을 주기', '통치', '가르침'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-21-5',
          question: '맹인 두 사람이 무엇을 외쳤는가?',
          options: ['도와달라', '다윗의 자손이여', '살려달라', '고쳐달라'],
          correctIndex: 1,
        ),
      ],
    ),
    22: QuizSet(
      lessonId: 'matthew-lesson-22',
      title: '마태복음 21장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-22-1',
          question: '예수께서 예루살렘에 입성할 때 탄 것은 무엇인가?',
          options: ['말', '나귀', '수레', '낙타'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-22-2',
          question: '사람들이 외친 말은 무엇인가?',
          options: ['할렐루야', '호산나', '아멘', '찬양'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-22-3',
          question: '예수께서 성전에서 하신 일은 무엇인가?',
          options: ['기도', '장사하는 자들을 내쫓음', '설교', '휴식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-22-4',
          question: '무화과나무를 저주하신 이유는 무엇인가?',
          options: ['병', '열매 없음', '나이', '위치'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-22-5',
          question: '권위에 대해 질문받았을 때 예수의 반응은 무엇인가?',
          options: ['답함', '되묻기', '침묵', '화냄'],
          correctIndex: 1,
        ),
      ],
    ),
    23: QuizSet(
      lessonId: 'matthew-lesson-23',
      title: '마태복음 22장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-23-1',
          question: '혼인 잔치 비유에서 초대받고 오지 않은 이유는?',
          options: ['병', '거절', '가난', '거리'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-23-2',
          question: '가장 큰 계명은 무엇인가?',
          options: ['율법', '하나님 사랑', '제사', '기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-23-3',
          question: '둘째 계명은 무엇인가?',
          options: ['규칙', '이웃 사랑', '봉사', '헌금'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-23-4',
          question: '가이사의 것은 누구에게 돌리라고 했는가?',
          options: ['하나님', '가이사', '왕', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-23-5',
          question: '부활에 대해 설명하며 강조한 것은 무엇인가?',
          options: ['죽음', '살아있는 하나님', '율법', '심판'],
          correctIndex: 1,
        ),
      ],
    ),
    24: QuizSet(
      lessonId: 'matthew-lesson-24',
      title: '마태복음 23장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-24-1',
          question: '바리새인들의 문제는 무엇인가?',
          options: ['가난', '위선', '무지', '약함'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-24-2',
          question: '그들은 무엇은 지키지만 중요한 것은 버렸는가?',
          options: ['기도', '정의와 긍휼', '제사', '금식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-24-3',
          question: '예수께서 그들을 무엇에 비유하셨는가?',
          options: ['나무', '회칠한 무덤', '돌', '집'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-24-4',
          question: '그들의 행동 특징은 무엇인가?',
          options: ['숨김', '보이려 함', '단순함', '침묵'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-24-5',
          question: '가장 큰 자는 어떻게 되어야 하는가?',
          options: ['높아짐', '섬기는 자', '부자', '강한 자'],
          correctIndex: 1,
        ),
      ],
    ),
    25: QuizSet(
      lessonId: 'matthew-lesson-25',
      title: '마태복음 24장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-25-1',
          question: '마지막 때의 징조 중 하나는 무엇인가?',
          options: ['평화', '전쟁', '안정', '풍요'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-25-2',
          question: '많은 사람이 어떻게 된다고 하셨는가?',
          options: ['믿음 유지', '미혹됨', '성공', '성장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-25-3',
          question: '끝까지 견디는 자는 어떻게 되는가?',
          options: ['실패', '구원 받음', '고통', '심판'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-25-4',
          question: '인자의 오심은 무엇과 같다고 하셨는가?',
          options: ['비', '번개', '바람', '불'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-25-5',
          question: '깨어 있으라고 하신 이유는 무엇인가?',
          options: ['시간 알기', '때를 모르기 때문', '준비', '두려움'],
          correctIndex: 1,
        ),
      ],
    ),
    26: QuizSet(
      lessonId: 'matthew-lesson-26',
      title: '마태복음 25장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-26-1',
          question: '열 처녀 비유에서 슬기로운 처녀의 특징은 무엇인가?',
          options: ['등', '기름 준비', '옷', '돈'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-26-2',
          question: '달란트 비유에서 칭찬받은 이유는 무엇인가?',
          options: ['숨김', '활용함', '보관', '잃음'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-26-3',
          question: '게으른 종의 문제는 무엇인가?',
          options: ['부족', '두려움으로 숨김', '무지', '가난'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-26-4',
          question: '양과 염소 비유의 기준은 무엇인가?',
          options: ['믿음', '행함', '지식', '기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-26-5',
          question: '작은 자에게 한 것이 곧 누구에게 한 것인가?',
          options: ['사람', '예수님', '제자', '왕'],
          correctIndex: 1,
        ),
      ],
    ),
    27: QuizSet(
      lessonId: 'matthew-lesson-27',
      title: '마태복음 26장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-27-1',
          question: '예수를 판 사람은 누구인가?',
          options: ['베드로', '가룟 유다', '요한', '야고보'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-27-2',
          question: '마지막 만찬에서 떡은 무엇을 의미하는가?',
          options: ['음식', '몸', '죄', '축복'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-27-3',
          question: '잔은 무엇을 의미하는가?',
          options: ['물', '피', '기쁨', '생명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-27-4',
          question: '베드로는 몇 번 부인했는가?',
          options: ['2번', '3번', '1번', '4번'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-27-5',
          question: '겟세마네에서 예수의 기도 내용은 무엇인가?',
          options: ['승리', '아버지 뜻대로', '회피', '분노'],
          correctIndex: 1,
        ),
      ],
    ),
    28: QuizSet(
      lessonId: 'matthew-lesson-28',
      title: '마태복음 27장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-28-1',
          question: '예수를 재판한 총독은 누구인가?',
          options: ['헤롯', '빌라도', '가이사', '바울'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-28-2',
          question: '군인들이 예수를 무엇으로 조롱했는가?',
          options: ['옷', '가시관', '돌', '물'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-28-3',
          question: '예수가 십자가를 지고 간 곳은 어디인가?',
          options: ['성전', '골고다', '갈릴리', '광야'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-28-4',
          question: '십자가 위에서 하신 말은 무엇인가?',
          options: ['감사합니다', '엘리 엘리 라마 사박다니', '할렐루야', '아멘'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-28-5',
          question: '예수의 죽음 후 성전 휘장은 어떻게 되었는가?',
          options: ['그대로', '찢어짐', '사라짐', '불탐'],
          correctIndex: 1,
        ),
      ],
    ),
    29: QuizSet(
      lessonId: 'matthew-lesson-29',
      title: '마태복음 28장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'mq-29-1',
          question: '무덤에 처음 간 사람은 누구인가?',
          options: ['제자', '막달라 마리아', '베드로', '요한'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-29-2',
          question: '천사는 무엇을 알렸는가?',
          options: ['죽음', '부활', '심판', '전쟁'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-29-3',
          question: '제자들에게 주신 명령은 무엇인가?',
          options: ['모이라', '모든 민족을 제자로 삼으라', '기다려라', '숨으라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-29-4',
          question: '세례는 무엇의 이름으로 주라고 하셨는가?',
          options: ['하나님', '성부 성자 성령', '예수', '성령'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'mq-29-5',
          question: '예수께서 항상 함께 하신다고 하신 기간은 언제까지인가?',
          options: ['하루', '세상 끝날까지', '1년', '평생'],
          correctIndex: 1,
        ),
      ],
    ),
  };

  static QuizSet? getQuizForUnit(int unit) => quizSets[unit];

  static QuizSet getQuizForLesson(String lessonId) {
    final match = RegExp(r'matthew-lesson-(\d+)').firstMatch(lessonId);
    if (match != null) {
      final unit = int.tryParse(match.group(1)!);
      if (unit != null && quizSets.containsKey(unit)) {
        return quizSets[unit]!;
      }
    }
    return quizSets.values.first;
  }
}
