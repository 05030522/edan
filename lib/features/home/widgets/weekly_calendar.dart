import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';

/// 주간 캘린더 스트립 위젯
/// 월~일 7칸, 오늘 날짜 강조, 완료 상태 표시
class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({super.key, this.completedDays = const {}});

  /// 이번 주에 완료한 요일 인덱스 집합 (0=월, 6=일)
  final Set<int> completedDays;

  static const List<String> _dayLabels = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final subTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final now = DateTime.now();
    // 현재 요일 (월=0 ~ 일=6)
    final todayIndex = (now.weekday - 1) % 7;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final isToday = index == todayIndex;
        final isCompleted = completedDays.contains(index);
        final isPast = index < todayIndex;

        return _DayCell(
          label: _dayLabels[index],
          isToday: isToday,
          isCompleted: isCompleted,
          isPast: isPast,
          textColor: textColor,
          subTextColor: subTextColor,
        );
      }),
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.label,
    required this.isToday,
    required this.isCompleted,
    required this.isPast,
    required this.textColor,
    required this.subTextColor,
  });

  final String label;
  final bool isToday;
  final bool isCompleted;
  final bool isPast;
  final Color textColor;
  final Color subTextColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: AppTypography.label(
            isToday ? AppColors.primaryDark : subTextColor,
          ).copyWith(fontWeight: isToday ? FontWeight.w700 : FontWeight.w500),
        ),
        const SizedBox(height: AppTheme.spacingSM),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isToday
                ? AppColors.primary.withValues(alpha: 0.2)
                : Colors.transparent,
            border: isToday
                ? Border.all(color: AppColors.primaryDark, width: 2)
                : Border.all(
                    color: isCompleted
                        ? AppColors.success
                        : (isPast
                              ? subTextColor.withValues(alpha: 0.2)
                              : subTextColor.withValues(alpha: 0.1)),
                    width: 1.5,
                  ),
          ),
          child: Center(
            child: isCompleted
                ? const Icon(Icons.check, color: AppColors.success, size: 18)
                : Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isToday
                          ? AppColors.primaryDark
                          : Colors.transparent,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
