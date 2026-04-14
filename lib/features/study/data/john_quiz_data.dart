import '../models/quiz_question.dart';

/// 요한복음 퀴즈 데이터 (21단위 x 5~15문제 = 200문제) - CSV에서 생성
class JohnQuizData {
  static const Map<int, QuizSet> quizSets = {
    // ━━━ Unit 68: 요한복음 1장 (john-lesson-1) ━━━
    68: QuizSet(
      lessonId: 'john-lesson-1',
      title: '요한복음 1장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-1-1',
          question: '태초에 계신 분은 누구인가?',
          options: ['선지자', '말씀', '천사', '사람'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-1-2',
          question: '말씀은 누구와 함께 계셨는가?',
          options: ['사람', '하나님', '천사', '제자'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-1-3',
          question: '세례 요한의 역할은 무엇인가?',
          options: ['왕', '증언', '제사', '통치'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-1-4',
          question: '말씀은 무엇이 되어 우리 가운데 거하셨는가?',
          options: ['빛', '육신', '영', '능력'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-1-5',
          question: '예수를 따르기 시작한 첫 제자는 누구인가?',
          options: ['베드로', '안드레', '요한', '야고보'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 69: 요한복음 2장 (john-lesson-2) ━━━
    69: QuizSet(
      lessonId: 'john-lesson-2',
      title: '요한복음 2장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-2-1',
          question: '가나 혼인잔치에서 일어난 기적은 무엇인가?',
          options: ['병 고침', '물을 포도주로', '귀신 쫓음', '죽은 자 살림'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-2-2',
          question: '이 기적은 무엇의 시작인가?',
          options: ['설교', '표적', '전쟁', '여행'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-2-3',
          question: '예수께서 성전에서 하신 일은 무엇인가?',
          options: ['기도', '장사하는 자들을 내쫓음', '설교', '휴식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-2-4',
          question: '예수께서 성전을 무엇에 비유하셨는가?',
          options: ['건물', '자신의 몸', '나라', '집'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-2-5',
          question: '예수께서 사람을 맡기지 않으신 이유는 무엇인가?',
          options: ['거리', '사람을 아심', '시간', '규칙'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 70: 요한복음 3장 (john-lesson-3) ━━━
    70: QuizSet(
      lessonId: 'john-lesson-3',
      title: '요한복음 3장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-3-1',
          question: '니고데모는 어떤 사람이었는가?',
          options: ['제자', '바리새인', '왕', '세리'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-3-2',
          question: '거듭남은 어떻게 이루어지는가?',
          options: ['노력', '물과 성령', '돈', '지식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-3-3',
          question: '하나님이 세상을 사랑하신 이유는 무엇인가?',
          options: ['심판', '구원', '벌', '시험'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-3-4',
          question: '빛보다 어둠을 사랑하는 이유는 무엇인가?',
          options: ['편함', '악한 행위', '무지', '습관'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-3-5',
          question: '세례 요한은 자신을 무엇이라 했는가?',
          options: ['왕', '신랑의 친구', '선지자', '종'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 71: 요한복음 4장 (john-lesson-4) ━━━
    71: QuizSet(
      lessonId: 'john-lesson-4',
      title: '요한복음 4장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-4-1',
          question: '사마리아 여인이 물을 길으러 온 시간은 언제인가?',
          options: ['아침', '정오', '저녁', '밤'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-4-2',
          question: '예수께서 주시는 물은 무엇을 주는가?',
          options: ['돈', '영원한 생명', '건강', '힘'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-4-3',
          question: '하나님께 드리는 참된 예배는 무엇인가?',
          options: ['형식', '영과 진리', '제사', '노래'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-4-4',
          question: '제자들이 돌아왔을 때 놀란 이유는 무엇인가?',
          options: ['기도', '여인과 대화', '식사', '휴식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-4-5',
          question: '두 번째 표적은 무엇인가?',
          options: ['병 고침', '왕의 신하의 아들 치유', '귀신 쫓음', '죽은 자 살림'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 72: 요한복음 5장 (john-lesson-5) ━━━
    72: QuizSet(
      lessonId: 'john-lesson-5',
      title: '요한복음 5장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-5-1',
          question: '예수께서 고치신 병자는 어떤 상태였는가?',
          options: ['맹인', '38년 된 병자', '귀신 들림', '중풍'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-5-2',
          question: '병자는 어디에 있었는가?',
          options: ['성전', '베데스다', '갈릴리', '사마리아'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-5-3',
          question: '예수께서 안식일에 하신 일로 논쟁이 일어난 이유는 무엇인가?',
          options: ['기도', '병 고침', '설교', '여행'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-5-4',
          question: '아버지와 아들의 관계는 무엇인가?',
          options: ['분리', '하나', '경쟁', '독립'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-5-5',
          question: '생명을 주시는 이는 누구인가?',
          options: ['천사', '아들', '제자', '사람'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 73: 요한복음 6장 (john-lesson-6) ━━━
    73: QuizSet(
      lessonId: 'john-lesson-6',
      title: '요한복음 6장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-6-1',
          question: '예수께서 몇 명을 먹이셨는가?',
          options: ['3000명', '5000명', '7000명', '1000명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-6-2',
          question: '사람들이 예수를 찾은 이유는 무엇인가?',
          options: ['말씀', '떡', '기적', '권세'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-6-3',
          question: '예수께서 자신을 무엇이라 하셨는가?',
          options: ['빛', '생명의 떡', '물', '길'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-6-4',
          question: '영생을 얻는 방법은 무엇인가?',
          options: ['노력', '믿음', '율법', '제사'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-6-5',
          question: '많은 제자들이 떠난 이유는 무엇인가?',
          options: ['피곤', '어려운 말씀', '거리', '돈'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 74: 요한복음 7장 (john-lesson-7) ━━━
    74: QuizSet(
      lessonId: 'john-lesson-7',
      title: '요한복음 7장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-7-1',
          question: '초막절에 예수께서 외치신 말씀은 무엇인가?',
          options: ['기도하라', '내게로 와서 마시라', '율법 지켜라', '회개하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-7-2',
          question: '예수에 대한 사람들의 반응은 무엇이었는가?',
          options: ['동일', '나뉨', '침묵', '기쁨'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-7-3',
          question: '바리새인들은 무엇을 보내 예수를 잡으려 했는가?',
          options: ['군대', '하속들', '제자', '백성'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-7-4',
          question: '하속들이 예수를 잡지 않은 이유는 무엇인가?',
          options: ['두려움', '말씀의 권위', '명령 없음', '거리'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-7-5',
          question: '니고데모의 태도는 무엇이었는가?',
          options: ['반대', '변호', '침묵', '공격'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 75: 요한복음 8장 (john-lesson-8) ━━━
    75: QuizSet(
      lessonId: 'john-lesson-8',
      title: '요한복음 8장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-8-1',
          question: '간음한 여인 사건에서 예수의 말씀은 무엇인가?',
          options: ['벌하라', '죄 없는 자가 먼저 돌로 치라', '용서 없다', '법대로 하라'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-8-2',
          question: '예수께서 자신을 무엇이라 하셨는가?',
          options: ['길', '세상의 빛', '물', '떡'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-8-3',
          question: '진리는 무엇을 하는가?',
          options: ['숨김', '자유롭게 함', '제한', '판단'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-8-4',
          question: '죄를 범하는 자는 무엇의 종인가?',
          options: ['법', '죄', '사람', '돈'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-8-5',
          question: '아브라함보다 먼저 계신 분은 누구인가?',
          options: ['선지자', '예수', '모세', '다윗'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 76: 요한복음 9장 (john-lesson-9) ━━━
    76: QuizSet(
      lessonId: 'john-lesson-9',
      title: '요한복음 9장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-9-1',
          question: '맹인이 된 이유에 대한 예수의 답은 무엇인가?',
          options: ['죄', '하나님의 일', '부모', '운명'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-9-2',
          question: '예수께서 맹인을 어떻게 고치셨는가?',
          options: ['기도', '진흙', '손', '말씀'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-9-3',
          question: '바리새인들의 반응은 무엇이었는가?',
          options: ['기쁨', '불신', '감사', '인정'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-9-4',
          question: '맹인은 예수를 어떻게 고백했는가?',
          options: ['사람', '선지자', '왕', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-9-5',
          question: '예수께서 오신 목적 중 하나는 무엇인가?',
          options: ['심판', '보게 함', '벌', '통치'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 77: 요한복음 10장 (john-lesson-10) ━━━
    77: QuizSet(
      lessonId: 'john-lesson-10',
      title: '요한복음 10장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-10-1',
          question: '예수께서 자신을 무엇이라 하셨는가?',
          options: ['왕', '선한 목자', '제사장', '선지자'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-10-2',
          question: '양들은 누구의 음성을 듣는가?',
          options: ['사람', '목자', '군대', '제사장'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-10-3',
          question: '선한 목자의 특징은 무엇인가?',
          options: ['도망', '생명을 버림', '무시', '통치'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-10-4',
          question: '도둑의 목적은 무엇인가?',
          options: ['보호', '훔치고 죽이고 멸망', '교육', '인도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-10-5',
          question: '예수와 아버지의 관계는 무엇인가?',
          options: ['분리', '하나', '경쟁', '독립'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 78: 요한복음 11장 (john-lesson-11) ━━━
    78: QuizSet(
      lessonId: 'john-lesson-11',
      title: '요한복음 11장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-11-1',
          question: '죽은 사람은 누구인가?',
          options: ['베드로', '나사로', '요한', '야고보'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-11-2',
          question: '예수께서 자신을 무엇이라 하셨는가?',
          options: ['길', '부활과 생명', '빛', '물'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-11-3',
          question: '예수께서 보이신 감정은 무엇인가?',
          options: ['기쁨', '눈물', '분노', '침묵'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-11-4',
          question: '나사로는 어떻게 되었는가?',
          options: ['그대로', '살아남', '사라짐', '병'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-11-5',
          question: '이 사건의 결과는 무엇이었는가?',
          options: ['반대', '믿음 증가', '무관심', '두려움'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 79: 요한복음 12장 (john-lesson-12) ━━━
    79: QuizSet(
      lessonId: 'john-lesson-12',
      title: '요한복음 12장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-12-1',
          question: '마리아는 무엇을 했는가?',
          options: ['기도', '향유를 부음', '설교', '헌금'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-12-2',
          question: '예수께서 입성할 때 탄 것은 무엇인가?',
          options: ['말', '나귀', '수레', '낙타'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-12-3',
          question: '사람들이 외친 말은 무엇인가?',
          options: ['아멘', '호산나', '할렐루야', '찬양'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-12-4',
          question: '한 알의 밀이 죽으면 어떻게 되는가?',
          options: ['사라짐', '많은 열매', '약함', '실패'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-12-5',
          question: '빛 가운데 행하라는 이유는 무엇인가?',
          options: ['편함', '어둠에 빠지지 않기 위해', '돈', '성공'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 80: 요한복음 13장 (john-lesson-13) ━━━
    80: QuizSet(
      lessonId: 'john-lesson-13',
      title: '요한복음 13장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-13-1',
          question: '예수께서 제자들에게 하신 행동은 무엇인가?',
          options: ['설교', '발 씻김', '기도', '식사'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-13-2',
          question: '이 행동의 의미는 무엇인가?',
          options: ['권위', '섬김', '통치', '교육'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-13-3',
          question: '서로 어떻게 하라고 명령하셨는가?',
          options: ['판단', '사랑', '경쟁', '무시'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-13-4',
          question: '가룟 유다는 무엇을 하러 나갔는가?',
          options: ['기도', '예수를 팔기 위해', '여행', '식사'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-13-5',
          question: '제자의 특징은 무엇인가?',
          options: ['지식', '사랑', '힘', '재물'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 81: 요한복음 14장 (john-lesson-14) ━━━
    81: QuizSet(
      lessonId: 'john-lesson-14',
      title: '요한복음 14장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-14-1',
          question: '예수께서 자신을 무엇이라 하셨는가?',
          options: ['빛', '길 진리 생명', '물', '떡'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-14-2',
          question: '아버지께 가는 방법은 무엇인가?',
          options: ['노력', '예수', '율법', '제사'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-14-3',
          question: '보혜사는 누구인가?',
          options: ['천사', '성령', '제자', '선지자'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-14-4',
          question: '성령의 역할은 무엇인가?',
          options: ['판단', '가르침', '통치', '벌'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-14-5',
          question: '평안을 어떻게 주신다고 하셨는가?',
          options: ['세상처럼', '예수의 방식', '돈', '힘'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 82: 요한복음 15장 (john-lesson-15) ━━━
    82: QuizSet(
      lessonId: 'john-lesson-15',
      title: '요한복음 15장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-15-1',
          question: '예수께서 자신을 무엇이라 하셨는가?',
          options: ['빛', '참 포도나무', '물', '떡'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-15-2',
          question: '가지의 역할은 무엇인가?',
          options: ['성장', '열매 맺음', '보호', '이동'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-15-3',
          question: '열매를 맺기 위한 조건은 무엇인가?',
          options: ['노력', '주 안에 거함', '돈', '지식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-15-4',
          question: '서로 어떻게 하라고 하셨는가?',
          options: ['판단', '사랑', '경쟁', '무시'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-15-5',
          question: '세상이 미워하는 이유는 무엇인가?',
          options: ['약함', '예수를 따르기 때문', '돈', '실패'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 83: 요한복음 16장 (john-lesson-16) ━━━
    83: QuizSet(
      lessonId: 'john-lesson-16',
      title: '요한복음 16장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-16-1',
          question: '성령이 하시는 일은 무엇인가?',
          options: ['통치', '죄를 깨닫게 함', '벌', '재물'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-16-2',
          question: '진리의 성령은 무엇을 인도하는가?',
          options: ['길', '진리', '돈', '힘'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-16-3',
          question: '슬픔은 어떻게 되는가?',
          options: ['유지', '기쁨으로 바뀜', '증가', '사라짐'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-16-4',
          question: '예수께서 세상을 이겼다고 하신 의미는 무엇인가?',
          options: ['전쟁', '승리', '힘', '권력'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-16-5',
          question: '제자들에게 주신 것은 무엇인가?',
          options: ['돈', '평안', '권력', '지식'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 84: 요한복음 17장 (john-lesson-17) ━━━
    84: QuizSet(
      lessonId: 'john-lesson-17',
      title: '요한복음 17장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-17-1',
          question: '예수께서 드리신 기도는 무엇을 위한 것인가?',
          options: ['돈', '제자들', '권력', '성공'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-17-2',
          question: '영생은 무엇인가?',
          options: ['오래 삶', '하나님과 예수 아는 것', '건강', '성공'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-17-3',
          question: '제자들이 세상에 있는 이유는 무엇인가?',
          options: ['돈', '사명', '휴식', '여행'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-17-4',
          question: '하나 되게 해달라는 기도의 의미는 무엇인가?',
          options: ['힘', '연합', '권력', '통치'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-17-5',
          question: '예수께서 원하신 것은 무엇인가?',
          options: ['성공', '함께 있음', '돈', '명예'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 85: 요한복음 18장 (john-lesson-18) ━━━
    85: QuizSet(
      lessonId: 'john-lesson-18',
      title: '요한복음 18장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-18-1',
          question: '예수를 잡으러 온 사람들은 누구인가?',
          options: ['제자', '군대', '백성', '상인'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-18-2',
          question: '베드로는 무엇을 했는가?',
          options: ['도망', '귀를 자름', '울음', '기도'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-18-3',
          question: '예수께서 말씀하신 나라는 무엇인가?',
          options: ['세상', '이 세상에 속하지 않음', '하늘', '땅'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-18-4',
          question: '빌라도가 한 질문은 무엇인가?',
          options: ['누구냐', '진리가 무엇이냐', '왜 왔냐', '무엇을 하냐'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-18-5',
          question: '베드로는 몇 번 부인했는가?',
          options: ['2번', '3번', '1번', '4번'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 86: 요한복음 19장 (john-lesson-19) ━━━
    86: QuizSet(
      lessonId: 'john-lesson-19',
      title: '요한복음 19장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-19-1',
          question: '예수께 씌운 것은 무엇인가?',
          options: ['왕관', '가시관', '모자', '천'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-19-2',
          question: '십자가에 쓴 명패 내용은 무엇인가?',
          options: ['선지자', '유대인의 왕', '종', '죄인'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-19-3',
          question: '십자가 위에서 하신 말씀은 무엇인가?',
          options: ['시작', '다 이루었다', '감사합니다', '아멘'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-19-4',
          question: '군인들이 예수의 옷을 어떻게 했는가?',
          options: ['나눔', '제비 뽑음', '버림', '숨김'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-19-5',
          question: '예수의 옆구리를 찌른 것은 무엇인가?',
          options: ['칼', '창', '돌', '손'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 87: 요한복음 20장 (john-lesson-20) ━━━
    87: QuizSet(
      lessonId: 'john-lesson-20',
      title: '요한복음 20장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-20-1',
          question: '무덤에 처음 간 사람은 누구인가?',
          options: ['제자', '막달라 마리아', '베드로', '요한'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-20-2',
          question: '제자들이 처음 반응한 것은 무엇인가?',
          options: ['믿음', '의심', '기쁨', '감사'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-20-3',
          question: '도마의 반응은 무엇인가?',
          options: ['믿음', '만져봐야 믿음', '기쁨', '감사'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-20-4',
          question: '예수께서 주신 것은 무엇인가?',
          options: ['돈', '성령', '권력', '지식'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-20-5',
          question: '기록된 목적은 무엇인가?',
          options: ['역사', '믿음', '정보', '교육'],
          correctIndex: 1,
        ),
      ],
    ),
    // ━━━ Unit 88: 요한복음 21장 (john-lesson-21) ━━━
    88: QuizSet(
      lessonId: 'john-lesson-21',
      title: '요한복음 21장 퀴즈',
      questions: [
        QuizQuestion(
          id: 'jnq-21-1',
          question: '제자들이 잡은 것은 무엇인가?',
          options: ['물', '많은 물고기', '새', '양'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-21-2',
          question: '예수께서 베드로에게 몇 번 질문하셨는가?',
          options: ['2번', '3번', '1번', '4번'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-21-3',
          question: '질문 내용은 무엇인가?',
          options: ['나를 믿느냐', '나를 사랑하느냐', '나를 따르겠느냐', '나를 알겠느냐'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-21-4',
          question: '베드로에게 맡기신 사명은 무엇인가?',
          options: ['통치', '양을 먹이라', '설교', '여행'],
          correctIndex: 1,
        ),
        QuizQuestion(
          id: 'jnq-21-5',
          question: '요한복음의 기록 목적은 무엇인가?',
          options: ['정보', '증언', '역사', '교육'],
          correctIndex: 1,
        ),
      ],
    ),
  };

  /// unit 번호(68~88)로 퀴즈 세트 찾기
  static QuizSet? getQuizForUnit(int unit) => quizSets[unit];

  /// lessonId('john-lesson-1' ~ 'john-lesson-21')로 퀴즈 세트 찾기
  static QuizSet getQuizForLesson(String lessonId) {
    final match = RegExp(r'john-lesson-(\d+)').firstMatch(lessonId);
    if (match != null) {
      final lessonNum = int.tryParse(match.group(1)!);
      if (lessonNum != null) {
        final unit = lessonNum + 67; // john-lesson-1 → unit 68
        if (quizSets.containsKey(unit)) {
          return quizSets[unit]!;
        }
      }
    }
    return quizSets.values.first;
  }
}
