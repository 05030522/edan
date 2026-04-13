import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_card.dart';

/// 교회 미등록 시 빈 상태 위젯
class NoChurchEmptyState extends StatelessWidget {
  const NoChurchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final subTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return GlassCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppTheme.spacingXL),
          Icon(
            Icons.church_outlined,
            size: 64,
            color: subTextColor.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppTheme.spacingXL),
          Text(
            '소속 교회를 등록하면',
            style: AppTypography.bodyLarge(textColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingXS),
          Text(
            '같은 교회 성도들과 함께할 수 있어요',
            style: AppTypography.bodyMedium(subTextColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingXXL),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.push('/profile/settings'),
              child: const Text('교회 등록하기'),
            ),
          ),
          const SizedBox(height: AppTheme.spacingXL),
        ],
      ),
    );
  }
}
