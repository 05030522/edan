import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_card.dart';

/// 학습 경로 목록 화면
class LearningPathsScreen extends ConsumerWidget {
  const LearningPathsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '묵상',
          style: AppTypography.titleLarge(textColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        children: [
          // 소개 텍스트
          Text(
            '학습 경로를 선택하세요',
            style: AppTypography.bodyMedium(subTextColor),
          ),
          const SizedBox(height: AppTheme.spacingXL),

          // 경로 1: 신앙의 첫걸음
          _LearningPathCard(
            title: '신앙의 첫걸음',
            description: '처음 믿음의 길을 걷는 분들을 위한 기초 과정이에요. '
                '성경의 핵심 이야기를 함께 읽어봐요.',
            difficulty: '입문',
            totalDays: 14,
            completedDays: 0,
            iconData: Icons.eco,
            iconColor: AppColors.gardenSprout,
            onTap: () {
              context.go('/study/path-1/lesson-1/scripture');
            },
          ),
          const SizedBox(height: AppTheme.spacingLG),

          // 경로 2: 불안을 넘어 평안으로
          _LearningPathCard(
            title: '불안을 넘어 평안으로',
            description: '걱정과 불안 속에서 하나님의 평안을 찾는 여정이에요. '
                '말씀 안에서 쉼을 발견해요.',
            difficulty: '중급',
            totalDays: 14,
            completedDays: 0,
            iconData: Icons.spa,
            iconColor: AppColors.purple,
            onTap: () {
              context.go('/study/path-2/lesson-1/scripture');
            },
          ),
        ],
      ),
    );
  }
}

/// 학습 경로 카드 위젯
class _LearningPathCard extends StatelessWidget {
  final String title;
  final String description;
  final String difficulty;
  final int totalDays;
  final int completedDays;
  final IconData iconData;
  final Color iconColor;
  final VoidCallback onTap;

  const _LearningPathCard({
    required this.title,
    required this.description,
    required this.difficulty,
    required this.totalDays,
    required this.completedDays,
    required this.iconData,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final progress = totalDays > 0 ? completedDays / totalDays : 0.0;

    return GlassCard(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // 아이콘
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: Icon(
                    iconData,
                    color: iconColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMD),

                // 타이틀 + 난이도
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.titleLarge(textColor),
                      ),
                      const SizedBox(height: AppTheme.spacingXS),
                      Row(
                        children: [
                          // 난이도 배지
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusRound,
                              ),
                            ),
                            child: Text(
                              difficulty,
                              style:
                                  AppTypography.label(AppColors.primaryDark),
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingSM),
                          Text(
                            '$totalDays일',
                            style: AppTypography.bodySmall(subTextColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 화살표
                Icon(
                  Icons.chevron_right,
                  color: subTextColor,
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingMD),

            // 설명
            Text(
              description,
              style: AppTypography.bodySmall(subTextColor),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppTheme.spacingMD),

            // 진행 바
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor:
                          AppColors.primary.withValues(alpha: 0.15),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.primaryDark,
                      ),
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMD),
                Text(
                  '$completedDays/$totalDays',
                  style: AppTypography.label(subTextColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
