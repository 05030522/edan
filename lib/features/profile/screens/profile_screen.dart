import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../auth/providers/auth_provider.dart';

/// 프로필 화면
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // 화면 진입 시 프로필 최신 데이터로 갱신
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(authProvider.notifier).refreshProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    // Auth 프로바이더에서 프로필만 선택적으로 watch
    final profile = ref.watch(authProvider.select((s) => s.profile));
    final displayName = profile?.displayName.isNotEmpty == true
        ? profile!.displayName
        : '에덴 사용자';
    final currentLevel = profile?.currentLevel ?? 1;
    final streakCount = profile?.currentStreak ?? 0;
    final totalFP = profile?.faithPoints ?? 0;

    // 레벨 인덱스 안전하게 접근
    final levelIndex =
        (currentLevel - 1).clamp(0, AppConstants.levelNames.length - 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 정보',
          style: AppTypography.titleLarge(textColor),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: textColor),
            onPressed: () => context.push('/profile/settings'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(authProvider.notifier).refreshProfile(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                        'Lv.$currentLevel ${AppConstants.levelNames[levelIndex]}',
                        style: AppTypography.label(AppColors.gardenSoil),
                      ),
                    ),

                    // 레벨 진행 바
                    if (currentLevel < AppConstants.levelThresholds.length) ...[
                      const SizedBox(height: AppTheme.spacingLG),
                      _buildLevelProgress(
                        currentFP: totalFP,
                        currentLevel: currentLevel,
                        textColor: textColor,
                        subTextColor: subTextColor,
                      ),
                    ],
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
                      label: '연속 묵상',
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.calendar_today,
                      iconColor: AppColors.primary,
                      value: '$currentLevel',
                      label: '레벨',
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

              // 스테인드글라스 달력
              const _StainedGlassCalendar(),
              const SizedBox(height: AppTheme.spacingXL),

              // 교회 정보
              if (profile?.churchName != null && profile!.churchName!.isNotEmpty) ...[
                GlassCard(
                  child: Row(
                    children: [
                      Icon(
                        Icons.church_outlined,
                        color: subTextColor,
                        size: 22,
                      ),
                      const SizedBox(width: AppTheme.spacingMD),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '소속 교회',
                              style: AppTypography.label(subTextColor),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              profile.churchName!,
                              style: AppTypography.bodyLarge(textColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacingXL),
              ],

              // 설정 버튼
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.push('/profile/settings'),
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
      ),
    );
  }

  /// 레벨 진행 바
  Widget _buildLevelProgress({
    required int currentFP,
    required int currentLevel,
    required Color textColor,
    required Color subTextColor,
  }) {
    final currentThreshold = AppConstants.levelThresholds[currentLevel - 1];
    final nextThreshold = currentLevel < AppConstants.levelThresholds.length
        ? AppConstants.levelThresholds[currentLevel]
        : AppConstants.levelThresholds.last;
    final progress = nextThreshold > currentThreshold
        ? ((currentFP - currentThreshold) / (nextThreshold - currentThreshold))
            .clamp(0.0, 1.0)
        : 1.0;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            color: AppColors.primary,
            minHeight: 8,
          ),
        ),
        const SizedBox(height: AppTheme.spacingXS),
        Text(
          '$currentFP / $nextThreshold FP',
          style: AppTypography.label(subTextColor),
        ),
      ],
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

/// 스테인드글라스 월간 달력 위젯
class _StainedGlassCalendar extends ConsumerStatefulWidget {
  const _StainedGlassCalendar();

  @override
  ConsumerState<_StainedGlassCalendar> createState() =>
      _StainedGlassCalendarState();
}

class _StainedGlassCalendarState extends ConsumerState<_StainedGlassCalendar> {
  late DateTime _displayMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _displayMonth = DateTime(now.year, now.month);
  }

  void _prevMonth() {
    setState(() {
      _displayMonth = DateTime(_displayMonth.year, _displayMonth.month - 1);
    });
  }

  void _nextMonth() {
    final now = DateTime.now();
    final next = DateTime(_displayMonth.year, _displayMonth.month + 1);
    if (next.isBefore(DateTime(now.year, now.month + 1))) {
      setState(() => _displayMonth = next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final authState = ref.watch(authProvider);
    final profile = authState.profile;
    final streak = profile?.currentStreak ?? 0;
    final lastStudy = profile?.lastStudyDate;

    // 완료 날짜 세트
    final completedDays = <DateTime>{};
    if (lastStudy != null && streak > 0) {
      final lastDay = DateTime(lastStudy.year, lastStudy.month, lastStudy.day);
      for (int i = 0; i < streak; i++) {
        completedDays.add(lastDay.subtract(Duration(days: i)));
      }
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final isCurrentMonth = _displayMonth.year == now.year &&
        _displayMonth.month == now.month;

    // 이번 달 묵상 횟수
    final monthCompleted = completedDays
        .where((d) =>
            d.year == _displayMonth.year && d.month == _displayMonth.month)
        .length;

    // 달력 계산
    final firstDay = DateTime(_displayMonth.year, _displayMonth.month, 1);
    final lastDay = DateTime(_displayMonth.year, _displayMonth.month + 1, 0);
    final startWeekday = firstDay.weekday % 7; // 일=0, 월=1, ..., 토=6
    final totalCells = startWeekday + lastDay.day;
    final rows = (totalCells / 7).ceil();

    const weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    final monthNames = [
      '', '1월', '2월', '3월', '4월', '5월', '6월',
      '7월', '8월', '9월', '10월', '11월', '12월',
    ];

    return GlassCard(
      child: Column(
        children: [
          // 월 헤더
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _prevMonth,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(Icons.chevron_left, color: subTextColor, size: 22),
                ),
              ),
              Text(
                '${_displayMonth.year}년 ${monthNames[_displayMonth.month]}',
                style: AppTypography.titleLarge(textColor),
              ),
              GestureDetector(
                onTap: isCurrentMonth ? null : _nextMonth,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.chevron_right,
                    color: isCurrentMonth
                        ? subTextColor.withValues(alpha: 0.3)
                        : subTextColor,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMD),

          // 요일 헤더
          Row(
            children: List.generate(7, (i) {
              Color dayColor;
              if (i == 0) {
                dayColor = AppColors.streakFlame; // 일요일 주황
              } else if (i == 6) {
                dayColor = AppColors.purple; // 토요일 보라
              } else {
                dayColor = subTextColor;
              }
              return Expanded(
                child: Center(
                  child: Text(
                    weekdays[i],
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: dayColor,
                    ),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 6),

          // 날짜 그리드
          ...List.generate(rows, (row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: List.generate(7, (col) {
                  final cellIndex = row * 7 + col;
                  final dayNum = cellIndex - startWeekday + 1;

                  if (dayNum < 1 || dayNum > lastDay.day) {
                    return const Expanded(child: SizedBox(height: 38));
                  }

                  final date = DateTime(
                      _displayMonth.year, _displayMonth.month, dayNum);
                  final isCompleted = completedDays.contains(date);
                  final isToday = date == today;
                  final isFuture = date.isAfter(today);

                  return Expanded(
                    child: Container(
                      height: 38,
                      margin: const EdgeInsets.all(1.5),
                      decoration: BoxDecoration(
                        // 완료일: 따뜻한 금빛 배경
                        color: isCompleted
                            ? (isDark
                                ? AppColors.gold.withValues(alpha: 0.25)
                                : AppColors.gold.withValues(alpha: 0.18))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: isToday
                            ? Border.all(
                                color: AppColors.primaryDark,
                                width: 1.8,
                              )
                            : null,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$dayNum',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isToday
                                    ? FontWeight.w700
                                    : FontWeight.w400,
                                color: isFuture
                                    ? subTextColor.withValues(alpha: 0.3)
                                    : isCompleted
                                        ? (isDark
                                            ? AppColors.gold
                                            : const Color(0xFFB8960A))
                                        : (col == 0
                                            ? AppColors.streakFlame
                                                .withValues(alpha: 0.7)
                                            : textColor),
                              ),
                            ),
                            if (isCompleted)
                              Text(
                                '✦',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: isDark
                                      ? AppColors.gold
                                      : const Color(0xFFD4A843),
                                  height: 1,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
          const SizedBox(height: AppTheme.spacingMD),

          // 하단 격려 메시지
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: AppTheme.spacingSM, horizontal: AppTheme.spacingMD),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.gold.withValues(alpha: 0.08)
                  : AppColors.gold.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  monthCompleted > 0
                      ? '이번 달 $monthCompleted일 묵상했어요'
                      : '이번 달 첫 묵상을 시작해보세요',
                  style: AppTypography.bodySmall(
                    isDark ? AppColors.gold : const Color(0xFFB8960A),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  monthCompleted > 0 ? '🕊️' : '🌱',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
