import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../models/lesson_data.dart';

/// 레슨 성경 읽기 화면 (5단계 중 1단계)
class LessonScriptureScreen extends ConsumerWidget {
  const LessonScriptureScreen({
    super.key,
    required this.pathId,
    required this.lessonId,
  });

  final String pathId;
  final String lessonId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    // 레슨 데이터 조회
    final lesson =
        LessonDataStore.getLesson(pathId, lessonId) ??
        LessonDataStore.defaultLesson;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: textColor),
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          '1/5',
          style: AppTypography.titleMedium(subTextColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppTheme.spacingLG),
            child: Icon(
              Icons.more_horiz,
              color: subTextColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 진행 도트
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingXL,
                vertical: AppTheme.spacingSM,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 0
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.2),
                    ),
                  );
                }),
              ),
            ),

            // 본문 영역
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingXL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppTheme.spacingLG),

                    // 타이틀
                    Text(
                      lesson.title,
                      style: AppTypography.headlineMedium(textColor),
                    ),
                    const SizedBox(height: AppTheme.spacingXL),

                    // 성경 구절 레퍼런스
                    Text(
                      lesson.scriptureReference,
                      style:
                          AppTypography.scriptureReference(AppColors.gold),
                    ),
                    const SizedBox(height: AppTheme.spacingLG),

                    // 성경 본문
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(AppTheme.spacingXL),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppColors.darkCard
                            : AppColors.lightCard,
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusLarge),
                        border: const Border(
                          left: BorderSide(
                            color: AppColors.gold,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        lesson.scriptureText,
                        style: AppTypography.scripture(textColor),
                      ),
                    ),

                    // 묵상 가이드
                    if (lesson.meditationGuide != null) ...[
                      const SizedBox(height: AppTheme.spacingXL),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(AppTheme.spacingLG),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusMedium),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: AppColors.primaryDark,
                              size: 20,
                            ),
                            const SizedBox(width: AppTheme.spacingSM),
                            Expanded(
                              child: Text(
                                lesson.meditationGuide!,
                                style: AppTypography.bodyMedium(
                                  AppColors.primaryDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
                child: ElevatedButton(
                  onPressed: () {
                    context.go('/study/$pathId/$lessonId/quiz');
                  },
                  child: Text(
                    '퀴즈 풀기',
                    style: AppTypography.button(Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
