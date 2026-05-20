import '../models/lesson_data.dart';

/// 누가복음 묵상 데이터 (24 학습단위) — Google 시트 '묵상 주제_누가복음'에서 생성
/// 단위당 3개의 묵상 질문 포함
class LukeMeditationData {
  static const List<LessonContent> lessons = [
    LessonContent(
      lessonId: 'luke-lesson-1',
      pathId: 'path-luke',
      title: '하나님의 계획과 약속의 시작',
      scriptureReference: '누가복음 1장',
      scriptureText:
          '누가복음은 예수님의 탄생 이야기를 자세하게 기록하며 시작해요. 세례 요한의 출생이 먼저 예고되고, 이어서 천사가 마리아에게 나타나 예수님의 탄생을 알리죠. 마리아는 놀라운 소식을 듣고도 하나님의 말씀에 순종하는 태도를 보이세요. 또한 엘리사벳과의 만남 속에서 하나님의 약속이 이루어지고 있음을 확인해요. 이 장은 하나님의 계획이 사람을 통해 조용히 그러나 확실하게 이루어지고 있음을 보여줘요.',
      meditationGuide: '나는 하나님의 계획을 신뢰하고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 하나님의 계획을 신뢰하고 있나요?',
          guide:
              '하나님의 일은 내가 이해하기 어려울 때도 있어요. 나는 그 상황에서도 하나님을 믿고 있나요? 지금 내 삶 속에서도 하나님이 일하고 계심을 신뢰하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님의 말씀에 순종하고 있나요?',
          guide:
              '마리아는 모든 상황을 이해하지 못해도 순종했어요. 나는 하나님의 뜻을 알면서도 미루고 있지는 않나요? 지금 순종해야 할 것은 무엇인가요?',
        ),
        MeditationQuestion(
          question: '나는 하나님을 향한 믿음을 고백하고 있나요?',
          guide:
              '마음으로만 믿는 것에 그치고 있지는 않나요? 나는 하나님이 하신 일을 인정하고 고백하고 있나요? 내 삶에서 믿음이 드러나고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-2',
      pathId: 'path-luke',
      title: '예수님의 탄생과 하나님의 인도하심',
      scriptureReference: '누가복음 2장',
      scriptureText:
          '예수님은 베들레헴에서 태어나시고, 천사들은 목자들에게 그 소식을 전해요. 목자들은 즉시 찾아가 아기 예수님을 경배하며 기쁨으로 돌아가요. 시므온과 안나는 예수님을 보고 하나님의 약속이 이루어졌음을 알아봐요. 어린 예수님은 성전에서 하나님을 아는 지혜를 보여주세요. 이 장은 하나님이 낮은 자리에서도 일하시며 그분을 알아보는 사람이 있다는 것을 보여줘요.',
      meditationGuide: '나는 하나님이 하시는 일을 알아보고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 하나님이 하시는 일을 알아보고 있나요?',
          guide: '하나님은 화려한 곳이 아니라 낮은 자리에서도 일하세요. 나는 그 일을 보고 있나요? 아니면 놓치고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 기쁨으로 하나님을 반응하고 있나요?',
          guide: '목자들은 기쁨으로 반응했어요. 나는 하나님이 하신 일에 무덤덤하지 않나요? 감사와 기쁨이 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님을 더 알아가고 있나요?',
          guide: '예수님도 자라며 하나님을 알아가셨어요. 나는 성장하고 있나요? 멈춰 있지는 않나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-3',
      pathId: 'path-luke',
      title: '회개와 준비된 마음',
      scriptureReference: '누가복음 3장',
      scriptureText:
          '세례 요한은 사람들에게 회개를 선포하며 하나님 나라를 준비하라고 말해요. 단순한 말이 아니라 삶의 변화, 즉 열매 맺는 회개를 강조해요. 사람들은 어떻게 살아야 하는지 구체적으로 묻고, 요한은 삶 속에서 실천할 것을 알려줘요. 이후 예수님이 세례를 받으시고 성령이 임하며 하나님의 음성이 들려요. 이 장은 하나님 앞에 나아가기 위해서는 진짜 변화가 필요함을 보여줘요.',
      meditationGuide: '나는 진짜로 변화되고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 진짜로 변화되고 있나요?',
          guide:
              '회개는 말로 끝나는 것이 아니에요. 나는 내 삶에서 바뀌고 있는 부분이 있나요? 반복되는 모습 그대로 머물러 있지는 않나요?',
        ),
        MeditationQuestion(
          question: '나는 내 삶을 돌아보고 있나요?',
          guide:
              '바쁘게 살다 보면 자신을 돌아보지 못할 수 있어요. 나는 내 상태를 점검하고 있나요? 하나님 앞에서 어떤 모습인가요?',
        ),
        MeditationQuestion(
          question: '나는 하나님 앞에 준비된 마음으로 서 있나요?',
          guide: '하나님은 겉이 아니라 중심을 보세요. 나는 진심으로 하나님을 향하고 있나요? 준비된 마음인가요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-4',
      pathId: 'path-luke',
      title: '시험과 사명의 시작',
      scriptureReference: '누가복음 4장',
      scriptureText:
          '예수님은 성령에 이끌려 광야에서 시험을 받으세요. 마귀는 여러 방식으로 유혹하지만 예수님은 말씀으로 이기세요. 이후 예수님은 사역을 시작하시며 가난한 자에게 복음을 전하러 오셨다고 선언하세요. 그러나 고향 사람들은 예수님을 받아들이지 못해요. 이 장은 예수님의 사명과 사람들의 다양한 반응을 보여줘요.',
      meditationGuide: '나는 유혹 앞에서 어떻게 반응하고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 유혹 앞에서 어떻게 반응하고 있나요?',
          guide: '유혹은 피할 수 없어요. 중요한 것은 나의 반응이에요. 나는 말씀을 기준으로 선택하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 예수님의 말씀을 받아들이고 있나요?',
          guide: '익숙함 때문에 무시하고 있지는 않나요? 나는 열린 마음으로 듣고 있나요? 삶에 적용하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님이 주신 사명을 알고 있나요?',
          guide:
              '예수님은 분명한 사명을 가지고 계셨어요. 나는 내 삶의 방향을 알고 있나요? 하나님이 원하시는 삶을 살고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-5',
      pathId: 'path-luke',
      title: '부르심과 순종',
      scriptureReference: '누가복음 5장',
      scriptureText:
          '예수님은 어부들을 부르시고 그들은 모든 것을 내려놓고 따르세요. 베드로는 자신의 부족함을 깨닫고 예수님 앞에 엎드려요. 예수님은 나병환자를 고치시고 죄인을 부르세요. 사람들은 점점 예수님께 몰려들어요. 이 장은 부르심 앞에서의 반응과 순종을 보여줘요.',
      meditationGuide: '나는 예수님의 부르심에 어떻게 반응하고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 예수님의 부르심에 어떻게 반응하고 있나요?',
          guide: '하나님은 지금도 나를 부르고 계세요. 나는 그 부르심을 듣고 있나요? 아니면 미루고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 나의 부족함을 인정하고 있나요?',
          guide: '자신의 모습을 인정하는 것이 시작이에요. 나는 솔직하게 나를 보고 있나요? 하나님 앞에 나아가고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 순종으로 살아가고 있나요?',
          guide: '아는 것과 행동은 달라요. 나는 실제로 따르고 있나요? 내 삶에 변화가 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-6',
      pathId: 'path-luke',
      title: '하나님 나라의 기준과 삶',
      scriptureReference: '누가복음 6장',
      scriptureText:
          '예수님은 안식일에 대해 가르치시며 형식보다 사람을 살리는 것이 중요하다고 말씀하세요. 열두 제자를 세우시고 하나님 나라의 기준을 가르치세요. 복과 화를 통해 세상과 다른 기준을 보여주시고, 원수를 사랑하라고 말씀하세요. 또한 비판하지 말고 용서하며 열매로 사람을 알 수 있다고 하세요. 이 장은 하나님 나라의 삶이 세상의 기준과 다르다는 것을 보여줘요.',
      meditationGuide: '나는 어떤 기준으로 살아가고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 어떤 기준으로 살아가고 있나요?',
          guide: '세상과 하나님 나라의 기준은 달라요. 나는 무엇을 기준으로 선택하고 있나요? 내 삶의 기준은 어디에 있나요?',
        ),
        MeditationQuestion(
          question: '나는 원수를 사랑하려고 하고 있나요?',
          guide:
              '쉬운 사람만 사랑하고 있지는 않나요? 나를 힘들게 하는 사람을 어떻게 대하고 있나요? 하나님 방식으로 사랑하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 다른 사람을 판단하고 있나요?',
          guide: '쉽게 평가하고 있지는 않나요? 나는 나 자신을 먼저 돌아보고 있나요? 하나님 앞에서 겸손한가요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-7',
      pathId: 'path-luke',
      title: '믿음과 사랑의 반응',
      scriptureReference: '누가복음 7장',
      scriptureText:
          '백부장은 말씀만으로도 치유하실 것을 믿는 큰 믿음을 보여줘요. 예수님은 과부의 아들을 살리시며 긍휼을 나타내세요. 세례 요한은 의문을 가지지만 예수님은 사역으로 답하세요. 한 여인은 눈물로 예수님의 발을 씻으며 사랑을 표현해요. 이 장은 믿음과 사랑이 어떻게 드러나는지를 보여줘요.',
      meditationGuide: '나는 하나님을 얼마나 신뢰하고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 하나님을 얼마나 신뢰하고 있나요?',
          guide: '눈에 보이지 않아도 믿고 있나요? 조건이 있어야 믿는 것은 아닌가요? 하나님을 신뢰하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 사랑을 표현하며 살고 있나요?',
          guide: '마음만으로 끝나고 있지는 않나요? 나는 행동으로 사랑을 드러내고 있나요? 누군가에게 표현하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님께 솔직하게 나아가고 있나요?',
          guide: '감정을 숨기고 있지는 않나요? 나는 있는 그대로 하나님께 나아가고 있나요? 진짜 마음을 드리고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-8',
      pathId: 'path-luke',
      title: '말씀과 믿음의 반응',
      scriptureReference: '누가복음 8장',
      scriptureText:
          '씨 뿌리는 비유를 통해 마음 상태에 따라 말씀이 다르게 받아들여진다고 가르치세요. 폭풍을 잠잠하게 하시며 믿음을 가르치시고, 귀신 들린 사람을 고치세요. 또한 병든 여인과 죽은 소녀를 살리시며 믿음의 중요성을 강조하세요. 제자들은 여전히 두려워해요. 이 장은 말씀과 믿음의 관계를 보여줘요.',
      meditationGuide: '나는 말씀을 어떻게 받아들이고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 말씀을 어떻게 받아들이고 있나요?',
          guide: '듣고 잊어버리고 있지는 않나요? 내 삶에 변화가 있나요? 열매가 나타나고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 두려움보다 믿음을 선택하고 있나요?',
          guide: '상황이 더 크게 보이고 있지는 않나요? 하나님을 바라보고 있나요? 나는 무엇을 선택하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 믿음을 행동으로 옮기고 있나요?',
          guide: '생각만 하고 있지는 않나요? 실제로 움직이고 있나요? 내 삶에서 어떻게 나타나고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-9',
      pathId: 'path-luke',
      title: '제자의 길과 따름의 의미',
      scriptureReference: '누가복음 9장',
      scriptureText:
          '예수님은 제자들을 보내시며 하나님 나라를 전하게 하세요. 오병이어 기적을 통해 하나님의 능력을 보여주시고, 베드로는 예수님을 그리스도로 고백해요. 이후 예수님은 자신의 고난과 죽음을 예고하시고, 제자는 자기 십자가를 지고 따라야 한다고 말씀하세요. 변화산에서 예수님의 영광이 드러나고 하나님의 음성이 들려요. 이 장은 예수를 따른다는 것이 어떤 의미인지 분명하게 보여줘요.',
      meditationGuide: '나는 예수님을 누구라고 고백하고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 예수님을 누구라고 고백하고 있나요?',
          guide:
              '단순히 아는 것이 아니라 나의 고백이 중요해요. 나는 예수님을 어떤 분으로 믿고 있나요? 그 믿음이 내 삶에 드러나고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 십자가를 지는 삶을 살고 있나요?',
          guide:
              '편한 길만 선택하고 있지는 않나요? 하나님이 원하시는 길을 선택하고 있나요? 내가 내려놓아야 할 것은 무엇인가요?',
        ),
        MeditationQuestion(
          question: '나는 끝까지 따르고 있나요?',
          guide: '시작은 쉬워도 계속 가는 것은 어려워요. 나는 흔들리고 있지는 않나요? 지금도 따라가고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-10',
      pathId: 'path-luke',
      title: '사랑과 섬김의 삶',
      scriptureReference: '누가복음 10장',
      scriptureText:
          '예수님은 70인을 보내시며 복음을 전하게 하세요. 사역을 통해 기쁨을 경험하지만 예수님은 하나님과의 관계를 더 중요하게 말씀하세요. 선한 사마리아인의 비유를 통해 진짜 이웃 사랑이 무엇인지 보여주세요. 또한 마르다와 마리아 이야기를 통해 하나님과의 관계가 우선임을 강조하세요. 이 장은 사랑과 섬김, 그리고 우선순위를 가르쳐요.',
      meditationGuide: '나는 진짜로 사랑을 실천하고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 진짜로 사랑을 실천하고 있나요?',
          guide: '말로만 사랑하고 있지는 않나요? 나는 실제로 누군가를 돕고 있나요? 행동으로 나타나고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님과의 관계를 우선하고 있나요?',
          guide:
              '바쁘다는 이유로 하나님을 뒤로 미루고 있지는 않나요? 나는 무엇을 먼저 두고 있나요? 내 시간은 어디에 쓰이고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님 앞에 머무는 시간을 가지고 있나요?',
          guide:
              '마리아는 예수님 발 앞에 머물렀어요. 나는 멈추고 하나님과 시간을 보내고 있나요? 분주함이 그 시간을 빼앗고 있지는 않나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-11',
      pathId: 'path-luke',
      title: '기도와 마음의 상태',
      scriptureReference: '누가복음 11장',
      scriptureText:
          '예수님은 제자들에게 기도를 가르치시며 하나님과의 관계를 보여주세요. 구하고 찾고 두드리라고 말씀하시며 끈질긴 기도의 중요성을 강조하세요. 또한 귀신을 쫓아내시며 하나님의 나라가 임했음을 보여주세요. 외식하는 신앙을 책망하시며 마음의 상태를 강조하세요. 이 장은 기도와 내면의 중요성을 보여줘요.',
      meditationGuide: '나는 하나님과 대화하며 살고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 하나님과 대화하며 살고 있나요?',
          guide:
              '기도가 형식이 되어버리지는 않았나요? 나는 진짜로 하나님과 이야기하고 있나요? 하나님과의 관계가 살아 있나요?',
        ),
        MeditationQuestion(
          question: '나는 끈기 있게 기도하고 있나요?',
          guide: '기도를 하다 금방 포기하고 있지는 않나요? 계속해서 주님의 답을 구하고 있나요? 하나님을 신뢰하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 마음이 깨끗한 상태인가요?',
          guide: '겉은 괜찮아 보여도 속은 다를 수 있어요. 나는 내 마음을 점검하고 있나요? 하나님 앞에서 정직한가요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-12',
      pathId: 'path-luke',
      title: '두려움이 아닌 하나님을 바라보는 삶',
      scriptureReference: '누가복음 12장',
      scriptureText:
          '예수님은 외식과 위선을 경고하시며 하나님 앞에서 드러날 것을 말씀하세요. 사람을 두려워하지 말고 하나님을 두려워하라고 가르치세요. 또한 재물에 대한 비유를 통해 욕심의 위험성을 보여주세요. 염려하지 말고 하나님을 신뢰하라고 말씀하시며 준비된 삶을 강조하세요. 이 장은 무엇을 두려워하고 무엇을 바라보며 살아야 하는지를 알려줘요.',
      meditationGuide: '나는 무엇을 가장 두려워하고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 무엇을 가장 두려워하고 있나요?',
          guide:
              '사람의 시선이나 상황을 더 두려워하고 있지는 않나요? 나는 하나님을 더 의식하며 살고 있나요? 내 마음을 붙잡고 있는 것은 무엇인가요?',
        ),
        MeditationQuestion(
          question: '나는 하나님을 신뢰하며 살고 있나요?',
          guide:
              '염려가 많아지고 있지는 않나요? 나는 하나님이 돌보신다는 사실을 믿고 있나요? 그 믿음이 내 삶에 드러나고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 준비된 삶을 살고 있나요?',
          guide:
              '언젠가 준비하려고 하고 있지는 않나요? 지금 하나님 앞에서 깨어 있나요? 내 삶의 방향은 어디를 향하고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-13',
      pathId: 'path-luke',
      title: '회개와 하나님 나라의 성장',
      scriptureReference: '누가복음 13장',
      scriptureText:
          '예수님은 회개하지 않으면 멸망할 수밖에 없다고 말씀하세요. 열매 맺지 못하는 무화과나무 비유를 통해 기회를 주시는 하나님의 인내를 보여주세요. 또한 안식일에 병든 여인을 고치시며 사람을 살리는 것이 중요함을 드러내세요. 겨자씨와 누룩의 비유로 하나님 나라의 확장을 설명하세요. 이 장은 회개와 변화, 그리고 하나님 나라의 성장을 보여줘요.',
      meditationGuide: '나는 지금 변화되고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 지금 변화되고 있나요?',
          guide: '회개는 한 번이 아니라 계속되는 과정이에요. 나는 계속 변화되고 있나요? 아니면 같은 자리에 머물러 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님이 주신 기회를 사용하고 있나요?',
          guide:
              '하나님은 기다려주시지만 영원히 미루면 안 돼요. 나는 지금 기회를 붙잡고 있나요? 변화하려고 노력하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 작은 믿음을 소중히 여기고 있나요?',
          guide: '작은 시작이 크게 자랄 수 있어요. 나는 작다고 무시하고 있지는 않나요? 하나님이 일하심을 믿고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-14',
      pathId: 'path-luke',
      title: '겸손과 제자의 대가',
      scriptureReference: '누가복음 14장',
      scriptureText:
          '예수님은 잔치 자리에서 겸손함을 가르치세요. 낮은 자를 초대하라고 하시며 하나님 나라의 가치관을 보여주세요. 큰 잔치 비유를 통해 초대를 거절하는 사람들의 모습을 말씀하세요. 또한 예수님을 따르는 것은 비용을 계산해야 할 만큼 진지한 결정이라고 가르치세요. 이 장은 겸손과 헌신의 중요성을 강조해요.',
      meditationGuide: '나는 겸손한 태도로 살고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 겸손한 태도로 살고 있나요?',
          guide: '높아지고 싶어 하는 마음이 크지 않나요? 나는 낮아지는 선택을 하고 있나요? 하나님 앞에서 어떤 태도인가요?',
        ),
        MeditationQuestion(
          question: '나는 하나님 나라를 우선하고 있나요?',
          guide:
              '다른 것들 때문에 하나님을 뒤로 미루고 있지는 않나요? 나는 무엇을 더 중요하게 여기고 있나요? 내 삶의 우선순위는 무엇인가요?',
        ),
        MeditationQuestion(
          question: '나는 예수님을 따를 준비가 되어 있나요?',
          guide: '따르는 것은 말이 아니라 결단이에요. 나는 실제로 따르고 있나요? 포기해야 할 것은 무엇인가요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-15',
      pathId: 'path-luke',
      title: '잃은 자를 찾으시는 하나님',
      scriptureReference: '누가복음 15장',
      scriptureText:
          '예수님은 잃은 양, 잃은 드라크마, 돌아온 아들의 비유를 통해 하나님의 마음을 보여주세요. 하나님은 한 사람이라도 잃어버리지 않으시고 끝까지 찾으세요. 특히 돌아온 아들을 기쁨으로 맞이하는 아버지의 모습에서 하나님의 사랑이 드러나요. 반면 큰아들은 마음으로는 아버지와 멀어져 있었어요. 이 장은 하나님이 어떤 마음으로 우리를 바라보시는지를 보여줘요.',
      meditationGuide: '나는 하나님께 돌아가고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 하나님께 돌아가고 있나요?',
          guide:
              '멀어져 있으면서도 괜찮다고 생각하고 있지는 않나요? 나는 하나님께 다시 나아가고 있나요? 지금 내 마음의 방향은 어디를 향하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님의 사랑을 받아들이고 있나요?',
          guide:
              '이미 사랑받고 있는데도 스스로 거부하고 있지는 않나요? 나는 그 사랑을 믿고 있나요? 내 삶에서 그것을 누리고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 다른 사람을 판단하고 있나요?',
          guide:
              '큰아들처럼 겉으로는 괜찮아 보여도 마음은 다를 수 있어요. 나는 다른 사람을 비교하고 판단하고 있지는 않나요? 하나님의 마음으로 바라보고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-16',
      pathId: 'path-luke',
      title: '재물과 영원한 가치',
      scriptureReference: '누가복음 16장',
      scriptureText:
          '예수님은 불의한 청지기의 비유를 통해 지혜롭게 살아야 함을 가르치세요. 재물은 영원하지 않으며 하나님과 재물을 동시에 섬길 수 없다고 말씀하세요. 또한 부자와 나사로의 이야기를 통해 이 땅의 삶이 끝이 아니라는 것을 보여주세요. 지금의 선택이 영원과 연결돼 있어요. 이 장은 무엇을 기준으로 살아야 하는지를 다시 생각하게 해요.',
      meditationGuide: '나는 무엇을 가장 중요하게 여기고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 무엇을 가장 중요하게 여기고 있나요?',
          guide:
              '돈과 성공이 기준이 되고 있지는 않나요? 나는 무엇을 중심으로 선택하고 있나요? 내 삶의 방향은 어디를 향하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님을 우선으로 두고 있나요?',
          guide:
              '하나님과 다른 것을 동시에 붙잡고 있지는 않나요? 나는 무엇을 더 사랑하고 있나요? 내 선택에서 드러나고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 영원을 생각하며 살고 있나요?',
          guide:
              '지금의 삶이 전부라고 생각하고 있지는 않나요? 하나님 앞에서의 삶을 생각하고 있나요? 오늘의 선택이 어떤 의미를 가지나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-17',
      pathId: 'path-luke',
      title: '감사와 하나님 나라의 인식',
      scriptureReference: '누가복음 17장',
      scriptureText:
          '예수님은 용서와 믿음의 중요성을 가르치세요. 열 명의 나병환자가 고침을 받지만 오직 한 사람만 돌아와 감사해요. 하나님 나라는 눈에 보이는 방식이 아니라 이미 임해 있다고 말씀하세요. 또한 마지막 때의 모습을 설명하시며 준비된 삶을 강조하세요. 이 장은 감사와 영적인 시선을 강조해요.',
      meditationGuide: '나는 하나님께 감사하며 살고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 하나님께 감사하며 살고 있나요?',
          guide:
              '받은 것에 익숙해져서 감사하지 않고 있지는 않나요? 나는 감사의 표현을 하고 있나요? 하나님께 돌아가고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님 나라를 인식하며 살고 있나요?',
          guide:
              '눈에 보이는 것만 믿고 있지는 않나요? 하나님이 이미 일하고 계심을 보고 있나요? 나는 무엇을 바라보고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 준비된 삶을 살고 있나요?',
          guide: '갑작스러운 상황을 생각하지 않고 있지는 않나요? 나는 항상 준비되어 있나요? 하나님 앞에서 깨어 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-18',
      pathId: 'path-luke',
      title: '겸손과 끈기 있는 믿음',
      scriptureReference: '누가복음 18장',
      scriptureText:
          '예수님은 끈질기게 구하는 과부의 비유를 통해 기도의 중요성을 가르치세요. 바리새인과 세리의 기도를 통해 겸손한 태도가 하나님께 받아들여진다고 말씀하세요. 어린아이와 같은 자가 하나님 나라에 합당하다고 하세요. 부자 관원은 재물을 내려놓지 못하고 떠나요. 이 장은 하나님 앞에서의 태도가 얼마나 중요한지를 보여줘요.',
      meditationGuide: '나는 하나님께 계속 나아가고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 하나님께 계속 나아가고 있나요?',
          guide:
              '기도를 쉽게 포기하고 있지는 않나요? 나는 꾸준히 하나님께 구하고 있나요? 하나님을 신뢰하며 기다리고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 겸손한 마음으로 하나님께 나아가고 있나요?',
          guide: '스스로 괜찮다고 생각하고 있지는 않나요? 나는 하나님 앞에서 어떤 모습인가요? 진짜로 낮아져 있나요?',
        ),
        MeditationQuestion(
          question: '나는 내려놓지 못하는 것이 있나요?',
          guide:
              '하나님보다 더 붙잡고 있는 것이 있을 수 있어요. 나는 무엇을 놓지 못하고 있나요? 그것이 하나님과의 관계를 막고 있지 않나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-19',
      pathId: 'path-luke',
      title: '회개와 책임, 그리고 왕 되신 예수님',
      scriptureReference: '누가복음 19장',
      scriptureText:
          '삭개오는 예수님을 만나 삶이 완전히 변화돼요. 예수님은 잃은 자를 찾아 구원하러 오셨다고 말씀하세요. 므나 비유를 통해 맡겨진 것에 대한 책임을 강조하세요. 예수님은 예루살렘에 왕으로 입성하시고 성전을 정결하게 하세요. 이 장은 변화된 삶과 책임 있는 신앙을 보여줘요.',
      meditationGuide: '나는 변화된 삶을 살고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 변화된 삶을 살고 있나요?',
          guide: '예수님을 만났다면 변화가 있어야 해요. 나는 이전과 달라졌나요? 내 삶에서 어떤 변화가 나타나고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 맡겨진 것을 잘 사용하고 있나요?',
          guide: '하나님은 각자에게 맡기신 것이 있어요. 나는 그것을 사용하고 있나요? 아니면 그대로 두고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 예수님을 내 삶의 왕으로 인정하고 있나요?',
          guide: '말로만 인정하고 있지는 않나요? 나는 실제로 그분의 뜻을 따르고 있나요? 내 삶의 중심은 누구인가요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-20',
      pathId: 'path-luke',
      title: '권위에 대한 태도',
      scriptureReference: '누가복음 20장',
      scriptureText:
          '종교 지도자들은 예수님의 권위를 인정하지 않으려 해요. 포도원 농부 비유를 통해 하나님을 거부하는 모습을 드러내세요. 사람들은 질문으로 예수님을 시험하지만 예수님은 지혜롭게 답하세요. 이 장은 하나님의 권위를 어떻게 받아들이는지가 중요함을 보여줘요.',
      meditationGuide: '나는 하나님의 권위를 인정하고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 하나님의 권위를 인정하고 있나요?',
          guide: '내 생각이 더 앞서고 있지는 않나요? 나는 하나님을 기준으로 살고 있나요? 내 선택은 무엇을 따르고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님 말씀을 받아들이고 있나요?',
          guide: '불편한 말씀은 피하고 있지는 않나요? 나는 듣고 순종하고 있나요? 내 삶에 적용하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님을 시험하고 있지는 않나요?',
          guide: '조건을 붙이고 있지는 않나요? 나는 하나님을 신뢰하고 있나요? 진짜로 맡기고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-21',
      pathId: 'path-luke',
      title: '헌신과 준비된 삶',
      scriptureReference: '누가복음 21장',
      scriptureText:
          '한 과부의 헌금을 통해 진짜 헌신이 무엇인지 보여주세요. 예수님은 마지막 때의 징조를 말씀하시며 준비된 삶을 강조하세요. 어려움 속에서도 믿음을 지켜야 한다고 하세요. 하나님은 끝까지 함께하신다고 약속하세요. 이 장은 현재를 어떻게 살아야 하는지를 알려줘요.',
      meditationGuide: '나는 진심으로 하나님께 드리고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 진심으로 하나님께 드리고 있나요?',
          guide: '양보다 마음이 중요해요. 나는 어떤 마음으로 드리고 있나요? 하나님을 향한 중심이 있나요?',
        ),
        MeditationQuestion(
          question: '나는 준비된 삶을 살고 있나요?',
          guide: '나중에 하려고 미루고 있지는 않나요? 나는 지금 준비되어 있나요? 하나님 앞에서 깨어 있나요?',
        ),
        MeditationQuestion(
          question: '나는 어려움 속에서도 믿음을 지키고 있나요?',
          guide: '상황이 흔들릴 때 믿음이 드러나요. 나는 어떤 선택을 하고 있나요? 하나님을 붙잡고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-22',
      pathId: 'path-luke',
      title: '고난 속에서의 순종과 연약함',
      scriptureReference: '누가복음 22장',
      scriptureText:
          '예수님은 제자들과 마지막 만찬을 나누시며 자신의 희생을 준비하세요. 제자들은 다투고 흔들리며 유다는 배신해요. 겟세마네에서 예수님은 하나님의 뜻에 순종하세요. 베드로는 예수님을 부인하며 인간의 연약함이 드러나요. 이 장은 순종과 인간의 한계를 동시에 보여줘요.',
      meditationGuide: '나는 어려움 속에서도 하나님을 따르고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 어려움 속에서도 하나님을 따르고 있나요?',
          guide: '힘들 때 믿음이 흔들릴 수 있어요. 나는 하나님을 붙잡고 있나요? 아니면 포기하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 내 연약함을 인정하고 있나요?',
          guide: '스스로 괜찮다고 생각하고 있지는 않나요? 나는 내 모습을 인정하고 있나요? 하나님께 나아가고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님의 뜻을 선택하고 있나요?',
          guide: '내 뜻과 하나님의 뜻이 다를 수 있어요. 나는 무엇을 선택하고 있나요? 순종하고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-23',
      pathId: 'path-luke',
      title: '십자가와 용서',
      scriptureReference: '누가복음 23장',
      scriptureText:
          '예수님은 죄가 없으시지만 십자가에서 고난을 받으세요. 사람들은 조롱하지만 예수님은 용서의 기도를 하세요. 함께 십자가에 달린 한 죄인은 예수님을 믿고 구원을 받아요. 예수님은 끝까지 하나님의 뜻을 이루세요. 이 장은 십자가의 사랑과 용서를 보여줘요.',
      meditationGuide: '나는 용서하며 살고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 용서하며 살고 있나요?',
          guide: '상처를 붙잡고 있지는 않나요? 나는 용서하려고 노력하고 있나요? 하나님이 나를 용서하신 것처럼 하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 예수님의 사랑을 받아들이고 있나요?',
          guide: '그 사랑을 당연하게 여기고 있지는 않나요? 나는 진심으로 받아들이고 있나요? 내 삶에 변화가 있나요?',
        ),
        MeditationQuestion(
          question: '나는 하나님을 신뢰하고 있나요?',
          guide: '힘든 상황에서도 하나님을 믿고 있나요? 나는 끝까지 맡기고 있나요? 어떤 태도를 가지고 있나요?',
        ),
      ],
    ),
    LessonContent(
      lessonId: 'luke-lesson-24',
      pathId: 'path-luke',
      title: '부활과 새로운 시작',
      scriptureReference: '누가복음 24장',
      scriptureText:
          '예수님은 죽음을 이기고 부활하세요. 제자들은 처음에는 믿지 못하지만 예수님을 만나며 믿음이 회복돼요. 엠마오로 가는 제자들에게 말씀을 풀어주시며 깨닫게 하세요. 이후 제자들에게 나타나 사명을 주시고 떠나세요. 이 장은 절망에서 믿음으로, 끝에서 시작으로 바뀌는 모습을 보여줘요.',
      meditationGuide: '나는 부활을 진짜 믿고 있나요?',
      meditationQuestions: [
        MeditationQuestion(
          question: '나는 부활을 진짜 믿고 있나요?',
          guide: '부활은 단순한 사건이 아니에요. 나는 마음으로 믿고 있나요? 그 믿음이 내 삶에 영향을 주고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 말씀을 통해 깨닫고 있나요?',
          guide: '듣기만 하고 끝나고 있지는 않나요? 나는 말씀을 깊이 이해하고 있나요? 삶에 적용하고 있나요?',
        ),
        MeditationQuestion(
          question: '나는 새로운 시작을 살아가고 있나요?',
          guide: '과거에 머물러 있지는 않나요? 하나님이 주시는 새로운 삶을 살고 있나요? 지금 어떤 선택을 하고 있나요?',
        ),
      ],
    ),
  ];
}
