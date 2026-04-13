import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/luyang_image.dart';

/// 묵상을 쉬어갔을 때 보여주는 격려 다이얼로그
///
/// - 루양이 따뜻한 위로 메시지를 전달
/// - 이전 동행 기록을 표시
/// - 새로운 묵상 목표를 다시 설정할 수 있는 버튼 제공
class StreakBrokenDialog extends ConsumerWidget {
  const StreakBrokenDialog({
    super.key,
    required this.previousStreak,
    required this.daysRested,
  });

  /// 깨지기 전 스트릭 수
  final int previousStreak;

  /// 쉰 일수
  final int daysRested;

  /// 다이얼로그를 띄우는 헬퍼
  static Future<void> show(
    BuildContext context, {
    required int previousStreak,
    required int daysRested,
  }) {
    HapticFeedback.lightImpact();
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '닫기',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 350),
      transitionBuilder: (context, anim, secondAnim, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
      pageBuilder: (context, anim, secondAnim) {
        return StreakBrokenDialog(
          previousStreak: previousStreak,
          daysRested: daysRested,
        );
      },
    );
  }

  String _comfortMessage() {
    // 위로 메시지는 기존 상수에서 불러오기
    final idx = DateTime.now().day % AppConstants.streakBreakComforts.length;
    return AppConstants.streakBreakComforts[idx];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.lightTextPrimary;
    final subTextColor = isDark
        ? AppColors.darkTextSecondary
        : AppColors.lightTextSecondary;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(AppTheme.spacingXXL),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkBackgroundSecondary : Colors.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusXLarge),
            boxShadow: [
              BoxShadow(
                color: AppColors.streakFlame.withValues(alpha: 0.25),
                blurRadius: 24,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 루양 캐릭터
              const LuyangImage(size: 72, shadow: false),
              const SizedBox(height: AppTheme.spacingMD),

              // 타이틀
              Text(
                '잠깐 쉬어갔나 봐요',
                style: AppTypography.titleLarge(textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingSM),

              // 쉰 일수 안내
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                ),
                child: Text(
                  '$previousStreak일 동행 기록 · $daysRested일 쉼',
                  style: AppTypography.label(
                    AppColors.primaryDark,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: AppTheme.spacingLG),

              // 위로 메시지
              Text(
                _comfortMessage(),
                textAlign: TextAlign.center,
                style: AppTypography.bodyMedium(subTextColor),
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 목표 재설정 버튼
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    // 목표 재설정 화면(=도전 화면)으로 이동
                    context.go('/quests');
                  },
                  icon: const Icon(Icons.flag_outlined, size: 18),
                  label: Text(
                    '새 묵상 목표 정하기',
                    style: AppTypography.button(Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusRound),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingSM),

              // 나중에 버튼
              SizedBox(
                width: double.infinity,
                height: 40,
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: Text(
                    '나중에 할게요',
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
}
