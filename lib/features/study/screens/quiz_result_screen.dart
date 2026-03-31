import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/sound_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/quiz_provider.dart';
import '../providers/study_progress_provider.dart';

/// 퀴즈 결과 화면
class QuizResultScreen extends ConsumerStatefulWidget {
  const QuizResultScreen({
    super.key,
    required this.pathId,
    required this.lessonId,
  });

  final String pathId;
  final String lessonId;

  @override
  ConsumerState<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends ConsumerState<QuizResultScreen>
    with TickerProviderStateMixin {
  late AnimationController _scoreController;
  late AnimationController _fadeController;
  late Animation<double> _scoreAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // 완료 효과음
    SoundService.instance.playComplete();
    HapticFeedback.heavyImpact();

    // 퀴즈 FP를 프로필에 반영 + 레슨 진척도 저장
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final quizState = ref.read(quizProvider(widget.lessonId));
      final fp = quizState.totalFpEarned;
      if (fp > 0) {
        ref.read(authProvider.notifier).addFaithPoints(fp);
      }
      // 레슨 완료 기록
      ref
          .read(studyProgressProvider.notifier)
          .completeLesson(widget.pathId, widget.lessonId);
    });

    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scoreAnimation = CurvedAnimation(
      parent: _scoreController,
      curve: Curves.easeOutCubic,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    // 순차 애니메이션
    _scoreController.forward().then((_) {
      _fadeController.forward();
    });
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _fadeController.dispose();
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

    final correctCount = quizState.correctCount;
    final totalQuestions = quizState.totalQuestions;
    final wrongCount = quizState.wrongCount;
    final totalFp = quizState.totalFpEarned;
    final percentage =
        totalQuestions > 0 ? (correctCount / totalQuestions * 100).round() : 0;
    final isPerfect = correctCount == totalQuestions;

    // 루양 격려 메시지
    final encouragement = AppConstants.lambyEncouragements[
        Random().nextInt(AppConstants.lambyEncouragements.length)];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingXL,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: AppTheme.spacing3XL),

                    // ━━━ 결과 타이틀 ━━━
                    Text(
                      isPerfect ? '완벽해요! 🎉' : '퀴즈 완료!',
                      style:
                          AppTypography.headlineLarge(textColor),
                    ),
                    const SizedBox(height: AppTheme.spacingSM),
                    Text(
                      quizState.quizSet.title,
                      style: AppTypography.bodyMedium(subTextColor),
                    ),
                    const SizedBox(height: AppTheme.spacingXXL),

                    // ━━━ 원형 점수 차트 ━━━
                    AnimatedBuilder(
                      animation: _scoreAnimation,
                      builder: (context, _) {
                        return SizedBox(
                          width: 180,
                          height: 180,
                          child: CustomPaint(
                            painter: _ScoreRingPainter(
                              progress: _scoreAnimation.value *
                                  (correctCount / totalQuestions),
                              correctRatio:
                                  correctCount / totalQuestions,
                              isDark: isDark,
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${(_scoreAnimation.value * percentage).round()}%',
                                    style: AppTypography.pointDisplay(
                                      AppColors.primaryDark,
                                    ).copyWith(fontSize: 40),
                                  ),
                                  Text(
                                    '$correctCount / $totalQuestions',
                                    style:
                                        AppTypography.titleMedium(subTextColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: AppTheme.spacingXXL),

                    // ━━━ 통계 카드들 ━━━
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Row(
                        children: [
                          // 정답 수
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.check_circle,
                              iconColor: AppColors.quizCorrect,
                              label: '정답',
                              value: '$correctCount',
                              isDark: isDark,
                              textColor: textColor,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingMD),

                          // 오답 수
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.cancel,
                              iconColor: AppColors.error,
                              label: '오답',
                              value: '$wrongCount',
                              isDark: isDark,
                              textColor: textColor,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingMD),

                          // 획득 FP
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.star_rounded,
                              iconColor: AppColors.gold,
                              label: '획득 FP',
                              value: '+$totalFp',
                              isDark: isDark,
                              textColor: textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXXL),

                    // ━━━ 루양 격려 메시지 ━━━
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppTheme.spacingXL),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.05)
                              : AppColors.primary.withValues(alpha: 0.08),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusXLarge),
                        ),
                        child: Row(
                          children: [
                            // 루양 아이콘
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color:
                                    AppColors.primary.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.pets,
                                color: AppColors.primaryDark,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: AppTheme.spacingMD),

                            // 메시지
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '루양',
                                    style: AppTypography.label(
                                            AppColors.primaryDark)
                                        .copyWith(
                                            fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    encouragement,
                                    style: AppTypography.bodyMedium(
                                        textColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXL),
                  ],
                ),
              ),
            ),

            // ━━━ 하단 버튼들 ━━━
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingXL),
              child: Column(
                children: [
                  // 공유카드 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: () => context.go(
                        '/study/${widget.pathId}/${widget.lessonId}/share',
                      ),
                      icon: const Icon(Icons.share, size: 20),
                      label: Text(
                        '묵상 카드 공유하기',
                        style: AppTypography.button(Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusLarge),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMD),

                  // 홈으로 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => context.go('/home'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryDark,
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusLarge),
                        ),
                      ),
                      child: Text(
                        '홈으로',
                        style: AppTypography.button(AppColors.primaryDark),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMD),

                  // 다시 풀기 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () {
                        ref
                            .read(quizProvider(widget.lessonId).notifier)
                            .reset();
                        context.go(
                          '/study/${widget.pathId}/${widget.lessonId}/quiz',
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryDark,
                        side: const BorderSide(color: AppColors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusLarge),
                        ),
                      ),
                      child: Text(
                        '다시 풀기',
                        style: AppTypography.button(AppColors.primaryDark),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 통계 카드 위젯
  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required bool isDark,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMD,
        vertical: AppTheme.spacingLG,
      ),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: AppTheme.spacingSM),
          Text(
            value,
            style: AppTypography.headlineMedium(textColor),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.label(
              isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// 원형 점수 링 페인터
class _ScoreRingPainter extends CustomPainter {
  final double progress;
  final double correctRatio;
  final bool isDark;

  _ScoreRingPainter({
    required this.progress,
    required this.correctRatio,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 14.0;

    // 배경 링
    final bgPaint = Paint()
      ..color = isDark
          ? Colors.white.withValues(alpha: 0.08)
          : AppColors.primary.withValues(alpha: 0.12)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // 점수 링
    final progressPaint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
        colors: correctRatio >= 0.8
            ? [AppColors.quizCorrect, AppColors.gardenSprout]
            : correctRatio >= 0.5
                ? [AppColors.gold, AppColors.streakFlame]
                : [AppColors.error, AppColors.warning],
      ).createShader(
        Rect.fromCircle(center: center, radius: radius),
      );

    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
