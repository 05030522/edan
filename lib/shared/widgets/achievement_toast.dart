import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_typography.dart';
import '../../features/quests/models/quest.dart';
import '../utils/icon_helper.dart';
import 'celebration_particles.dart';
import 'talent_icon.dart';

/// 업적 달성 토스트 다이얼로그
class AchievementToast {
  static Future<void> show(
    BuildContext context, {
    required Achievement achievement,
  }) {
    HapticFeedback.mediumImpact();

    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
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
        return _AchievementDialog(achievement: achievement);
      },
    );
  }
}

class _AchievementDialog extends StatelessWidget {
  final Achievement achievement;

  const _AchievementDialog({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          const Positioned.fill(
            child: CelebrationParticles(style: ParticleStyle.stars),
          ),
          Material(
            color: Colors.transparent,
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(AppTheme.spacingXXL),
              decoration: BoxDecoration(
                color: isDark
                    ? AppColors.darkBackgroundSecondary
                    : Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gold.withValues(alpha: 0.3),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 업적 아이콘
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.gold, Color(0xFFD4A843)],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      iconFromName(achievement.iconName),
                      color: Colors.white,
                      size: 44,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingLG),

                  // 타이틀
                  Text(
                    '업적 달성!',
                    style: AppTypography.titleLarge(
                      isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingSM),

                  // 업적 이름
                  Text(
                    achievement.title,
                    style: AppTypography.headlineMedium(AppColors.gold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    achievement.description,
                    style: AppTypography.bodyMedium(
                      isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacingMD),

                  // 보상 달란트
                  if (achievement.rewardFp > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusRound,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '업적 보상 +${achievement.rewardFp} ',
                            style: AppTypography.label(
                              AppColors.goldDark,
                            ).copyWith(fontWeight: FontWeight.w700),
                          ),
                          const TalentIcon(size: 14),
                        ],
                      ),
                    ),
                  const SizedBox(height: AppTheme.spacingLG),

                  // 버튼 영역
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Share.share(
                                '에덴에서 "${achievement.title}" 업적을 달성했어요! 🏆\n'
                                '${achievement.description}\n\n'
                                '나도 에덴에서 매일 묵상하기 👇\n'
                                'https://05030522.github.io/edan/',
                                subject: '에덴 묵상 - ${achievement.title} 달성!',
                              );
                            },
                            icon: const Icon(Icons.share, size: 18),
                            label: Text(
                              '공유',
                              style: AppTypography.button(
                                AppColors.primaryDark,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primaryDark,
                              side: BorderSide(
                                color: AppColors.primaryDark.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusRound,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingSM),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: 46,
                          child: ElevatedButton.icon(
                            onPressed: () => Navigator.of(
                              context,
                              rootNavigator: true,
                            ).pop(),
                            icon: const Icon(
                              Icons.check_circle_outline,
                              size: 18,
                            ),
                            label: Text(
                              '확인했어요',
                              style: AppTypography.button(Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryDark,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusRound,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
