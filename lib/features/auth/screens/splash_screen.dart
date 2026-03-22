import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/supabase_constants.dart';
import '../../../core/services/supabase_service.dart';
import '../providers/auth_provider.dart';

/// 스플래시 화면
/// 앱 시작 시 로고를 보여주고 인증 상태에 따라 라우팅
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // 2초 후 라우팅
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      _navigateBasedOnAuth();
    });
  }

  /// 인증 상태 + 프로필 완성 여부에 따라 분기
  Future<void> _navigateBasedOnAuth() async {
    if (!mounted) return;
    final authState = ref.read(authProvider);

    if (authState.status != AuthStatus.authenticated) {
      context.go('/welcome');
      return;
    }

    // 로그인 되어있으면 프로필 존재 여부 확인
    try {
      final userId = SupabaseService.currentUserId;
      if (userId == null) {
        context.go('/welcome');
        return;
      }

      final data = await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (!mounted) return;

      if (data != null &&
          (data['display_name'] as String?)?.isNotEmpty == true) {
        context.go('/home');
      } else {
        // 프로필 미완성 → 온보딩
        context.go('/onboarding/name');
      }
    } catch (e) {
      debugPrint('프로필 조회 에러: $e');
      if (mounted) context.go('/home');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
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
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 리프 아이콘
              const Icon(
                Icons.eco,
                size: 48,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),

              // 로고 텍스트
              Text(
                AppConstants.appName,
                style: AppTypography.displayLarge(textColor),
              ),
              const SizedBox(height: 8),

              // 슬로건
              Text(
                AppConstants.appSlogan,
                style: AppTypography.bodyMedium(subTextColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
