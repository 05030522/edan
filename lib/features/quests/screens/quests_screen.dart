import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/point_toast.dart';
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
          // 완벽한 하루 보너스
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
                        '완벽한 하루',
                        style: AppTypography.titleMedium(textColor),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        allCompleted
                            ? '오늘의 모든 퀘스트를 완료했어요!'
                            : '모든 퀘스트를 완료하면 보너스 +${AppConstants.faithPointsPerfectDay} FP!',
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
            '오늘의 퀘스트',
            style: AppTypography.titleMedium(textColor),
          ),
          const SizedBox(height: AppTheme.spacingMD),

          // 퀘스트 목록
          ...quests.map((quest) => Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacingMD),
                child: _QuestCard(
                  quest: quest,
                  onTap: quest.isCompleted
                      ? null
                      : () {
                          final reward = ref
                              .read(dailyTasksProvider.notifier)
                              .completeTask(quest.taskType);
                          if (reward > 0) {
                            final size = MediaQuery.of(context).size;
                            PointToast.show(
                              context,
                              points: reward,
                              sourceOffset:
                                  Offset(size.width / 2, size.height * 0.4),
                            );
                          }
                        },
                ),
              )),

          // 스트릭 마일스톤 안내
          const SizedBox(height: AppTheme.spacingXL),
          Text(
            '스트릭 보너스',
            style: AppTypography.titleMedium(textColor),
          ),
          const SizedBox(height: AppTheme.spacingMD),
          ...AppConstants.streakMilestoneRewards.entries
              .take(4)
              .map((entry) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: AppTheme.spacingSM),
                    child: _MilestoneRow(
                      days: entry.key,
                      reward: entry.value,
                      textColor: textColor,
                      subTextColor: subTextColor,
                    ),
                  )),
        ],
      ),
    );
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

/// 스트릭 마일스톤 행
class _MilestoneRow extends StatelessWidget {
  final int days;
  final int reward;
  final Color textColor;
  final Color subTextColor;

  const _MilestoneRow({
    required this.days,
    required this.reward,
    required this.textColor,
    required this.subTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingLG,
        vertical: AppTheme.spacingMD,
      ),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Row(
        children: [
          Icon(Icons.local_fire_department,
              color: AppColors.streakFlame, size: 18),
          const SizedBox(width: AppTheme.spacingSM),
          Text(
            '$days일 연속',
            style: AppTypography.bodyMedium(textColor),
          ),
          const Spacer(),
          Text(
            '+$reward FP',
            style: AppTypography.label(AppColors.gold)
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
