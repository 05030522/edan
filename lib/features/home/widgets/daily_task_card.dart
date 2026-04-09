import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/talent_icon.dart';
import '../providers/daily_tasks_provider.dart';

/// 일일 태스크 카드 위젯
/// 묵상/기도/말씀읽기 각 태스크를 표시
class DailyTaskCard extends StatelessWidget {
  const DailyTaskCard({
    super.key,
    required this.task,
    required this.onStart,
    this.onComplete,
  });

  final DailyTask task;
  final VoidCallback onStart;
  final VoidCallback? onComplete;

  IconData get _icon {
    switch (task.type) {
      case DailyTaskType.meditation:
        return Icons.auto_stories;
      case DailyTaskType.prayer:
        return Icons.volunteer_activism;
      case DailyTaskType.bibleReading:
        return Icons.menu_book;
    }
  }

  Color get _iconColor {
    switch (task.type) {
      case DailyTaskType.meditation:
        return const Color(0xFF8D6E63); // warm brown
      case DailyTaskType.prayer:
        return const Color(0xFFE5C88E); // gold
      case DailyTaskType.bibleReading:
        return const Color(0xFF7BA884); // green
    }
  }

  String get _ctaText {
    switch (task.type) {
      case DailyTaskType.meditation:
        return '시작하기';
      case DailyTaskType.prayer:
        return '기도하기';
      case DailyTaskType.bibleReading:
        return '성경으로 이동';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
    final cardColor = isDark
        ? Colors.white.withValues(alpha: 0.06)
        : Colors.white.withValues(alpha: 0.8);

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingLG),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.white.withValues(alpha: 0.5),
        ),
      ),
      clipBehavior: Clip.none,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              // 아이콘
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Icon(
                  _icon,
                  color: _iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppTheme.spacingMD),

              // 텍스트
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: AppTypography.titleMedium(textColor),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      task.subtitle,
                      style: AppTypography.bodySmall(subTextColor),
                    ),
                  ],
                ),
              ),

              // 완료 체크마크
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: task.isCompleted
                    ? Container(
                        key: const ValueKey('completed'),
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 18,
                        ),
                      )
                    : Container(
                        key: const ValueKey('pending'),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: subTextColor.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                        ),
                      ),
              ),
            ],
          ),

          // CTA 버튼 (미완료 시에만 표시)
          if (!task.isCompleted) ...[
            const SizedBox(height: AppTheme.spacingMD),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  minimumSize: const Size(0, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _ctaText,
                      style: AppTypography.button(Colors.white)
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusRound),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '+${task.rewardFp} ',
                            style: AppTypography.label(Colors.white)
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          const TalentIcon(size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
