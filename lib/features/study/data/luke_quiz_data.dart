import '../models/quiz_question.dart';

/// 누가복음 퀴즈 데이터 (24단위 x 5문제 = 120문제)
class LukeQuizData {
  static const Map<int, QuizSet> quizSets = {
    // ━━━ Unit 45: 누가복음 1장 ━━━
    45: QuizSet(
      lessonId: 'luke-lesson-1',
      title: '누가복음 1장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-1-1',
          question: '누가복음은 누구에게 보내진 글인가?',
          options: ['바울', '데오빌로', '베드로', '요한'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-1-2',
          question: '세례 요한의 아버지는 누구인가?',
          options: ['요셉', '사가랴', '엘리', '아론'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-1-3',
          question: '마리아에게 나타난 천사는 누구인가?',
          options: ['미가엘', '가브리엘', '라파엘', '천사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-1-4',
          question: '예수의 이름은 누가 알려주었는가?',
          options: ['요셉', '천사', '마리아', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-1-5',
          question: '마리아의 찬가는 무엇이라 불리는가?',
          options: ['시편', '마그니피캇', '찬송', '기도'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 46: 누가복음 2장 ━━━
    46: QuizSet(
      lessonId: 'luke-lesson-2',
      title: '누가복음 2장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-2-1',
          question: '예수께서 태어나신 곳은 어디인가?',
          options: ['나사렛', '베들레헴', '예루살렘', '갈릴리'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-2-2',
          question: '목자들에게 나타난 것은 무엇인가?',
          options: ['별', '천사', '왕', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-2-3',
          question: '시므온은 예수를 무엇이라 고백했는가?',
          options: ['왕', '구원', '선지자', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-2-4',
          question: '안나는 무엇을 하던 사람이었는가?',
          options: ['농부', '선지자', '상인', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-2-5',
          question: '어린 예수는 어디에서 성장하셨는가?',
          options: ['예루살렘', '나사렛', '갈릴리', '사마리아'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 47: 누가복음 3장 ━━━
    47: QuizSet(
      lessonId: 'luke-lesson-3',
      title: '누가복음 3장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-3-1',
          question: '세례 요한의 메시지는 무엇인가?',
          options: ['율법', '회개', '기도', '금식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-3-2',
          question: '세례 요한은 어디에서 사역했는가?',
          options: ['성전', '광야', '갈릴리', '사마리아'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-3-3',
          question: '무리에게 요구한 것은 무엇인가?',
          options: ['제사', '삶의 변화', '돈', '지식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-3-4',
          question: '예수께서 세례를 받을 때 하늘에서 들린 음성은 무엇인가?',
          options: ['기도하라', '내 사랑하는 아들이다', '순종하라', '기다려라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-3-5',
          question: '예수의 족보는 누구까지 거슬러 올라가는가?',
          options: ['아브라함', '아담', '다윗', '모세'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 48: 누가복음 4장 ━━━
    48: QuizSet(
      lessonId: 'luke-lesson-4',
      title: '누가복음 4장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-4-1',
          question: '예수께서 시험을 받으신 곳은 어디인가?',
          options: ['성전', '광야', '갈릴리', '사마리아'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-4-2',
          question: '시험 기간은 얼마인가?',
          options: ['7일', '40일', '3일', '12일'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-4-3',
          question: '나사렛 회당에서 읽으신 것은 무엇인가?',
          options: ['시편', '이사야서', '창세기', '출애굽기'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-4-4',
          question: '예수께서 선언하신 사명은 무엇인가?',
          options: ['통치', '복음 전파', '심판', '전쟁'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-4-5',
          question: '사람들의 반응은 어땠는가?',
          options: ['믿음', '분노', '기쁨', '감사'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 49: 누가복음 5장 ━━━
    49: QuizSet(
      lessonId: 'luke-lesson-5',
      title: '누가복음 5장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-5-1',
          question: '베드로는 무엇을 잡았는가?',
          options: ['고기', '많은 물고기', '새', '양'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-5-2',
          question: '예수께서 부르신 세리는 누구인가?',
          options: ['마태', '레위', '요한', '베드로'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-5-3',
          question: '중풍병자는 어떻게 내려졌는가?',
          options: ['문', '지붕', '창문', '길'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-5-4',
          question: '예수께서 먼저 하신 선언은 무엇인가?',
          options: ['치유', '죄 사함', '축복', '재물'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-5-5',
          question: '새 포도주는 어디에 담아야 하는가?',
          options: ['낡은 부대', '새 부대', '병', '그릇'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 50: 누가복음 6장 ━━━
    50: QuizSet(
      lessonId: 'luke-lesson-6',
      title: '누가복음 6장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-6-1',
          question: '안식일에 제자들이 한 행동은 무엇인가?',
          options: ['기도', '이삭을 잘라 먹음', '쉬기', '설교'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-6-2',
          question: '예수께서 안식일에 강조하신 것은 무엇인가?',
          options: ['규칙', '사람을 위한 날', '제사', '금식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-6-3',
          question: '열두 제자를 세우기 전에 하신 것은 무엇인가?',
          options: ['식사', '밤새 기도', '여행', '금식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-6-4',
          question: '원수를 어떻게 대하라고 하셨는가?',
          options: ['피하라', '사랑하라', '무시하라', '벌하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-6-5',
          question: '남을 판단하지 말라고 하신 이유는 무엇인가?',
          options: ['법', '자신도 판단받기 때문', '죄', '규칙'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 51: 누가복음 7장 ━━━
    51: QuizSet(
      lessonId: 'luke-lesson-7',
      title: '누가복음 7장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-7-1',
          question: '백부장의 종은 어떻게 되었는가?',
          options: ['죽음', '나음', '도망', '약해짐'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-7-2',
          question: '나인 성 과부의 아들은 어떻게 되었는가?',
          options: ['병', '살아남', '떠남', '숨음'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-7-3',
          question: '세례 요한이 예수께 보낸 질문은 무엇인가?',
          options: ['언제 오시나', '오실 그이가 당신입니까', '왜 오셨나', '무엇을 하시나'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-7-4',
          question: '죄 많은 여인은 무엇을 했는가?',
          options: ['도망', '예수의 발에 향유를 부음', '울음', '기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-7-5',
          question: '많이 용서받은 사람의 특징은 무엇인가?',
          options: ['두려움', '많이 사랑함', '침묵', '기도'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 52: 누가복음 8장 ━━━
    52: QuizSet(
      lessonId: 'luke-lesson-8',
      title: '누가복음 8장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-8-1',
          question: '씨 뿌리는 비유에서 좋은 땅은 무엇인가?',
          options: ['농부', '말씀을 지키는 사람', '씨앗', '물'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-8-2',
          question: '등불은 어디에 두어야 하는가?',
          options: ['숨김', '드러냄', '땅', '상자'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-8-3',
          question: '예수께서 풍랑을 어떻게 하셨는가?',
          options: ['기도', '꾸짖음', '도망', '잠'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-8-4',
          question: '귀신 들린 사람은 어디에 살았는가?',
          options: ['집', '무덤', '성전', '거리'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-8-5',
          question: '야이로의 딸은 어떻게 되었는가?',
          options: ['병', '살아남', '도망', '잠'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 53: 누가복음 9장 ━━━
    53: QuizSet(
      lessonId: 'luke-lesson-9',
      title: '누가복음 9장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-9-1',
          question: '제자들에게 주신 권세는 무엇인가?',
          options: ['재물', '귀신 쫓는 권세', '통치', '교육'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-9-2',
          question: '오병이어로 몇 명을 먹이셨는가?',
          options: ['3000명', '5000명', '7000명', '1000명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-9-3',
          question: '베드로는 예수를 누구라 고백했는가?',
          options: ['선지자', '그리스도', '왕', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-9-4',
          question: '변화산에서 나타난 인물은 누구인가?',
          options: ['아브라함', '모세와 엘리야', '다윗', '이사야'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-9-5',
          question: '제자가 되기 위한 조건은 무엇인가?',
          options: ['성공', '자기 부인', '부', '안전'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 54: 누가복음 10장 ━━━
    54: QuizSet(
      lessonId: 'luke-lesson-10',
      title: '누가복음 10장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-10-1',
          question: '예수께서 몇 명을 추가로 보내셨는가?',
          options: ['12명', '70명', '100명', '50명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-10-2',
          question: '그들이 전해야 할 메시지는 무엇인가?',
          options: ['율법', '하나님 나라', '돈', '기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-10-3',
          question: '선한 사마리아인 비유의 핵심은 무엇인가?',
          options: ['여행', '이웃 사랑', '돈', '법'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-10-4',
          question: '마르다는 무엇으로 책망받았는가?',
          options: ['게으름', '염려', '무지', '분노'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-10-5',
          question: '마리아는 무엇을 선택했는가?',
          options: ['일', '말씀 듣기', '여행', '기도'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 55: 누가복음 11장 ━━━
    55: QuizSet(
      lessonId: 'luke-lesson-11',
      title: '누가복음 11장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-11-1',
          question: '제자들이 요청한 것은 무엇인가?',
          options: ['돈', '기도 가르침', '능력', '지식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-11-2',
          question: '예수께서 가르치신 기도는 무엇인가?',
          options: ['감사기도', '주기도문', '찬양기도', '축복기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-11-3',
          question: '귀신을 쫓아낸 능력에 대해 논쟁된 것은 무엇인가?',
          options: ['돈', '바알세불', '권력', '법'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-11-4',
          question: '구하는 자는 어떻게 되는가?',
          options: ['실패', '받는다', '기다린다', '잃는다'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-11-5',
          question: '등불의 역할은 무엇인가?',
          options: ['숨김', '비춤', '보호', '저장'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 56: 누가복음 12장 ━━━
    56: QuizSet(
      lessonId: 'luke-lesson-12',
      title: '누가복음 12장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-12-1',
          question: '바리새인의 누룩은 무엇인가?',
          options: ['음식', '외식', '재물', '기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-12-2',
          question: '무엇을 두려워하지 말라고 하셨는가?',
          options: ['돈', '사람', '병', '죽음'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-12-3',
          question: '어리석은 부자의 문제는 무엇인가?',
          options: ['가난', '하나님 없는 삶', '무지', '약함'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-12-4',
          question: '무엇을 먼저 구하라고 하셨는가?',
          options: ['돈', '하나님 나라', '건강', '성공'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-12-5',
          question: '깨어 있어야 하는 이유는 무엇인가?',
          options: ['시간 알기', '준비', '두려움', '규칙'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 57: 누가복음 13장 ━━━
    57: QuizSet(
      lessonId: 'luke-lesson-13',
      title: '누가복음 13장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-13-1',
          question: '회개하지 않으면 어떻게 된다고 하셨는가?',
          options: ['성공', '망한다', '축복', '평안'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-13-2',
          question: '안식일에 고치신 대상은 누구인가?',
          options: ['아이', '허리 굽은 여자', '병자', '제자'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-13-3',
          question: '겨자씨 비유는 무엇을 의미하는가?',
          options: ['믿음', '하나님 나라', '재물', '기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-13-4',
          question: '좁은 문으로 들어가야 하는 이유는 무엇인가?',
          options: ['쉬움', '구원', '돈', '명예'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-13-5',
          question: '예수께서 슬퍼하신 도시는 어디인가?',
          options: ['갈릴리', '예루살렘', '사마리아', '나사렛'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 58: 누가복음 14장 ━━━
    58: QuizSet(
      lessonId: 'luke-lesson-14',
      title: '누가복음 14장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-14-1',
          question: '안식일에 고치신 사람은 누구인가?',
          options: ['아이', '수종병 환자', '맹인', '병자'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-14-2',
          question: '잔치에서 선택해야 할 자리는 어디인가?',
          options: ['높은 자리', '낮은 자리', '중앙', '문 옆'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-14-3',
          question: '큰 잔치 비유의 핵심은 무엇인가?',
          options: ['음식', '초대 거절', '돈', '기쁨'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-14-4',
          question: '제자가 되기 위한 조건은 무엇인가?',
          options: ['성공', '자기 부인', '부', '안전'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-14-5',
          question: '소금이 맛을 잃으면 어떻게 되는가?',
          options: ['먹는다', '버려진다', '보관', '숨김'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 59: 누가복음 15장 ━━━
    59: QuizSet(
      lessonId: 'luke-lesson-15',
      title: '누가복음 15장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-15-1',
          question: '잃은 양 비유의 핵심은 무엇인가?',
          options: ['돌아오는 기쁨', '찾는 기쁨', '재물의 기쁨', '양육의 기쁨'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-15-2',
          question: '잃은 드라크마 비유의 의미는 무엇인가?',
          options: ['재물의 기쁨', '회복의 기쁨', '가정의 기쁨', '노동의 기쁨'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-15-3',
          question: '탕자의 상태는 어떠했는가?',
          options: ['부자', '가난', '건강', '강함'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-15-4',
          question: '아버지는 돌아온 아들을 어떻게 대했는가?',
          options: ['꾸짖음', '환영', '무시', '벌'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-15-5',
          question: '큰 아들의 문제는 무엇인가?',
          options: ['가난', '불평', '병', '약함'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 60: 누가복음 16장 ━━━
    60: QuizSet(
      lessonId: 'luke-lesson-16',
      title: '누가복음 16장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-16-1',
          question: '불의한 청지기의 특징은 무엇인가?',
          options: ['정직', '지혜', '게으름', '무지'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-16-2',
          question: '하나님과 무엇을 동시에 섬길 수 없는가?',
          options: ['사람', '재물', '나라', '시간'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-16-3',
          question: '부자와 나사로 비유의 핵심은 무엇인가?',
          options: ['돈', '영원한 결과', '음식', '집'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-16-4',
          question: '율법과 선지자는 언제까지인가?',
          options: ['지금', '요한까지', '끝', '항상'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-16-5',
          question: '작은 일에 충성된 사람은 어떤가?',
          options: ['약함', '큰 일에도 충성', '무지', '실패'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 61: 누가복음 17장 ━━━
    61: QuizSet(
      lessonId: 'luke-lesson-17',
      title: '누가복음 17장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-17-1',
          question: '용서는 몇 번까지 해야 하는가?',
          options: ['3번', '계속', '10번', '11번'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-17-2',
          question: '겨자씨 믿음은 무엇을 할 수 있는가?',
          options: ['돈을 벌게 함', '큰 일을 가능하게 함', '집을 가꾸게 함', '길을 찾게 함'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-17-3',
          question: '열 명의 나병 환자 중 몇 명이 돌아왔는가?',
          options: ['2명', '1명', '5명', '10명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-17-4',
          question: '하나님 나라는 어디에 있는가?',
          options: ['하늘', '너희 안에', '성전', '산'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-17-5',
          question: '인자의 날은 무엇과 같다고 하셨는가?',
          options: ['비', '번개', '바람', '불'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 62: 누가복음 18장 ━━━
    62: QuizSet(
      lessonId: 'luke-lesson-18',
      title: '누가복음 18장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-18-1',
          question: '불의한 재판관 비유의 핵심은 무엇인가?',
          options: ['법', '끈질긴 기도', '돈', '권력'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-18-2',
          question: '바리새인과 세리 비유의 교훈은 무엇인가?',
          options: ['율법', '겸손', '기도', '제사'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-18-3',
          question: '어린아이 같은 자가 받는 것은 무엇인가?',
          options: ['돈', '하나님 나라', '집', '권력'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-18-4',
          question: '부자가 천국에 들어가기 어려운 이유는 무엇인가?',
          options: ['죄', '재물 집착', '약함', '무지'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-18-5',
          question: '맹인이 외친 말은 무엇인가?',
          options: ['도와달라', '다윗의 자손 예수여', '살려달라', '고쳐달라'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 63: 누가복음 19장 ━━━
    63: QuizSet(
      lessonId: 'luke-lesson-19',
      title: '누가복음 19장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-19-1',
          question: '삭개오는 어떤 사람이었는가?',
          options: ['농부', '세리장', '제사장', '상인'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-19-2',
          question: '예수께서 삭개오 집에 가신 이유는 무엇인가?',
          options: ['식사', '구원', '여행', '휴식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-19-3',
          question: '므나 비유의 핵심은 무엇인가?',
          options: ['돈', '충성', '시간', '기회'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-19-4',
          question: '예수께서 우신 도시는 어디인가?',
          options: ['갈릴리', '예루살렘', '사마리아', '나사렛'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-19-5',
          question: '성전에서 하신 일은 무엇인가?',
          options: ['기도', '장사하는 자들을 내쫓음', '설교', '휴식'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 64: 누가복음 20장 ━━━
    64: QuizSet(
      lessonId: 'luke-lesson-20',
      title: '누가복음 20장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-20-1',
          question: '권위에 대해 질문받았을 때 예수의 반응은 무엇인가?',
          options: ['답함', '되묻기', '침묵', '화냄'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-20-2',
          question: '포도원 농부 비유의 핵심은 무엇인가?',
          options: ['농사', '거절된 아들', '돈', '노동'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-20-3',
          question: '가이사의 것은 누구에게 돌리라고 하셨는가?',
          options: ['하나님', '가이사', '왕', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-20-4',
          question: '부활에 대해 강조된 것은 무엇인가?',
          options: ['죽음', '살아있는 하나님', '율법', '심판'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-20-5',
          question: '그리스도는 누구의 자손인가?',
          options: ['모세', '다윗', '아브라함', '요셉'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 65: 누가복음 21장 ━━━
    65: QuizSet(
      lessonId: 'luke-lesson-21',
      title: '누가복음 21장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-21-1',
          question: '가난한 과부의 헌금은 어떻게 평가되었는가?',
          options: ['적음', '가장 많음', '부족', '의미 없음'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-21-2',
          question: '마지막 때의 징조는 무엇인가?',
          options: ['평화', '전쟁', '안정', '풍요'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-21-3',
          question: '많은 사람이 어떻게 되는가?',
          options: ['성공', '미혹됨', '성장', '평안'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-21-4',
          question: '끝까지 견디는 자는 어떻게 되는가?',
          options: ['실패', '구원 받음', '고통', '심판'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-21-5',
          question: '깨어 있어야 하는 이유는 무엇인가?',
          options: ['시간 알기', '준비', '두려움', '규칙'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 66: 누가복음 22장 ━━━
    66: QuizSet(
      lessonId: 'luke-lesson-22',
      title: '누가복음 22장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-22-1',
          question: '예수를 판 사람은 누구인가?',
          options: ['베드로', '가룟 유다', '요한', '야고보'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-22-2',
          question: '마지막 만찬의 떡은 무엇을 의미하는가?',
          options: ['음식', '몸', '죄', '축복'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-22-3',
          question: '잔은 무엇을 의미하는가?',
          options: ['물', '피', '기쁨', '생명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-22-4',
          question: '베드로는 몇 번 부인했는가?',
          options: ['2번', '3번', '1번', '4번'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-22-5',
          question: '겟세마네 기도의 핵심은 무엇인가?',
          options: ['승리', '아버지 뜻대로', '회피', '분노'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 67: 누가복음 23장 ━━━
    67: QuizSet(
      lessonId: 'luke-lesson-23',
      title: '누가복음 23장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-23-1',
          question: '예수를 재판한 총독은 누구인가?',
          options: ['헤롯', '빌라도', '가이사', '바울'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-23-2',
          question: '십자가에 달린 장소는 어디인가?',
          options: ['성전', '골고다', '갈릴리', '광야'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-23-3',
          question: '십자가 위에서 하신 말은 무엇인가?',
          options: ['감사합니다', '아버지여 저들을 사하여 주옵소서', '할렐루야', '아멘'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-23-4',
          question: '한 강도는 무엇을 요청했는가?',
          options: ['구원', '기억해 달라', '돈', '자유'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-23-5',
          question: '성전 휘장은 어떻게 되었는가?',
          options: ['그대로', '찢어짐', '사라짐', '불탐'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 68: 누가복음 24장 ━━━
    68: QuizSet(
      lessonId: 'luke-lesson-24',
      title: '누가복음 24장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'lkq-24-1',
          question: '무덤에 간 사람은 누구인가?',
          options: ['제자', '여자들', '베드로', '요한'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-24-2',
          question: '천사가 전한 소식은 무엇인가?',
          options: ['죽음', '부활', '심판', '전쟁'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-24-3',
          question: '엠마오로 가던 두 제자는 무엇을 깨달았는가?',
          options: ['돈', '예수', '길', '시간'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-24-4',
          question: '예수께서 제자들에게 하신 일은 무엇인가?',
          options: ['설교', '성경을 풀어주심', '기도', '식사'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'lkq-24-5',
          question: '예수께서 어디로 올라가셨는가?',
          options: ['산', '하늘', '성전', '바다'],
          correctIndex: 1,
        ),
      ],
    ),
  };

  static QuizSet? getQuizForUnit(int unit) => quizSets[unit];

  static QuizSet getQuizForLesson(String lessonId) {
    final match = RegExp(r'luke-lesson-(\d+)').firstMatch(lessonId);
    if (match != null) {
      final lessonNum = int.tryParse(match.group(1)!);
      if (lessonNum != null) {
        final unit = lessonNum + 44; // luke-lesson-1 → unit 45
        if (quizSets.containsKey(unit)) {
          return quizSets[unit]!;
        }
      }
    }
    return quizSets.values.first;
  }
}
