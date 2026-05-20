import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/luyang_image.dart';
import '../../../shared/widgets/point_toast.dart';
import '../../../shared/utils/streak_helper.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/daily_tasks_provider.dart';
import '../../premium/providers/premium_provider.dart';
import '../models/lesson_data.dart';

/// 묵상하기 — 질문 3개에 답하고 묵상 마무리하는 화면
/// 진입: 퀴즈 결과 화면의 "묵상하러 가기" 버튼
class MeditationReflectionScreen extends ConsumerStatefulWidget {
  const MeditationReflectionScreen({
    super.key,
    required this.pathId,
    required this.lessonId,
  });

  final String pathId;
  final String lessonId;

  @override
  ConsumerState<MeditationReflectionScreen> createState() =>
      _MeditationReflectionScreenState();
}

class _MeditationReflectionScreenState
    extends ConsumerState<MeditationReflectionScreen> {
  final _q1 = TextEditingController();
  final _q2 = TextEditingController();
  final _q3 = TextEditingController();
  bool _completed = false;

  /// 묵상 질문 3개 (Q1=레슨 가이드, Q2/Q3=공통 템플릿)
  List<_ReflectionQuestion> _buildQuestions(LessonContent lesson) {
    return [
      _ReflectionQuestion(
        title: '묵상 질문 1',
        question: lesson.meditationGuide ?? '오늘 말씀이 당신에게 어떻게 다가오나요?',
        hint: '말씀을 묵상하며 떠오른 생각을 적어보세요.',
      ),
      const _ReflectionQuestion(
        title: '묵상 질문 2',
        question: '이 말씀은 지금 내 삶의 어느 부분과 연결되나요?',
        hint: '구체적인 상황이나 관계를 떠올려 보세요.',
      ),
      const _ReflectionQuestion(
        title: '묵상 질문 3',
        question: '오늘 하루, 이 말씀을 어떻게 실천해 볼 수 있을까요?',
        hint: '작은 한 가지 행동이라도 좋아요.',
      ),
    ];
  }

  @override
  void dispose() {
    _q1.dispose();
    _q2.dispose();
    _q3.dispose();
    super.dispose();
  }

  Future<void> _finishMeditation() async {
    // 일일 태스크: 묵상 완료 + 달란트 보상
    final reward = ref
        .read(dailyTasksProvider.notifier)
        .completeTask(DailyTaskType.meditation);
    if (reward > 0) {
      ref.read(authProvider.notifier).addFaithPoints(reward);
    }

    setState(() => _completed = true);

    if (reward > 0 && mounted) {
      final size = MediaQuery.of(context).size;
      PointToast.show(
        context,
        points: reward,
        sourceOffset: Offset(size.width / 2, size.height * 0.3),
      );
      await Future.delayed(const Duration(milliseconds: 900));
    }

    if (!mounted) return;
    await StreakHelper.checkAndUpdate(context, ref);
  }

  bool get _hasAnswer =>
      _q1.text.trim().isNotEmpty ||
      _q2.text.trim().isNotEmpty ||
      _q3.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final subTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final lesson =
        LessonDataStore.getLesson(widget.pathId, widget.lessonId) ??
        LessonDataStore.defaultLesson;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () => context.go('/home'),
        ),
        title: Text('묵상하기', style: AppTypography.titleLarge(textColor)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _completed
            ? _CompletedView(
                lesson: lesson,
                textColor: textColor,
                subTextColor: subTextColor,
                isDark: isDark,
                onShare: () => context.go(
                  '/study/${widget.pathId}/${widget.lessonId}/share',
                ),
                onHome: () => context.go('/home'),
              )
            : _buildReflectionForm(
                lesson: lesson,
                textColor: textColor,
                subTextColor: subTextColor,
                isDark: isDark,
              ),
      ),
    );
  }

  Widget _buildReflectionForm({
    required LessonContent lesson,
    required Color textColor,
    required Color subTextColor,
    required bool isDark,
  }) {
    final questions = _buildQuestions(lesson);
    final controllers = [_q1, _q2, _q3];
    final isPremium = ref.watch(premiumProvider);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingXL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ━ 핵심 내용 ━
                _SectionLabel(
                  label: '핵심 내용',
                  color: AppColors.primaryDark,
                  icon: Icons.bookmark_outline,
                ),
                const SizedBox(height: AppTheme.spacingSM),
                Text(
                  lesson.title,
                  style: AppTypography.headlineMedium(textColor),
                ),
                const SizedBox(height: AppTheme.spacingXS),
                Text(
                  lesson.scriptureReference,
                  style: AppTypography.scriptureReference(AppColors.gold),
                ),
                const SizedBox(height: AppTheme.spacingXL),

                // ━ 내용 해설 (유료 잠금 시 요약만) ━
                _SectionLabel(
                  label: '내용 해설',
                  color: AppColors.primaryDark,
                  icon: Icons.psychology_outlined,
                ),
                const SizedBox(height: AppTheme.spacingSM),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.spacingLG),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.05)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Text(
                    isPremium
                        ? lesson.scriptureText
                        : '${_summary(lesson.scriptureText)}…\n\n유료 콘텐츠를 통해 전체 해설을 읽어보세요.',
                    style: AppTypography.bodyMedium(
                      textColor,
                    ).copyWith(height: 1.7),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXL),

                // ━ 묵상 질문 3개 ━
                for (var i = 0; i < questions.length; i++) ...[
                  _QuestionBlock(
                    isDark: isDark,
                    textColor: textColor,
                    subTextColor: subTextColor,
                    question: questions[i],
                    controller: controllers[i],
                  ),
                  const SizedBox(height: AppTheme.spacingLG),
                ],
              ],
            ),
          ),
        ),

        // 하단 버튼
        Padding(
          padding: const EdgeInsets.all(AppTheme.spacingXL),
          child: SizedBox(
            width: double.infinity,
            child: AnimatedBuilder(
              animation: Listenable.merge([_q1, _q2, _q3]),
              builder: (context, _) {
                final ok = _hasAnswer;
                return ElevatedButton(
                  onPressed: ok ? _finishMeditation : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    '묵상 마무리하기',
                    style: AppTypography.button(Colors.white),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  String _summary(String text) {
    if (text.length <= 80) return text;
    return text.substring(0, 80);
  }
}

class _ReflectionQuestion {
  final String title;
  final String question;
  final String hint;

  const _ReflectionQuestion({
    required this.title,
    required this.question,
    required this.hint,
  });
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.label,
    required this.color,
    required this.icon,
  });

  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.label(
            color,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _QuestionBlock extends StatelessWidget {
  const _QuestionBlock({
    required this.isDark,
    required this.textColor,
    required this.subTextColor,
    required this.question,
    required this.controller,
  });

  final bool isDark;
  final Color textColor;
  final Color subTextColor;
  final _ReflectionQuestion question;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTheme.spacingLG),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.04)
            : AppColors.primary.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primaryDark,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  question.title,
                  style: AppTypography.label(
                    Colors.white,
                  ).copyWith(fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingSM),
          Text(question.question, style: AppTypography.titleMedium(textColor)),
          const SizedBox(height: AppTheme.spacingXS),
          Text(question.hint, style: AppTypography.bodySmall(subTextColor)),
          const SizedBox(height: AppTheme.spacingMD),
          TextField(
            controller: controller,
            maxLines: 4,
            maxLength: 300,
            decoration: InputDecoration(
              hintText: '여기에 적어보세요',
              filled: true,
              fillColor: isDark
                  ? Colors.white.withValues(alpha: 0.06)
                  : Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(AppTheme.spacingMD),
            ),
          ),
        ],
      ),
    );
  }
}

/// 묵상 마무리 후 — 루양 격려 메시지 + 공유 CTA
class _CompletedView extends StatelessWidget {
  const _CompletedView({
    required this.lesson,
    required this.textColor,
    required this.subTextColor,
    required this.isDark,
    required this.onShare,
    required this.onHome,
  });

  final LessonContent lesson;
  final Color textColor;
  final Color subTextColor;
  final bool isDark;
  final VoidCallback onShare;
  final VoidCallback onHome;

  @override
  Widget build(BuildContext context) {
    final encouragement =
        AppConstants.lambyEncouragements[Random().nextInt(
          AppConstants.lambyEncouragements.length,
        )];

    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check, color: Colors.white, size: 48),
          ),
          const SizedBox(height: AppTheme.spacingXL),
          Text('오늘의 묵상을 마쳤어요', style: AppTypography.headlineLarge(textColor)),
          const SizedBox(height: AppTheme.spacingSM),
          Text(
            lesson.title,
            style: AppTypography.bodyMedium(subTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingXXL),

          // 루양 격려 카드
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppTheme.spacingLG),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
            ),
            child: Row(
              children: [
                const LuyangImage(size: 48, shadow: false),
                const SizedBox(width: AppTheme.spacingMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '루양',
                        style: AppTypography.label(
                          AppColors.primaryDark,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        encouragement,
                        style: AppTypography.bodyMedium(textColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // 오늘의 묵상 공유하기
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: onShare,
              icon: const Icon(Icons.share, size: 20),
              label: Text(
                '오늘의 묵상 공유하기',
                style: AppTypography.button(Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDark,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppTheme.spacingMD),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: OutlinedButton(
              onPressed: onHome,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryDark,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                ),
              ),
              child: Text(
                '홈으로',
                style: AppTypography.button(AppColors.primaryDark),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
