import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/services/sound_service.dart';
import '../../../shared/widgets/point_toast.dart';
import '../providers/quiz_provider.dart';

/// 퀴즈 화면 (듀오링고 스타일)
class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({
    super.key,
    required this.pathId,
    required this.lessonId,
  });

  final String pathId;
  final String lessonId;

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _feedbackController;
  late Animation<double> _feedbackAnimation;

  @override
  void initState() {
    super.initState();
    SoundService.instance.init();

    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _feedbackAnimation = CurvedAnimation(
      parent: _feedbackController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final quizState = ref.watch(quizProvider(widget.lessonId));

    // 퀴즈 완료 시 결과 화면으로 이동
    if (quizState.isFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(
          '/study/${widget.pathId}/${widget.lessonId}/quiz-result',
        );
      });
      return const SizedBox.shrink();
    }

    final question = quizState.currentQuestion;
    final progress = quizState.progress;
    final hasAnswered = quizState.hasAnswered;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // ━━━ 상단 바: 닫기 + 프로그레스 바 ━━━
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLG,
                vertical: AppTheme.spacingMD,
              ),
              child: Row(
                children: [
                  // 닫기 버튼
                  GestureDetector(
                    onTap: () => _showExitDialog(context),
                    child: Icon(
                      Icons.close,
                      color: subTextColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMD),

                  // 프로그레스 바
                  Expanded(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusRound),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: progress),
                        duration: const Duration(milliseconds: 400),
                        builder: (context, value, _) {
                          return LinearProgressIndicator(
                            value: value,
                            minHeight: 12,
                            backgroundColor: isDark
                                ? Colors.white.withValues(alpha: 0.1)
                                : AppColors.primary.withValues(alpha: 0.15),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.primaryDark,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMD),

                  // 문제 번호
                  Text(
                    '${quizState.currentIndex + 1}/${quizState.totalQuestions}',
                    style: AppTypography.titleMedium(subTextColor),
                  ),
                ],
              ),
            ),

            // ━━━ 질문 영역 ━━━
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingXL,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: AppTheme.spacingXXL),

                    // 질문 아이콘
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.quiz_outlined,
                        color: AppColors.primaryDark,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXL),

                    // 질문 텍스트
                    Text(
                      question.question,
                      textAlign: TextAlign.center,
                      style: AppTypography.headlineMedium(textColor).copyWith(
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXXL),

                    // ━━━ 선택지 버튼들 ━━━
                    ...List.generate(question.options.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppTheme.spacingMD,
                        ),
                        child: _buildOptionButton(
                          context,
                          index: index,
                          text: question.options[index],
                          quizState: quizState,
                          textColor: textColor,
                          isDark: isDark,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

            // ━━━ 하단 피드백 배너 + 계속 버튼 ━━━
            if (hasAnswered)
              FadeTransition(
                opacity: _feedbackAnimation,
                child: _buildFeedbackBanner(
                  context,
                  quizState: quizState,
                  textColor: textColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 선택지 버튼
  Widget _buildOptionButton(
    BuildContext context, {
    required int index,
    required String text,
    required QuizState quizState,
    required Color textColor,
    required bool isDark,
  }) {
    final hasAnswered = quizState.hasAnswered;
    final isSelected = quizState.selectedOptionIndex == index;
    final isCorrectOption =
        index == quizState.currentQuestion.correctIndex;

    // 색상 결정
    Color bgColor;
    Color borderColor;
    Color labelColor;
    IconData? trailingIcon;

    if (!hasAnswered) {
      // 아직 답변 전
      bgColor = isDark
          ? Colors.white.withValues(alpha: 0.06)
          : Colors.white;
      borderColor = isDark
          ? Colors.white.withValues(alpha: 0.12)
          : AppColors.primary.withValues(alpha: 0.3);
      labelColor = textColor;
    } else if (isCorrectOption) {
      // 정답 옵션 (항상 초록색)
      bgColor = AppColors.quizCorrect.withValues(alpha: 0.12);
      borderColor = AppColors.quizCorrect;
      labelColor = AppColors.quizCorrectDark;
      trailingIcon = Icons.check_circle;
    } else if (isSelected && !isCorrectOption) {
      // 선택한 오답
      bgColor = AppColors.error.withValues(alpha: 0.12);
      borderColor = AppColors.error;
      labelColor = AppColors.quizIncorrectDark;
      trailingIcon = Icons.cancel;
    } else {
      // 선택하지 않은 다른 옵션
      bgColor = isDark
          ? Colors.white.withValues(alpha: 0.03)
          : Colors.white.withValues(alpha: 0.5);
      borderColor = isDark
          ? Colors.white.withValues(alpha: 0.06)
          : AppColors.primary.withValues(alpha: 0.1);
      labelColor = textColor.withValues(alpha: 0.4);
    }

    return GestureDetector(
      onTap: hasAnswered ? null : () => _submitAnswer(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingXL,
          vertical: AppTheme.spacingLG,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: !hasAnswered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            // 번호 원형
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: hasAnswered && (isCorrectOption || isSelected)
                    ? borderColor.withValues(alpha: 0.2)
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : AppColors.primary.withValues(alpha: 0.1)),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D
                  style: AppTypography.titleMedium(
                    hasAnswered && (isCorrectOption || isSelected)
                        ? borderColor
                        : AppColors.primaryDark,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacingMD),

            // 텍스트
            Expanded(
              child: Text(
                text,
                style: AppTypography.bodyLarge(labelColor).copyWith(
                  fontWeight: hasAnswered && (isCorrectOption || isSelected)
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),

            // 정답/오답 아이콘
            if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: borderColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  /// 하단 피드백 배너
  Widget _buildFeedbackBanner(
    BuildContext context, {
    required QuizState quizState,
    required Color textColor,
  }) {
    final isCorrect = quizState.lastResult == QuizAnswerResult.correct;
    final explanation = quizState.currentQuestion.explanation;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.quizCorrect.withValues(alpha: 0.08)
            : AppColors.error.withValues(alpha: 0.08),
        border: Border(
          top: BorderSide(
            color: isCorrect
                ? AppColors.quizCorrect.withValues(alpha: 0.3)
                : AppColors.error.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 결과 텍스트
          Row(
            children: [
              Icon(
                isCorrect ? Icons.celebration : Icons.sentiment_dissatisfied,
                color: isCorrect
                    ? AppColors.quizCorrectDark
                    : AppColors.quizIncorrectDark,
                size: 24,
              ),
              const SizedBox(width: AppTheme.spacingSM),
              Text(
                isCorrect ? '정답이에요! 🎉' : '아쉬워요 😢',
                style: AppTypography.titleLarge(
                  isCorrect
                      ? AppColors.quizCorrectDark
                      : AppColors.quizIncorrectDark,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              if (isCorrect)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.3),
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusRound),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.gold,
                        size: 16,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '+${quizState.currentQuestion.rewardFp} FP',
                        style: AppTypography.label(
                          AppColors.goldDark,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          // 해설
          if (explanation != null) ...[
            const SizedBox(height: AppTheme.spacingMD),
            Text(
              explanation,
              style: AppTypography.bodyMedium(
                isCorrect
                    ? AppColors.quizCorrectDark.withValues(alpha: 0.8)
                    : AppColors.quizIncorrectDark.withValues(alpha: 0.8),
              ),
            ),
          ],

          const SizedBox(height: AppTheme.spacingLG),

          // 계속 버튼
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: isCorrect
                    ? AppColors.quizCorrect
                    : AppColors.error,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppTheme.radiusLarge),
                ),
              ),
              child: Text(
                '계속',
                style: AppTypography.button(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 답변 제출
  void _submitAnswer(int optionIndex) {
    HapticFeedback.mediumImpact();

    final notifier = ref.read(quizProvider(widget.lessonId).notifier);
    final result = notifier.submitAnswer(optionIndex);

    // 효과음 재생
    if (result == QuizAnswerResult.correct) {
      SoundService.instance.playCorrect();
      // FP 토스트 표시
      final size = MediaQuery.of(context).size;
      PointToast.show(
        context,
        points: ref.read(quizProvider(widget.lessonId)).currentQuestion.rewardFp,
        sourceOffset: Offset(size.width / 2, size.height * 0.3),
      );
    } else {
      SoundService.instance.playWrong();
    }

    // 피드백 애니메이션 시작
    _feedbackController.forward(from: 0);
  }

  /// 다음 문제
  void _nextQuestion() {
    HapticFeedback.lightImpact();
    _feedbackController.reverse().then((_) {
      ref.read(quizProvider(widget.lessonId).notifier).nextQuestion();
    });
  }

  /// 나가기 확인 다이얼로그
  void _showExitDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            isDark ? AppColors.darkBackgroundSecondary : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
        ),
        title: Text(
          '퀴즈를 그만둘까요?',
          style: AppTypography.titleLarge(
            isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        content: Text(
          '지금까지의 진행이 사라져요.',
          style: AppTypography.bodyMedium(
            isDark
                ? AppColors.darkTextSecondary
                : AppColors.lightTextSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              '계속 풀기',
              style: AppTypography.button(AppColors.primaryDark),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/home');
            },
            child: Text(
              '나가기',
              style: AppTypography.button(AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
