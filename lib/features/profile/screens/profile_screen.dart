import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/glass_card.dart';

/// 프로필 화면
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    // 플레이스홀더 데이터
    const String displayName = '에덴 사용자';
    const int currentLevel = 1;
    const int streakCount = 0;
    const int totalStudyDays = 0;
    const int totalFP = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '나',
          style: AppTypography.titleLarge(textColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: textColor),
            onPressed: () => context.go('/profile/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          children: [
            // 프로필 정보
            GlassCard(
              child: Column(
                children: [
                  // 아바타
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColors.primaryDark,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingMD),

                  // 이름
                  Text(
                    displayName,
                    style: AppTypography.headlineMedium(textColor),
                  ),
                  const SizedBox(height: AppTheme.spacingSM),

                  // 레벨 배지
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMD,
                      vertical: AppTheme.spacingXS,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gardenSoil.withValues(alpha: 0.15),
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusRound),
                    ),
                    child: Text(
                      'Lv.$currentLevel ${AppConstants.levelNames[currentLevel - 1]}',
                      style: AppTypography.label(AppColors.gardenSoil),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // 통계 행
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.local_fire_department,
                    iconColor: AppColors.streakFlame,
                    value: '$streakCount',
                    label: '스트릭',
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMD),
                Expanded(
                  child: _StatCard(
                    icon: Icons.calendar_today,
                    iconColor: AppColors.primary,
                    value: '$totalStudyDays',
                    label: '학습일',
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMD),
                Expanded(
                  child: _StatCard(
                    icon: Icons.stars,
                    iconColor: AppColors.gold,
                    value: '$totalFP',
                    label: 'FP',
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // 캘린더 히트맵
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '묵상 기록',
                    style: AppTypography.titleMedium(textColor),
                  ),
                  const SizedBox(height: AppTheme.spacingMD),

                  // 7x5 히트맵 그리드 (플레이스홀더)
                  _CalendarHeatmap(),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),

            // 설정 버튼
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.go('/profile/settings'),
                icon: Icon(Icons.settings_outlined, color: subTextColor),
                label: Text(
                  '설정',
                  style: AppTypography.button(subTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 통계 카드 위젯
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GlassCard(
      padding: const EdgeInsets.all(AppTheme.spacingMD),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: AppTheme.spacingSM),
          Text(
            value,
            style: AppTypography.streakNumber(textColor),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTypography.label(subTextColor),
          ),
        ],
      ),
    );
  }
}

/// 캘린더 히트맵 위젯 (플레이스홀더)
class _CalendarHeatmap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 35, // 7x5
      itemBuilder: (context, index) {
        // 플레이스홀더: 모든 칸을 비활성 상태로
        return Container(
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.darkCard
                : AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }
}
