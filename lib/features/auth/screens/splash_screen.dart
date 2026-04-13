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

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    // 최소 표시 시간(1.5초)과 인증 확인을 병렬 실행
    _initAndNavigate();
  }

  Future<void> _initAndNavigate() async {
    // 최소 스플래시 표시 시간과 인증 체크를 동시에 실행
    final results = await Future.wait([
      Future.delayed(const Duration(milliseconds: 600)),
      _checkAuth(),
    ]);

    if (!mounted) return;

    final route = results[1] as String;
    context.go(route);
  }

  /// 인증 상태 + 프로필 완성 여부 확인 → 이동할 라우트 반환
  Future<String> _checkAuth() async {
    final authState = ref.read(authProvider);

    if (authState.status != AuthStatus.authenticated) {
      return '/welcome';
    }

    try {
      final userId = SupabaseService.currentUserId;
      if (userId == null) return '/welcome';

      final data = await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (data != null &&
          (data['display_name'] as String?)?.isNotEmpty == true) {
        return '/home';
      } else {
        return '/onboarding/name';
      }
    } catch (e) {
      debugPrint('프로필 조회 에러: $e');
      return '/home';
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
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 리프 아이콘
              const Icon(Icons.eco, size: 48, color: AppColors.primary),
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
