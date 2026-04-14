import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/utils/icon_helper.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/talent_icon.dart';
import '../../quests/models/quest.dart';
import '../data/achievement_definitions.dart';
import '../providers/achievement_provider.dart';

/// 업적 갤러리 화면
class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.darkBackground
        : AppColors.lightBackground;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final subTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    final achState = ref.watch(achievementProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('업적', style: AppTypography.titleLarge(textColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingLG),
        child: Column(
          children: [
            // 달성 요약
            GlassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events,
                    color: AppColors.gold,
                    size: 28,
                  ),
                  const SizedBox(width: AppTheme.spacingMD),
                  Text(
                    '${achState.unlockedCount} / ${achState.totalCount} 달성',
                    style: AppTypography.headlineMedium(textColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppTheme.spacingLG),

            // 업적 그리드
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: kAchievements.length,
              itemBuilder: (context, index) {
                final achievement = kAchievements[index];
                final unlocked = achState.isUnlocked(achievement.id);
                final unlockDate = achState.unlockDates[achievement.id];

                return _AchievementTile(
                  achievement: achievement,
                  unlocked: unlocked,
                  unlockDate: unlockDate,
                  textColor: textColor,
                  subTextColor: subTextColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  final Achievement achievement;
  final bool unlocked;
  final DateTime? unlockDate;
  final Color textColor;
  final Color subTextColor;

  const _AchievementTile({
    required this.achievement,
    required this.unlocked,
    this.unlockDate,
    required this.textColor,
    required this.subTextColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isHidden = achievement.isHidden && !unlocked;

    return GlassCard(
      child: Opacity(
        opacity: unlocked ? 1.0 : 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 아이콘
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: unlocked
                    ? AppColors.gold.withValues(alpha: 0.15)
                    : (isDark ? Colors.white10 : Colors.grey.shade100),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isHidden
                    ? Icons.help_outline
                    : iconFromName(achievement.iconName),
                color: unlocked ? AppColors.gold : subTextColor,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),

            // 이름
            Text(
              isHidden ? '???' : achievement.title,
              style: AppTypography.titleMedium(
                unlocked ? textColor : subTextColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),

            // 설명
            Text(
              isHidden ? '숨겨진 업적' : achievement.description,
              style: AppTypography.bodySmall(subTextColor),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const Spacer(),

            // 보상 또는 달성일
            if (unlocked && unlockDate != null)
              Text(
                '${unlockDate!.month}/${unlockDate!.day} 달성',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              )
            else if (!isHidden)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TalentIcon(size: 12),
                  const SizedBox(width: 2),
                  Text(
                    '+${achievement.rewardFp}',
                    style: AppTypography.label(subTextColor),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
