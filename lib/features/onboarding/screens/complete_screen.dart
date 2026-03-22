import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/services/supabase_service.dart';
import '../../../shared/models/user_profile.dart';
import '../../auth/providers/auth_provider.dart';
import '../providers/onboarding_provider.dart';

/// 온보딩 완료 화면
class OnboardingCompleteScreen extends ConsumerWidget {
  const OnboardingCompleteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final onboardingData = ref.watch(onboardingProvider);
    final userName = onboardingData.name.isNotEmpty ? onboardingData.name : '사용자';

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingXL,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppTheme.spacing3XL),

              // 진행 표시 (완료 5/5)
              _buildProgressIndicator(5, 5),

              const Spacer(),

              // 축하 아이콘
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.eco,
                  size: 56,
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: AppTheme.spacingXXL),

              // 축하 메시지
              Text(
                '에덴에 오신 것을 환영해요,\n$userName님!',
                style: AppTypography.headlineLarge(textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingLG),

              Text(
                '이제 매일 5분, 말씀과 함께\n나만의 에덴을 가꿔보세요',
                style: AppTypography.bodyMedium(subTextColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppTheme.spacingXL),

              // 축하 배지
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLG,
                  vertical: AppTheme.spacingSM,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.2),
                  borderRadius:
                      BorderRadius.circular(AppTheme.radiusRound),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.stars,
                      color: AppColors.gold,
                      size: 20,
                    ),
                    const SizedBox(width: AppTheme.spacingSM),
                    Text(
                      '+10 FP 획득!',
                      style: AppTypography.titleMedium(AppColors.gold),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // 시작 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // 온보딩 데이터 로컬 저장
                    await ref.read(onboardingProvider.notifier).saveToLocal();

                    // Auth 프로필 업데이트 (새 프로필 생성 또는 기존 프로필 업데이트)
                    final userId = SupabaseService.currentUserId;
                    if (userId != null) {
                      final currentProfile = ref.read(authProvider).profile;
                      final now = DateTime.now();

                      final updatedProfile = currentProfile != null
                          ? currentProfile.copyWith(
                              displayName: onboardingData.name,
                              churchName: onboardingData.churchName,
                              notificationTime:
                                  onboardingData.notificationTimeFormatted,
                            )
                          : UserProfile(
                              id: userId,
                              displayName: onboardingData.name,
                              churchName: onboardingData.churchName,
                              notificationTime:
                                  onboardingData.notificationTimeFormatted,
                              faithPoints: 10, // 온보딩 완료 보너스
                              createdAt: now,
                              updatedAt: now,
                            );

                      await ref
                          .read(authProvider.notifier)
                          .updateProfile(updatedProfile);
                    }

                    if (context.mounted) {
                      context.go('/home');
                    }
                  },
                  child: Text(
                    '에덴 시작하기',
                    style: AppTypography.button(Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingXXL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int current, int total) {
    return Row(
      children: List.generate(total, (index) {
        final isActive = index < current;
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: index < total - 1 ? 4 : 0),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}
