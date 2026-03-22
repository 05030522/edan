import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/point_toast.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/daily_tasks_provider.dart';
import '../widgets/weekly_calendar.dart';
import '../widgets/daily_task_card.dart';

/// 큰 숫자 포맷 (10000 → 10K+)
String _formatNumber(int n) {
  if (n >= 10000) return '${(n / 1000).floor()}K+';
  return '$n';
}

/// 홈 화면 (에덴 정원)
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    final authState = ref.watch(authProvider);
    final profile = authState.profile;
    final streakCount = profile?.currentStreak ?? 0;
    final faithPoints = profile?.faithPoints ?? 0;
    final currentLevel = profile?.currentLevel ?? 1;

    final tasksState = ref.watch(dailyTasksProvider);

    // 주간 캘린더: 오늘 모든 태스크 완료 시 오늘 요일을 완료로 표시
    final completedDays = <int>{};
    if (tasksState.allCompleted) {
      final todayIndex = (DateTime.now().weekday - 1) % 7;
      completedDays.add(todayIndex);
    }

    final now = DateTime.now();
    final weekdayNames = ['월', '화', '수', '목', '금', '토', '일'];
    final todayLabel =
        '${now.month}월 ${now.day}일 ${weekdayNames[(now.weekday - 1) % 7]}';

    // 루양 인사 (날짜 기반으로 고정)
    final greetingIndex = now.day % AppConstants.lambyGreetings.length;
    final greeting = AppConstants.lambyGreetings[greetingIndex];

    final levelIndex =
        (currentLevel - 1).clamp(0, AppConstants.levelNames.length - 1);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingXL,
            vertical: AppTheme.spacingLG,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(
                context,
                streakCount: streakCount,
                faithPoints: faithPoints,
                textColor: textColor,
              ),
              const SizedBox(height: AppTheme.spacingXL),

              WeeklyCalendar(completedDays: completedDays),
              const SizedBox(height: AppTheme.spacingXL),

              // 날짜 표시
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLG,
                  vertical: AppTheme.spacingMD,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : AppColors.primary.withValues(alpha: 0.08),
                  borderRadius:
                      BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 18,
                      color: AppColors.primaryDark,
                    ),
                    const SizedBox(width: AppTheme.spacingSM),
                    Text(
                      todayLabel,
                      style: AppTypography.titleMedium(textColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),

              _buildGardenPreview(
                context,
                currentLevel: currentLevel,
                levelName: AppConstants.levelNames[levelIndex],
              ),
              const SizedBox(height: AppTheme.spacingXL),

              _buildDailyTasks(context, ref,
                  tasksState: tasksState, textColor: textColor),
              const SizedBox(height: AppTheme.spacingXL),

              _buildLambyCard(context,
                  greeting: greeting, textColor: textColor),
              const SizedBox(height: AppTheme.spacingLG),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context, {
    required int streakCount,
    required int faithPoints,
    required Color textColor,
  }) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.go('/profile/settings'),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: Icon(
              Icons.settings_outlined,
              color: textColor.withValues(alpha: 0.6),
              size: 22,
            ),
          ),
        ),
        const Spacer(),

        // 스트릭 pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.streakFlame.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppTheme.radiusRound),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.local_fire_department,
                  color: AppColors.streakFlame, size: 18),
              const SizedBox(width: 4),
              Text(
                '연속 ${_formatNumber(streakCount)}일',
                style: AppTypography.label(AppColors.streakFlame)
                    .copyWith(fontWeight: FontWeight.w700, fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),

        // FP pill - 상점으로 이동
        GestureDetector(
          onTap: () => context.go('/store'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusRound),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rounded, color: AppColors.gold, size: 18),
                const SizedBox(width: 4),
                Text(
                  _formatNumber(faithPoints),
                  style: AppTypography.label(AppColors.goldDark)
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGardenPreview(
    BuildContext context, {
    required int currentLevel,
    required String levelName,
  }) {
    return GestureDetector(
      onTap: () => context.go('/garden'),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gardenSprout, AppColors.primaryDark],
          ),
          borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: AppTheme.spacingLG,
              left: AppTheme.spacingLG,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMD,
                    vertical: AppTheme.spacingSM),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                ),
                child: Text(
                  'Lv.$currentLevel $levelName',
                  style: AppTypography.label(Colors.white),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets, size: 56,
                      color: Colors.white.withValues(alpha: 0.7)),
                  const SizedBox(height: 8),
                  Text('루양의 정원',
                      style: AppTypography.label(
                          Colors.white.withValues(alpha: 0.8))),
                ],
              ),
            ),
            Positioned(
              bottom: AppTheme.spacingLG,
              right: AppTheme.spacingLG,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.touch_app, color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text('들어가기',
                        style: AppTypography.label(Colors.white)
                            .copyWith(fontSize: 11)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyTasks(
    BuildContext context,
    WidgetRef ref, {
    required DailyTasksState tasksState,
    required Color textColor,
  }) {
    return Column(
      children: tasksState.tasks.asMap().entries.map((entry) {
        final index = entry.key;
        final task = entry.value;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index < tasksState.tasks.length - 1
                ? AppTheme.spacingMD
                : 0,
          ),
          child: DailyTaskCard(
            task: task,
            onStart: () {
              if (task.isCompleted) return;
              switch (task.type) {
                case DailyTaskType.meditation:
                  context.go('/meditation');
                  break;
                case DailyTaskType.prayer:
                  context.go('/prayer');
                  break;
                case DailyTaskType.bibleReading:
                  context.go('/bible-reading');
                  break;
              }
            },
            onComplete: () {
              _handleTaskComplete(context, ref, task.type);
            },
          ),
        );
      }).toList(),
    );
  }

  void _handleTaskComplete(
      BuildContext context, WidgetRef ref, DailyTaskType type) {
    final reward =
        ref.read(dailyTasksProvider.notifier).completeTask(type);
    if (reward > 0) {
      final size = MediaQuery.of(context).size;
      PointToast.show(
        context,
        points: reward,
        sourceOffset: Offset(size.width / 2, size.height * 0.3),
      );
    }
  }

  Widget _buildLambyCard(
    BuildContext context, {
    required String greeting,
    required Color textColor,
  }) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.pets, color: AppColors.primaryDark, size: 22),
          ),
          const SizedBox(width: AppTheme.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('루양',
                    style: AppTypography.label(AppColors.primaryDark)
                        .copyWith(fontWeight: FontWeight.w700)),
                const SizedBox(height: 2),
                Text(greeting,
                    style: AppTypography.bodyMedium(textColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
