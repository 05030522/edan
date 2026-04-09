import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/talent_icon.dart';
import '../../auth/providers/auth_provider.dart';
import '../../home/providers/daily_tasks_provider.dart';
import '../../streak/providers/streak_goal_provider.dart';

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
        rewardAmount: task.rewardFp,
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
                  alignment: Alignment.center,
                  child: allCompleted
                      ? const Icon(
                          Icons.check_circle,
                          color: AppColors.success,
                          size: 28,
                        )
                      : const TalentIcon(size: 30),
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
                      allCompleted
                          ? Text(
                              '오늘의 모든 경건을 완료했어요!',
                              style: AppTypography.bodySmall(subTextColor),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    '모든 경건을 완료하면 보너스 +${AppConstants.faithPointsPerfectDay} ',
                                    style:
                                        AppTypography.bodySmall(subTextColor),
                                  ),
                                ),
                                const TalentIcon(size: 12),
                                Text(
                                  '!',
                                  style:
                                      AppTypography.bodySmall(subTextColor),
                                ),
                              ],
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
  final int rewardAmount;
  final bool isCompleted;
  final IconData icon;
  final DailyTaskType taskType;

  const _QuestData({
    required this.title,
    required this.rewardAmount,
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
              child: quest.isCompleted
                  ? Text(
                      '완료',
                      style: AppTypography.label(AppColors.success),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '+${quest.rewardAmount} ',
                          style: AppTypography.label(AppColors.gold),
                        ),
                        const TalentIcon(size: 13),
                      ],
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
  @override
  Widget build(BuildContext context) {
    final profile = ref.watch(authProvider).profile;
    final currentStreak = profile?.currentStreak ?? 0;

    // 현재 목표: 사용자가 직접 설정한 값이 있으면 그 값, 없으면 자동 계산
    final goalNotifier = ref.watch(streakGoalProvider.notifier);
    final goalState = ref.watch(streakGoalProvider);
    final currentGoal = goalNotifier.resolveGoal(currentStreak);
    final isCustomGoal = goalState.customGoal != null;

    final progress = currentStreak / currentGoal;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '연속 묵상 목표',
              style: AppTypography.titleMedium(widget.textColor),
            ),
            const Spacer(),
            TextButton.icon(
              onPressed: () => _openGoalPicker(currentGoal),
              icon: const Icon(Icons.edit_outlined, size: 16),
              label: Text(
                '목표 변경',
                style: AppTypography.label(AppColors.primaryDark),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                foregroundColor: AppColors.primaryDark,
              ),
            ),
          ],
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
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                '$currentGoal일 연속 목표',
                                style: AppTypography.titleMedium(
                                    widget.textColor),
                              ),
                            ),
                            if (isCustomGoal) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.primary
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '직접 설정',
                                  style: TextStyle(
                                    color: AppColors.primaryDark,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ],
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
                  backgroundColor:
                      AppColors.streakFlame.withValues(alpha: 0.15),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.streakFlame),
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
            child: InkWell(
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              onTap: () => _selectGoal(entry.key),
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
                      ? Border.all(
                          color:
                              AppColors.streakFlame.withValues(alpha: 0.3))
                      : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      isAchieved
                          ? Icons.check_circle
                          : Icons.local_fire_department,
                      color: isAchieved
                          ? AppColors.success
                          : AppColors.streakFlame,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.streakFlame,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('현재 목표',
                            style: TextStyle(
                                color: Colors.white, fontSize: 10)),
                      ),
                    ],
                    const Spacer(),
                    if (isAchieved)
                      Text(
                        '달성!',
                        style: AppTypography.label(AppColors.success)
                            .copyWith(fontWeight: FontWeight.w700),
                      )
                    else
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '+${entry.value} ',
                            style: AppTypography.label(AppColors.gold)
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          const TalentIcon(size: 14),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        }),

        // 자동 목표로 되돌리기 (직접 설정된 경우에만)
        if (isCustomGoal) ...[
          const SizedBox(height: AppTheme.spacingSM),
          Center(
            child: TextButton.icon(
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                await ref.read(streakGoalProvider.notifier).clearGoal();
                if (!mounted) return;
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('목표를 자동 설정으로 되돌렸어요'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.refresh, size: 16),
              label: Text(
                '자동 목표로 되돌리기',
                style: AppTypography.label(widget.subTextColor),
              ),
              style: TextButton.styleFrom(
                foregroundColor: widget.subTextColor,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// 목표 선택 모달
  void _openGoalPicker(int currentGoal) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBackgroundSecondary : Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
          ),
          padding: const EdgeInsets.all(AppTheme.spacingXL),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '연속 묵상 목표 선택',
                style: AppTypography.titleLarge(widget.textColor),
              ),
              const SizedBox(height: 4),
              Text(
                '원하는 목표 일수를 선택해주세요',
                style: AppTypography.bodySmall(widget.subTextColor),
              ),
              const SizedBox(height: AppTheme.spacingLG),
              ...kStreakGoalOptions.map((days) {
                final isSelected = days == currentGoal;
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppTheme.spacingSM),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusMedium),
                    onTap: () {
                      Navigator.pop(ctx);
                      _selectGoal(days);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingLG,
                          vertical: AppTheme.spacingMD),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.streakFlame.withValues(alpha: 0.12)
                            : (isDark
                                ? Colors.white.withValues(alpha: 0.04)
                                : Colors.grey.shade100),
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusMedium),
                        border: isSelected
                            ? Border.all(
                                color: AppColors.streakFlame
                                    .withValues(alpha: 0.4))
                            : null,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_fire_department,
                              color: AppColors.streakFlame, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            '$days일 연속',
                            style: AppTypography.titleMedium(widget.textColor)
                                .copyWith(
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          if (isSelected)
                            const Icon(Icons.check_circle,
                                color: AppColors.streakFlame, size: 20),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: AppTheme.spacingSM),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectGoal(int days) async {
    await ref.read(streakGoalProvider.notifier).setGoal(days);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('연속 묵상 목표를 $days일로 설정했어요'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
