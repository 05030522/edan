import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/widgets/glass_card.dart';

/// 홈 화면 (에덴 정원)
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    // 플레이스홀더 데이터
    const String userName = '에덴 사용자';
    const int streakCount = 0;
    final String greeting = AppConstants.lambyGreetings[
        Random().nextInt(AppConstants.lambyGreetings.length)];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingXL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단: 인사말 + 스트릭
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '안녕, $userName!',
                          style: AppTypography.headlineMedium(textColor),
                        ),
                        const SizedBox(height: AppTheme.spacingXS),
                        Text(
                          '오늘도 에덴을 가꿔볼까요?',
                          style: AppTypography.bodyMedium(subTextColor),
                        ),
                      ],
                    ),
                  ),
                  // 스트릭 표시
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMD,
                      vertical: AppTheme.spacingSM,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.streakFlame.withValues(alpha: 0.15),
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusRound),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.local_fire_department,
                          color: AppColors.streakFlame,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$streakCount',
                          style: AppTypography.streakNumber(
                            AppColors.streakFlame,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 정원 영역
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.gardenSprout,
                      AppColors.primaryDark,
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(AppTheme.radiusXLarge),
                ),
                child: Stack(
                  children: [
                    // 정원 레벨 텍스트
                    Positioned(
                      bottom: AppTheme.spacingLG,
                      left: AppTheme.spacingLG,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMD,
                          vertical: AppTheme.spacingSM,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusRound,
                          ),
                        ),
                        child: Text(
                          'Lv.1 ${AppConstants.levelNames[0]}',
                          style: AppTypography.label(Colors.white),
                        ),
                      ),
                    ),

                    // 플레이스홀더 정원 아이콘
                    Center(
                      child: Icon(
                        Icons.eco,
                        size: 64,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 오늘의 묵상 카드
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.menu_book,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: AppTheme.spacingSM),
                        Text(
                          '오늘의 묵상',
                          style: AppTypography.titleMedium(textColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingMD),

                    Text(
                      '신앙의 첫걸음 - Day 1',
                      style: AppTypography.titleLarge(textColor),
                    ),
                    const SizedBox(height: AppTheme.spacingXS),
                    Text(
                      '요한복음 3:16',
                      style: AppTypography.bodySmall(subTextColor),
                    ),
                    const SizedBox(height: AppTheme.spacingLG),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.go('/study/path-1/lesson-1/scripture');
                        },
                        child: Text(
                          '묵상 시작하기',
                          style: AppTypography.button(
                            AppColors.lightTextPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 램비 인사 메시지
              GlassCard(
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.pets,
                        color: AppColors.primaryDark,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingMD),
                    Expanded(
                      child: Text(
                        greeting,
                        style: AppTypography.bodyMedium(textColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
