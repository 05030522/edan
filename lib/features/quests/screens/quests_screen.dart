import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/glass_card.dart';

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

    // 플레이스홀더 퀘스트 데이터
    final quests = [
      _QuestData(
        title: '오늘의 묵상 완료하기',
        reward: '+${AppConstants.faithPointsPerLesson} FP',
        isCompleted: false,
        icon: Icons.menu_book,
      ),
      _QuestData(
        title: '셀라 묵상 기록 남기기',
        reward: '+${AppConstants.faithPointsPerSelah} FP',
        isCompleted: false,
        icon: Icons.edit_note,
      ),
      _QuestData(
        title: '한 줄 기도 적기',
        reward: '+${AppConstants.faithPointsPerSelah} FP',
        isCompleted: false,
        icon: Icons.favorite_outline,
      ),
    ];

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
                    color: AppColors.gold.withValues(alpha: 0.2),
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: const Icon(
                    Icons.stars,
                    color: AppColors.gold,
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
                        '모든 퀘스트를 완료하면 보너스 +${AppConstants.faithPointsPerfectDay} FP!',
                        style: AppTypography.bodySmall(subTextColor),
                      ),
                    ],
                  ),
                ),
                // 완료 상태
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMD,
                    vertical: AppTheme.spacingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusRound),
                  ),
                  child: Text(
                    '0/3',
                    style: AppTypography.label(AppColors.primaryDark),
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
                child: _QuestCard(quest: quest),
              )),
        ],
      ),
    );
  }
}

/// 퀘스트 데이터 모델
class _QuestData {
  final String title;
  final String reward;
  final bool isCompleted;
  final IconData icon;

  const _QuestData({
    required this.title,
    required this.reward,
    required this.isCompleted,
    required this.icon,
  });
}

/// 퀘스트 카드 위젯
class _QuestCard extends StatelessWidget {
  final _QuestData quest;

  const _QuestCard({required this.quest});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    return GlassCard(
      padding: const EdgeInsets.all(AppTheme.spacingLG),
      child: Row(
        children: [
          // 체크박스
          Container(
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
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
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
              color: AppColors.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppTheme.radiusRound),
            ),
            child: Text(
              quest.reward,
              style: AppTypography.label(AppColors.gold),
            ),
          ),
        ],
      ),
    );
  }
}
