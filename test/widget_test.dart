import 'package:flutter_test/flutter_test.dart';
import 'package:eden_app/shared/models/user_profile.dart';
import 'package:eden_app/features/study/models/quiz_question.dart';

/// 에덴 앱 스모크 테스트
/// 핵심 모델과 데이터의 무결성을 빠르게 확인
void main() {
  group('스모크 테스트', () {
    test('UserProfile을 JSON에서 생성할 수 있어야 한다', () {
      final now = DateTime.now();
      final profile = UserProfile.fromJson({
        'id': 'smoke-test',
        'display_name': '테스트',
        'created_at': now.toIso8601String(),
        'updated_at': now.toIso8601String(),
      });

      expect(profile.id, 'smoke-test');
      expect(profile.displayName, '테스트');
    });

    test('퀴즈 데이터가 비어있지 않아야 한다', () {
      expect(DummyQuizData.quizSets.isNotEmpty, true);
    });

    test('모든 퀴즈의 정답 인덱스가 유효해야 한다', () {
      for (final quizSet in DummyQuizData.quizSets) {
        for (final q in quizSet.questions) {
          expect(q.correctIndex >= 0, true,
              reason: '${q.id}: 정답 인덱스가 음수');
          expect(q.correctIndex < q.options.length, true,
              reason: '${q.id}: 정답 인덱스 초과');
        }
      }
    });

    test('기본 퀴즈 폴백이 동작해야 한다', () {
      final fallback = DummyQuizData.getQuizForLesson('없는레슨');
      expect(fallback.questions.isNotEmpty, true);
    });
  });
}
