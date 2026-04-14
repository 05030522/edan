import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quiz_question.dart';

/// 퀴즈 진행 상태
enum QuizAnswerResult { none, correct, wrong }

class QuizState {
  final QuizSet quizSet;
  final int currentIndex;
  final int correctCount;
  final int wrongCount;
  final int totalFpEarned;
  final QuizAnswerResult lastResult;
  final int? selectedOptionIndex;
  final bool isFinished;

  const QuizState({
    required this.quizSet,
    this.currentIndex = 0,
    this.correctCount = 0,
    this.wrongCount = 0,
    this.totalFpEarned = 0,
    this.lastResult = QuizAnswerResult.none,
    this.selectedOptionIndex,
    this.isFinished = false,
  });

  QuizQuestion get currentQuestion => quizSet.questions[currentIndex];
  int get totalQuestions => quizSet.questions.length;
  double get progress =>
      totalQuestions > 0 ? (currentIndex + 1) / totalQuestions : 0.0;
  bool get hasAnswered => lastResult != QuizAnswerResult.none;

  QuizState copyWith({
    int? currentIndex,
    int? correctCount,
    int? wrongCount,
    int? totalFpEarned,
    QuizAnswerResult? lastResult,
    int? selectedOptionIndex,
    bool? isFinished,
  }) {
    return QuizState(
      quizSet: quizSet,
      currentIndex: currentIndex ?? this.currentIndex,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
      totalFpEarned: totalFpEarned ?? this.totalFpEarned,
      lastResult: lastResult ?? this.lastResult,
      selectedOptionIndex: selectedOptionIndex,
      isFinished: isFinished ?? this.isFinished,
    );
  }
}

/// 퀴즈 노티파이어
class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier(QuizSet quizSet)
    : super(QuizState(quizSet: _shuffleOptions(quizSet)));

  /// 퀴즈 세트의 모든 문제 선택지를 셔플
  static QuizSet _shuffleOptions(QuizSet quizSet) {
    final rng = Random();
    return QuizSet(
      lessonId: quizSet.lessonId,
      title: quizSet.title,
      questions: quizSet.questions.map((q) => q.shuffled(rng)).toList(),
    );
  }

  /// 답변 제출
  QuizAnswerResult submitAnswer(int optionIndex) {
    if (state.hasAnswered) return state.lastResult;

    final isCorrect = optionIndex == state.currentQuestion.correctIndex;
    final result = isCorrect
        ? QuizAnswerResult.correct
        : QuizAnswerResult.wrong;
    final fpEarned = isCorrect ? state.currentQuestion.rewardFp : 0;

    state = state.copyWith(
      lastResult: result,
      selectedOptionIndex: optionIndex,
      correctCount: isCorrect ? state.correctCount + 1 : state.correctCount,
      wrongCount: !isCorrect ? state.wrongCount + 1 : state.wrongCount,
      totalFpEarned: state.totalFpEarned + fpEarned,
    );

    return result;
  }

  /// 다음 문제로 이동
  void nextQuestion() {
    if (state.currentIndex + 1 >= state.totalQuestions) {
      // 퀴즈 종료
      state = state.copyWith(
        isFinished: true,
        lastResult: QuizAnswerResult.none,
      );
    } else {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        lastResult: QuizAnswerResult.none,
        selectedOptionIndex: null,
      );
    }
  }

  /// 퀴즈 리셋 (다시 풀기)
  void reset() {
    state = QuizState(quizSet: state.quizSet);
  }
}

/// 퀴즈 프로바이더 팩토리
final quizProvider = StateNotifierProvider.autoDispose
    .family<QuizNotifier, QuizState, String>((ref, lessonId) {
      final quizSet = DummyQuizData.getQuizForLesson(lessonId);
      return QuizNotifier(quizSet);
    });
