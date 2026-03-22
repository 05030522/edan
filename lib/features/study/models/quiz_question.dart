/// 퀴즈 문제 모델
class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String? explanation;
  final int rewardFp;

  const QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    this.explanation,
    this.rewardFp = 5,
  });
}

/// 퀴즈 세트 (묵상 주제별)
class QuizSet {
  final String lessonId;
  final String title;
  final List<QuizQuestion> questions;

  const QuizSet({
    required this.lessonId,
    required this.title,
    required this.questions,
  });
}

/// 더미 퀴즈 데이터
class DummyQuizData {
  static const List<QuizSet> quizSets = [
    QuizSet(
      lessonId: 'lesson-1',
      title: '홍해를 여시는 하나님',
      questions: [
        QuizQuestion(
          id: 'q1',
          question: '하나님이 모세에게 무엇을 들고\n바다 위로 내밀라고 하셨나요?',
          options: ['칼', '지팡이', '방패', '횃불'],
          correctIndex: 1,
          explanation: '출애굽기 14:16 - "지팡이를 들고 손을 바다 위로 내밀어 그것이 갈라지게 하라"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'q2',
          question: '이스라엘 백성은 바다 가운데를\n어떤 길로 건넜나요?',
          options: ['물 위를 걸어서', '배를 타고', '마른 땅으로', '수영으로'],
          correctIndex: 2,
          explanation: '출애굽기 14:16 - "이스라엘 자손이 바다 가운데서 마른 땅으로 행하리라"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'q3',
          question: '하나님이 애굽 사람들의 마음을\n어떻게 하셨나요?',
          options: ['부드럽게', '완악하게', '두렵게', '기쁘게'],
          correctIndex: 1,
          explanation: '출애굽기 14:17 - "내가 애굽 사람들의 마음을 완악하게 할 것인즉"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'q4',
          question: '이 사건에서 하나님은 자신이\n누구임을 알리셨나요?',
          options: ['여호와', '엘로힘', '아도나이', '엘샤다이'],
          correctIndex: 0,
          explanation: '출애굽기 14:18 - "애굽 사람들이 나를 여호와인 줄 알리라"',
          rewardFp: 5,
        ),
      ],
    ),
    // ━━━ lesson-2: 하나님의 사랑 (요한복음 3:16) ━━━
    QuizSet(
      lessonId: 'lesson-2',
      title: '하나님의 사랑',
      questions: [
        QuizQuestion(
          id: 'q2-1',
          question: '요한복음 3:16에서 하나님이\n세상을 어떻게 하셨다고 했나요?',
          options: ['심판하사', '사랑하사', '버리사', '만드사'],
          correctIndex: 1,
          explanation: '요한복음 3:16 - "하나님이 세상을 이처럼 사랑하사 독생자를 주셨으니"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'q2-2',
          question: '하나님이 독생자를 주신 목적은\n무엇인가요?',
          options: ['심판하려고', '영생을 얻게 하려고', '벌을 주려고', '시험하려고'],
          correctIndex: 1,
          explanation: '요한복음 3:16 - "이는 그를 믿는 자마다 멸망하지 않고 영생을 얻게 하려 하심이라"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'q2-3',
          question: '"그를 믿는 자마다"에서\n"그"는 누구를 가리키나요?',
          options: ['모세', '아브라함', '예수 그리스도', '다윗'],
          correctIndex: 2,
          explanation: '하나님의 독생자 예수 그리스도를 가리킵니다.',
          rewardFp: 5,
        ),
      ],
    ),
    // ━━━ lesson-3: 선한 목자 (시편 23편) ━━━
    QuizSet(
      lessonId: 'lesson-3',
      title: '선한 목자',
      questions: [
        QuizQuestion(
          id: 'q3-1',
          question: '시편 23편에서 여호와를\n무엇에 비유했나요?',
          options: ['왕', '목자', '전사', '재판관'],
          correctIndex: 1,
          explanation: '시편 23:1 - "여호와는 나의 목자시니 내게 부족함이 없으리로다"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'q3-2',
          question: '여호와가 목자이시면\n내게 무엇이 없다고 했나요?',
          options: ['걱정', '부족함', '슬픔', '두려움'],
          correctIndex: 1,
          explanation: '시편 23:1 - "내게 부족함이 없으리로다"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'q3-3',
          question: '사망의 음침한 골짜기로\n다닐지라도 해를 두려워하지 않는 이유는?',
          options: ['내가 강하므로', '주께서 나와 함께 하시므로', '무기가 있으므로', '도움이 오므로'],
          correctIndex: 1,
          explanation: '시편 23:4 - "주께서 나와 함께 하심이라"',
          rewardFp: 5,
        ),
      ],
    ),
    // ━━━ lesson-4: 모든 것이 합력 (로마서 8:28) ━━━
    QuizSet(
      lessonId: 'lesson-4',
      title: '모든 것이 합력',
      questions: [
        QuizQuestion(
          id: 'q4-1',
          question: '로마서 8:28에서 모든 것이\n합력하여 무엇을 이룬다고 했나요?',
          options: ['부를', '선을', '명예를', '평안을'],
          correctIndex: 1,
          explanation: '로마서 8:28 - "모든 것이 합력하여 선을 이루느니라"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'q4-2',
          question: '이 약속은 누구에게\n해당되나요?',
          options: ['모든 사람', '하나님을 사랑하는 자', '부자들', '제사장들'],
          correctIndex: 1,
          explanation: '로마서 8:28 - "하나님을 사랑하는 자 곧 그의 뜻대로 부르심을 입은 자들에게는"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'q4-3',
          question: '"그의 뜻대로 부르심을 입은 자"는\n어떤 사람인가요?',
          options: ['직접 선택받은 특별한 사람', '하나님을 믿고 따르는 사람', '예언자만', '목사만'],
          correctIndex: 1,
          explanation: '하나님의 부르심에 응답하여 믿음으로 따르는 모든 성도를 가리킵니다.',
          rewardFp: 5,
        ),
      ],
    ),
    // ━━━ 기본 퀴즈 (폴백) ━━━
    QuizSet(
      lessonId: 'default',
      title: '신앙의 첫걸음',
      questions: [
        QuizQuestion(
          id: 'qd1',
          question: '"하나님이 세상을 이처럼 사랑하사"\n이 말씀은 어디에 있나요?',
          options: ['창세기 1:1', '요한복음 3:16', '시편 23:1', '로마서 8:28'],
          correctIndex: 1,
          explanation: '요한복음 3:16 - "하나님이 세상을 이처럼 사랑하사 독생자를 주셨으니..."',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'qd2',
          question: '하나님이 독생자를 주신 이유는\n무엇인가요?',
          options: ['심판하려고', '멸망하지 않고 영생을 얻게', '벌을 주려고', '고통을 주려고'],
          correctIndex: 1,
          explanation: '요한복음 3:16 - "...이는 그를 믿는 자마다 멸망하지 않고 영생을 얻게 하려 하심이라"',
          rewardFp: 5,
        ),
        QuizQuestion(
          id: 'qd3',
          question: '하나님의 독생자는 누구인가요?',
          options: ['모세', '아브라함', '예수 그리스도', '다윗'],
          correctIndex: 2,
          explanation: '요한복음 3:16에서 말하는 독생자는 예수 그리스도입니다.',
          rewardFp: 5,
        ),
      ],
    ),
  ];

  /// lessonId로 퀴즈 세트 찾기 (없으면 기본 퀴즈)
  static QuizSet getQuizForLesson(String lessonId) {
    return quizSets.firstWhere(
      (q) => q.lessonId == lessonId,
      orElse: () => quizSets.last,
    );
  }
}
