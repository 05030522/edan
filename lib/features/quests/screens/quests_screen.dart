import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/point_toast.dart';
import '../../../shared/utils/streak_helper.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/daily_tasks_provider.dart';

/// 일일 퀘스트 화면
class QuestsScreen extends ConsumerWidget {
  const QuestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    // dailyTasksProvider에서 실제 완료 상태 읽기
    final tasksState = ref.watch(dailyTasksProvider);
    final completedCount = tasksState.completedCount;
    final allCompleted = tasksState.allCompleted;

    // 태스크 → 퀘스트 매핑
    final quests = tasksState.tasks.map((task) {
      return _QuestData(
        title: _questTitleForType(task.type),
        reward: '+${task.rewardFp} FP',
        isCompleted: task.isCompleted,
        icon: _questIconForType(task.type),
        taskType: task.type,
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '도전',
          style: AppTypography.titleLarge(textColor),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        children: [
          // 오늘의 경건 완료 보너스
          GlassCard(
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: allCompleted
                        ? AppColors.success.withValues(alpha: 0.2)
                        : AppColors.gold.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: Icon(
                    allCompleted ? Icons.check_circle : Icons.stars,
                    color: allCompleted ? AppColors.success : AppColors.gold,
                    size: 28,
                  ),
                ),
                const SizedBox(width: AppTheme.spacingMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '오늘의 경건 완료',
                        style: AppTypography.titleMedium(textColor),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        allCompleted
                            ? '오늘의 모든 경건을 완료했어요!'
                            : '모든 경건을 완료하면 보너스 +${AppConstants.faithPointsPerfectDay} FP!',
                        style: AppTypography.bodySmall(subTextColor),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMD,
                    vertical: AppTheme.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: allCompleted
                        ? AppColors.success.withValues(alpha: 0.15)
                        : AppColors.primary.withValues(alpha: 0.15),
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusRound),
                  ),
                  child: Text(
                    '$completedCount/${quests.length}',
                    style: AppTypography.label(
                      allCompleted ? AppColors.success : AppColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingXL),

          // 오늘의 퀘스트 섹션 타이틀
          Text(
            '오늘의 묵상',
            style: AppTypography.titleMedium(textColor),
          ),
          const SizedBox(height: AppTheme.spacingMD),

          // 퀘스트 목록 - 탭 시 해당 활동 페이지로 이동
          ...quests.map((quest) => Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacingMD),
                child: _QuestCard(
                  quest: quest,
                  onTap: quest.isCompleted
                      ? null
                      : () => _navigateToActivity(context, quest.taskType),
                ),
              )),

          // 스트릭 목표 시스템
          const SizedBox(height: AppTheme.spacingXL),
          _StreakGoalSection(textColor: textColor, subTextColor: subTextColor),
        ],
      ),
    );
  }

  /// 퀘스트 타입에 따라 실제 활동 페이지로 이동
  void _navigateToActivity(BuildContext context, DailyTaskType type) {
    switch (type) {
      case DailyTaskType.meditation:
        context.push('/study'); // 묵상 페이지
        break;
      case DailyTaskType.prayer:
        context.push('/study'); // 기도 페이지 (묵상 내 기도 섹션)
        break;
      case DailyTaskType.bibleReading:
        context.push('/study'); // 말씀 읽기 페이지
        break;
    }
  }

  String _questTitleForType(DailyTaskType type) {
    switch (type) {
      case DailyTaskType.meditation:
        return '오늘의 묵상 완료하기';
      case DailyTaskType.prayer:
        return '한 줄 기도 적기';
      case DailyTaskType.bibleReading:
        return '말씀 읽기 완료하기';
    }
  }

  IconData _questIconForType(DailyTaskType type) {
    switch (type) {
      case DailyTaskType.meditation:
        return Icons.menu_book;
      case DailyTaskType.prayer:
        return Icons.favorite_outline;
      case DailyTaskType.bibleReading:
        return Icons.auto_stories;
    }
  }
}

/// 퀘스트 데이터 모델
class _QuestData {
  final String title;
  final String reward;
  final bool isCompleted;
  final IconData icon;
  final DailyTaskType taskType;

  const _QuestData({
    required this.title,
    required this.reward,
    required this.isCompleted,
    required this.icon,
    required this.taskType,
  });
}

/// 퀘스트 카드 위젯
class _QuestCard extends StatelessWidget {
  final _QuestData quest;
  final VoidCallback? onTap;

  const _QuestCard({required this.quest, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Row(
          children: [
            // 체크박스
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: quest.isCompleted
                      ? AppColors.success
                      : AppColors.primary.withValues(alpha: 0.4),
                  width: 2,
                ),
                color: quest.isCompleted
                    ? AppColors.success
                    : Colors.transparent,
              ),
              child: quest.isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: AppTheme.spacingMD),

            // 아이콘
            Icon(
              quest.icon,
              color: quest.isCompleted ? AppColors.success : subTextColor,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacingMD),

            // 퀘스트 내용
            Expanded(
              child: Text(
                quest.title,
                style: AppTypography.bodyMedium(
                  quest.isCompleted ? subTextColor : textColor,
                ).copyWith(
                  decoration:
                      quest.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),

            // 보상
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingSM,
                vertical: AppTheme.spacingXS,
              ),
              decoration: BoxDecoration(
                color: quest.isCompleted
                    ? AppColors.success.withValues(alpha: 0.15)
                    : AppColors.gold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppTheme.radiusRound),
              ),
              child: Text(
                quest.isCompleted ? '완료' : quest.reward,
                style: AppTypography.label(
                  quest.isCompleted ? AppColors.success : AppColors.gold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 스트릭 목표 선택 섹션
class _StreakGoalSection extends ConsumerStatefulWidget {
  final Color textColor;
  final Color subTextColor;

  const _StreakGoalSection({
    required this.textColor,
    required this.subTextColor,
  });

  @override
  ConsumerState<_StreakGoalSection> createState() => _StreakGoalSectionState();
}

class _StreakGoalSectionState extends ConsumerState<_StreakGoalSection> {
  static const _goalOptions = [7, 14, 30, 100, 365];

  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(authProvider).profile;
    final currentStreak = profile?.currentStreak ?? 0;

    // 현재 목표: 현재 스트릭보다 큰 가장 가까운 목표
    final currentGoal = _goalOptions.firstWhere(
      (g) => g > currentStreak,
      orElse: () => 365,
    );

    final progress = currentStreak / currentGoal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '연속 묵상 목표',
          style: AppTypography.titleMedium(widget.textColor),
        ),
        const SizedBox(height: AppTheme.spacingMD),

        // 현재 진행 상황
        GlassCard(
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.local_fire_department,
                      color: AppColors.streakFlame, size: 32),
                  const SizedBox(width: AppTheme.spacingMD),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$currentGoal일 연속 목표',
                          style: AppTypography.titleMedium(widget.textColor),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '현재 $currentStreak일째 진행 중',
                          style: AppTypography.bodySmall(widget.subTextColor),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '$currentStreak/$currentGoal',
                    style: AppTypography.label(AppColors.streakFlame)
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMD),
              // 프로그레스 바
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  backgroundColor: AppColors.streakFlame.withValues(alpha: 0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.streakFlame),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spacingMD),

        // 마일스톤 목록
        ...AppConstants.streakMilestoneRewards.entries.map((entry) {
          final isAchieved = currentStreak >= entry.key;
          final isCurrent = entry.key == currentGoal;

          return Padding(
            padding: const EdgeInsets.only(bottom: AppTheme.spacingSM),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLG,
                vertical: AppTheme.spacingMD,
              ),
              decoration: BoxDecoration(
                color: isCurrent
                    ? AppColors.streakFlame.withValues(alpha: 0.1)
                    : isAchieved
                        ? AppColors.success.withValues(alpha: 0.08)
                        : AppColors.gold.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                border: isCurrent
                    ? Border.all(color: AppColors.streakFlame.withValues(alpha: 0.3))
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    isAchieved ? Icons.check_circle : Icons.local_fire_department,
                    color: isAchieved ? AppColors.success : AppColors.streakFlame,
                    size: 18,
                  ),
                  const SizedBox(width: AppTheme.spacingSM),
                  Text(
                    '${entry.key}일 연속',
                    style: AppTypography.bodyMedium(
                      isAchieved ? AppColors.success : widget.textColor,
                    ).copyWith(
                      fontWeight: isCurrent ? FontWeight.w700 : null,
                    ),
                  ),
                  if (isCurrent) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.streakFlame,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('현재 목표',
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                    ),
                  ],
                  const Spacer(),
                  Text(
                    isAchieved ? '달성!' : '+${entry.value} FP',
                    style: AppTypography.label(
                      isAchieved ? AppColors.success : AppColors.gold,
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
