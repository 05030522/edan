import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/app_typography.dart';
import '../../core/constants/app_constants.dart';
import 'talent_icon.dart';

/// 스트릭 달성 축하 다이얼로그
class StreakCelebration {
  /// 스트릭 달성 시 축하 표시.
  ///
  /// 사용자가 '확인했어요' 버튼을 눌러 다이얼로그를 닫을 때까지 Future가 resolve되지 않습니다.
  /// 자동 닫기 없음 — 사용자가 명시적으로 닫아야 함.
  static Future<void> show(
    BuildContext context, {
    required int streakCount,
    int? bonusFp,
  }) {
    HapticFeedback.mediumImpact();

    final isMilestone = AppConstants.streakMilestoneRewards.containsKey(
      streakCount,
    );
    final milestoneBonus = isMilestone
        ? AppConstants.streakMilestoneRewards[streakCount]
        : null;

    // 사용자가 직접 닫기 버튼을 눌러야 닫히도록 자동 닫기 제거
    // 배경 탭으로도 실수로 닫히지 않도록 barrierDismissible: false
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
        return _StreakCelebrationDialog(
          streakCount: streakCount,
          bonusFp: bonusFp,
          milestoneBonus: milestoneBonus,
          isMilestone: isMilestone,
        );
      },
    );
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
                        : [AppColors.streakFlameBright, AppColors.streakFlame],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isMilestone
                      ? Icons.emoji_events
                      : Icons.local_fire_department,
                  color: Colors.white,
                  size: 44,
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // 타이틀
              Text(
                isMilestone ? '마일스톤 달성!' : '연속 묵상 달성!',
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
                    style: AppTypography.headlineLarge(AppColors.streakFlame),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingMD),

              // 보너스 달란트
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '오늘의 경건 완료 보너스 +$bonusFp ',
                        style: AppTypography.label(
                          AppColors.goldDark,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                      const TalentIcon(size: 14),
                    ],
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '연속 묵상 보너스 +$milestoneBonus ',
                        style: AppTypography.label(
                          AppColors.streakFlame,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                      const TalentIcon(size: 14),
                    ],
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
              const SizedBox(height: AppTheme.spacingLG),

              // 버튼 영역: 공유하기 + 확인
              Row(
                children: [
                  // 공유하기 버튼 (보조)
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          final text =
                              '에덴에서 연속 $streakCount일 묵상 달성! 🔥\n'
                              '${_getMessage(streakCount).replaceAll('\n', ' ')}\n\n'
                              '나도 에덴에서 매일 묵상하기 👇\n'
                              'https://05030522.github.io/edan/';
                          Share.share(
                            text,
                            subject: '에덴 묵상 - 연속 $streakCount일 달성!',
                          );
                        },
                        icon: const Icon(Icons.share, size: 18),
                        label: Text(
                          '공유',
                          style: AppTypography.button(AppColors.primaryDark),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryDark,
                          side: BorderSide(
                            color: AppColors.primaryDark.withValues(alpha: 0.4),
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
                  // 확인 버튼 (주요)
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 46,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.of(context, rootNavigator: true).pop(),
                        icon: const Icon(Icons.check_circle_outline, size: 18),
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
