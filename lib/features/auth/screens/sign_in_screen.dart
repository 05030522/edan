import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/social_auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/social_login_button.dart';
import '../providers/auth_provider.dart';

/// 로그인 화면 - 소셜 로그인 전용
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  SocialProvider? _loadingProvider;

  Future<void> _handleSocialLogin(SocialProvider provider) async {
    // 미지원 프로바이더 안내
    if (!SocialAuthService.isProviderSupported(provider)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${SocialAuthService.getProviderDisplayName(provider)} 로그인은 준비 중입니다.',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      return;
    }

    setState(() => _loadingProvider = provider);
    await ref.read(authProvider.notifier).signInWithSocial(provider);
    if (mounted) {
      setState(() => _loadingProvider = null);
      final authState = ref.read(authProvider);
      if (authState.status == AuthStatus.authenticated) {
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => context.go('/welcome'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingXL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppTheme.spacingXXL),

              // 타이틀
              Text(
                '다시 만나서 반가워요!',
                style: AppTypography.headlineLarge(textColor),
              ),
              const SizedBox(height: AppTheme.spacingSM),
              Text(
                '간편하게 로그인하세요',
                style: AppTypography.bodyMedium(subTextColor),
              ),
              const SizedBox(height: AppTheme.spacing3XL),

              // 에러 메시지
              if (authState.error != null)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppTheme.spacingLG,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppTheme.spacingMD),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(AppTheme.radiusMedium),
                    ),
                    child: Text(
                      authState.error!,
                      style: AppTypography.bodySmall(AppColors.error),
                    ),
                  ),
                ),

              // 소셜 로그인 버튼
              SocialLoginButton(
                provider: SocialProvider.kakao,
                onPressed: () => _handleSocialLogin(SocialProvider.kakao),
                isLoading: _loadingProvider == SocialProvider.kakao,
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                provider: SocialProvider.google,
                onPressed: () => _handleSocialLogin(SocialProvider.google),
                isLoading: _loadingProvider == SocialProvider.google,
              ),
              const SizedBox(height: 12),
              SocialLoginButton(
                provider: SocialProvider.naver,
                onPressed: () => _handleSocialLogin(SocialProvider.naver),
                isLoading: _loadingProvider == SocialProvider.naver,
              ),

              const SizedBox(height: AppTheme.spacing3XL),

              // 안내 문구
              Center(
                child: Text(
                  '소셜 계정으로 간편하게\n로그인하고 시작하세요',
                  style: AppTypography.bodySmall(subTextColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
