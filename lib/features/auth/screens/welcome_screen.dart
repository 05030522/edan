import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/services/social_auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/social_login_button.dart';
import '../providers/auth_provider.dart';

/// 웰컴 화면 - 3페이지 온보딩 소개 + 소셜 로그인
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  SocialProvider? _loadingProvider;

  /// 편집자 모드 진입용 탭 카운터
  int _devTapCount = 0;

  static const List<_WelcomePage> _pages = [
    _WelcomePage(
      icon: Icons.eco,
      title: '에덴에 오신 것을 환영해요',
      description: '하나님과 함께하는 매일의 여정,\n에덴에서 시작하세요.',
    ),
    _WelcomePage(
      icon: Icons.menu_book,
      title: '매일 5분, 말씀과 함께',
      description: '짧지만 깊은 묵상으로\n하루를 의미 있게 시작하세요.',
    ),
    _WelcomePage(
      icon: Icons.park,
      title: '나만의 에덴을 가꿔보세요',
      description: '말씀을 묵상할수록\n당신의 정원이 아름답게 자라나요.',
    ),
  ];

  Future<void> _handleSocialLogin(SocialProvider provider) async {
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

  /// 에덴 아이콘 5번 탭 → 편집자 모드 진입
  void _handleDevTap() {
    _devTapCount++;
    if (_devTapCount >= 5) {
      _devTapCount = 0;
      _showDevModeDialog();
    }
  }

  void _showDevModeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('편집자 모드'),
        content: const Text(
          '로그인 없이 앱을 둘러볼 수 있는 편집자 모드로 진입합니다.\n\n'
          '데이터는 저장되지 않으며, 일부 기능이 제한됩니다.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).enterDevMode();
              context.go('/home');
            },
            child: const Text('진입하기'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // 페이지뷰
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingXL,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 첫 페이지 아이콘: 5번 탭하면 편집자 모드
                        GestureDetector(
                          onTap: index == 0 ? _handleDevTap : null,
                          child: Icon(
                            page.icon,
                            size: 80,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: AppTheme.spacingXXL),
                        Text(
                          page.title,
                          style: AppTypography.headlineLarge(textColor),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppTheme.spacingLG),
                        Text(
                          page.description,
                          style: AppTypography.bodyMedium(subTextColor),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 페이지 인디케이터
            Padding(
              padding: const EdgeInsets.only(bottom: AppTheme.spacingLG),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),

            // 하단 버튼 영역
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingXL,
              ),
              child: Column(
                children: [
                  if (_currentPage < _pages.length - 1)
                    // 다음 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          '다음',
                          style: AppTypography.button(Colors.white),
                        ),
                      ),
                    )
                  else ...[
                    // 마지막 페이지: 소셜 로그인 버튼만
                    SocialLoginButton(
                      provider: SocialProvider.kakao,
                      onPressed: () => _handleSocialLogin(SocialProvider.kakao),
                      isLoading: _loadingProvider == SocialProvider.kakao,
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      provider: SocialProvider.google,
                      onPressed: () =>
                          _handleSocialLogin(SocialProvider.google),
                      isLoading: _loadingProvider == SocialProvider.google,
                    ),
                    const SizedBox(height: 10),
                    SocialLoginButton(
                      provider: SocialProvider.naver,
                      onPressed: () => _handleSocialLogin(SocialProvider.naver),
                      isLoading: _loadingProvider == SocialProvider.naver,
                    ),
                  ],
                  const SizedBox(height: AppTheme.spacingLG),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 웰컴 페이지 데이터 모델
class _WelcomePage {
  final IconData icon;
  final String title;
  final String description;

  const _WelcomePage({
    required this.icon,
    required this.title,
    required this.description,
  });
}
