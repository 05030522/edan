import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';

/// 스트릭 달성 축하 다이얼로그
class StreakCelebration {
  /// 스트릭 달성 시 축하 표시
  static void show(
    BuildContext context, {
    required int streakCount,
    int? bonusFp,
  }) {
    HapticFeedback.mediumImpact();

    final isMilestone =
        AppConstants.streakMilestoneRewards.containsKey(streakCount);
    final milestoneBonus =
        isMilestone ? AppConstants.streakMilestoneRewards[streakCount] : null;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '닫기',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      transitionBuilder: (context, anim, secondAnim, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
      pageBuilder: (context, anim, secondAnim) {
        return _StreakCelebrationDialog(
          streakCount: streakCount,
          bonusFp: bonusFp,
          milestoneBonus: milestoneBonus,
          isMilestone: isMilestone,
        );
      },
    );

    // 3초 후 자동 닫기
    final navigator = Navigator.of(context, rootNavigator: true);
    Future.delayed(const Duration(seconds: 3), () {
      if (navigator.canPop()) {
        navigator.pop();
      }
    });
  }
}

class _StreakCelebrationDialog extends StatelessWidget {
  final int streakCount;
  final int? bonusFp;
  final int? milestoneBonus;
  final bool isMilestone;

  const _StreakCelebrationDialog({
    required this.streakCount,
    this.bonusFp,
    this.milestoneBonus,
    required this.isMilestone,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(AppTheme.spacingXXL),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBackgroundSecondary : Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
            boxShadow: [
              BoxShadow(
                color: AppColors.streakFlame.withValues(alpha: 0.3),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 불꽃 아이콘
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: isMilestone
                        ? [AppColors.gold, AppColors.streakFlame]
                        : [
                            AppColors.streakFlameBright,
                            AppColors.streakFlame,
                          ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isMilestone ? Icons.emoji_events : Icons.local_fire_department,
                  color: Colors.white,
                  size: 44,
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // 타이틀
              Text(
                isMilestone ? '마일스톤 달성!' : '스트릭 달성!',
                style: AppTypography.titleLarge(
                  isDark
                      ? AppColors.darkTextPrimary
                      : AppColors.lightTextPrimary,
                ),
              ),
              const SizedBox(height: AppTheme.spacingSM),

              // 스트릭 카운트
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: AppColors.streakFlame,
                    size: 28,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '연속 $streakCount일',
                    style: AppTypography.headlineLarge(
                      AppColors.streakFlame,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMD),

              // 보너스 FP
              if (bonusFp != null && bonusFp! > 0) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                  ),
                  child: Text(
                    '완벽한 하루 보너스 +$bonusFp FP',
                    style: AppTypography.label(AppColors.goldDark)
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],

              if (milestoneBonus != null) ...[
                const SizedBox(height: AppTheme.spacingSM),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.streakFlame.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                  ),
                  child: Text(
                    '스트릭 보너스 +$milestoneBonus FP',
                    style: AppTypography.label(AppColors.streakFlame)
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],

              const SizedBox(height: AppTheme.spacingLG),

              // 격려 메시지
              Text(
                _getMessage(streakCount),
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium(
                  isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getMessage(int count) {
    if (count >= 30) return '놀라운 꾸준함이에요!\n하나님과의 동행이 깊어지고 있어요';
    if (count >= 14) return '2주 연속 달성!\n믿음이 한 뼘 더 자랐어요';
    if (count >= 7) return '일주일 연속!\n좋은 습관이 만들어지고 있어요';
    if (count >= 3) return '3일 연속 성공!\n꾸준함이 빛을 발하고 있어요';
    return '오늘도 하나님과 함께 했어요!\n내일도 함께해요';
  }
}
