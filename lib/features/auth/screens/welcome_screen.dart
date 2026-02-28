import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';

/// 웰컴 화면 - 3페이지 온보딩 소개
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
                        Icon(
                          page.icon,
                          size: 80,
                          color: AppColors.primary,
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
                  // 시작하기 버튼 (마지막 페이지에서만)
                  if (_currentPage == _pages.length - 1)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => context.go('/auth/signup'),
                        child: Text(
                          '시작하기',
                          style: AppTypography.button(
                            AppColors.lightTextPrimary,
                          ),
                        ),
                      ),
                    )
                  else
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
                          style: AppTypography.button(
                            AppColors.lightTextPrimary,
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: AppTheme.spacingMD),

                  // 로그인 텍스트 버튼
                  TextButton(
                    onPressed: () => context.go('/auth/signin'),
                    child: Text(
                      '이미 계정이 있으신가요? 로그인',
                      style: AppTypography.bodyMedium(subTextColor),
                    ),
                  ),
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
