import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/supabase_service.dart';
import '../constants/supabase_constants.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/sign_in_screen.dart';
import '../../features/onboarding/screens/name_screen.dart';
import '../../features/onboarding/screens/profile_photo_screen.dart';
import '../../features/onboarding/screens/church_screen.dart';
import '../../features/onboarding/screens/notification_screen.dart';
import '../../features/onboarding/screens/complete_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/study/screens/learning_paths_screen.dart';
import '../../features/study/screens/lesson_scripture_screen.dart';
import '../../features/study/screens/quiz_screen.dart';
import '../../features/study/screens/quiz_result_screen.dart';
import '../../features/study/screens/share_card_screen.dart';
import '../../features/quests/screens/quests_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/settings/screens/privacy_policy_screen.dart';
import '../../features/settings/screens/terms_screen.dart';
import '../theme/app_colors.dart';

/// 라우트 이름 상수
class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String signIn = '/auth/signin';
  static const String authCallback = '/auth/callback';
  // signUp 제거됨 - 소셜 로그인으로 통합
  static const String onboardingName = '/onboarding/name';
  static const String onboardingPhoto = '/onboarding/photo';
  static const String onboardingChurch = '/onboarding/church';
  static const String onboardingNotification = '/onboarding/notification';
  static const String onboardingComplete = '/onboarding/complete';
  static const String home = '/home';
  static const String study = '/study';
  static const String quests = '/quests';
  static const String profile = '/profile';
  static const String settings = '/profile/settings';
  static const String lessonScripture = '/study/:pathId/:lessonId/scripture';
  static const String quiz = '/study/:pathId/:lessonId/quiz';
  static const String quizResult = '/study/:pathId/:lessonId/quiz-result';
  static const String shareCard = '/study/:pathId/:lessonId/share';
}

/// 하단 내비게이션 쉘 (4탭)
final _rootNavigatorKey = GlobalKey<NavigatorState>();
/// GoRouter 프로바이더
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      // ─── 인증 플로우 (내비게이션 바 없음) ───
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      // ─── OAuth 콜백 처리 (소셜 로그인 리다이렉트) ───
      GoRoute(
        path: AppRoutes.authCallback,
        builder: (context, state) => const _AuthCallbackScreen(),
      ),
      // ─── 온보딩 플로우 (내비게이션 바 없음) ───
      GoRoute(
        path: AppRoutes.onboardingName,
        builder: (context, state) => const OnboardingNameScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingPhoto,
        builder: (context, state) => const OnboardingPhotoScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingChurch,
        builder: (context, state) => const OnboardingChurchScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingNotification,
        builder: (context, state) => const OnboardingNotificationScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingComplete,
        builder: (context, state) => const OnboardingCompleteScreen(),
      ),

      // ─── 메인 앱 (하단 내비게이션 바 있음) ───
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return _MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // 탭 1: 에덴 (홈/정원)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          // 탭 2: 묵상 (학습)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.study,
                builder: (context, state) => const LearningPathsScreen(),
              ),
            ],
          ),
          // 탭 3: 도전 (퀘스트)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.quests,
                builder: (context, state) => const QuestsScreen(),
              ),
            ],
          ),
          // 탭 4: 나 (프로필)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                builder: (context, state) => const ProfileScreen(),
                routes: [
                  GoRoute(
                    path: 'settings',
                    builder: (context, state) => const SettingsScreen(),
                    routes: [
                      GoRoute(
                        path: 'privacy',
                        builder: (context, state) =>
                            const PrivacyPolicyScreen(),
                      ),
                      GoRoute(
                        path: 'terms',
                        builder: (context, state) => const TermsScreen(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // ─── 레슨 플로우 (풀스크린, 내비게이션 바 없음) ───
      GoRoute(
        path: '/study/:pathId/:lessonId/scripture',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final pathId = state.pathParameters['pathId'] ?? 'path-1';
          final lessonId = state.pathParameters['lessonId'] ?? 'lesson-1';
          return LessonScriptureScreen(
            pathId: pathId,
            lessonId: lessonId,
          );
        },
      ),

      // ─── 퀴즈 플로우 (풀스크린, 내비게이션 바 없음) ───
      GoRoute(
        path: '/study/:pathId/:lessonId/quiz',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final pathId = state.pathParameters['pathId'] ?? 'path-1';
          final lessonId = state.pathParameters['lessonId'] ?? 'lesson-1';
          return QuizScreen(
            pathId: pathId,
            lessonId: lessonId,
          );
        },
      ),
      GoRoute(
        path: '/study/:pathId/:lessonId/quiz-result',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final pathId = state.pathParameters['pathId'] ?? 'path-1';
          final lessonId = state.pathParameters['lessonId'] ?? 'lesson-1';
          return QuizResultScreen(
            pathId: pathId,
            lessonId: lessonId,
          );
        },
      ),

      // ─── 묵상 완료 공유카드 (풀스크린) ───
      GoRoute(
        path: '/study/:pathId/:lessonId/share',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final pathId = state.pathParameters['pathId'] ?? 'path-1';
          final lessonId = state.pathParameters['lessonId'] ?? 'lesson-1';
          return ShareCardScreen(
            pathId: pathId,
            lessonId: lessonId,
          );
        },
      ),
    ],
  );
});

/// 메인 스캐폴드 (하단 내비게이션 바)
class _MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _MainScaffold({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark
                  ? AppColors.darkBackgroundSecondary
                  : AppColors.lightBackgroundSecondary,
              width: 0.5,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          backgroundColor: isDark
              ? AppColors.darkBackgroundSecondary
              : Colors.white,
          indicatorColor: AppColors.primary.withValues(alpha: 0.2),
          height: 65,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.eco_outlined),
              selectedIcon: Icon(Icons.eco, color: AppColors.primaryDark),
              label: '에덴',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book, color: AppColors.primaryDark),
              label: '묵상',
            ),
            NavigationDestination(
              icon: Icon(Icons.star_outline),
              selectedIcon: Icon(Icons.star, color: AppColors.primaryDark),
              label: '도전',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.primaryDark),
              label: '내 정보',
            ),
          ],
        ),
      ),
    );
  }
}

/// OAuth 콜백 처리 화면
/// 소셜 로그인 후 리다이렉트되는 페이지
class _AuthCallbackScreen extends StatefulWidget {
  const _AuthCallbackScreen();

  @override
  State<_AuthCallbackScreen> createState() => _AuthCallbackScreenState();
}

class _AuthCallbackScreenState extends State<_AuthCallbackScreen> {
  @override
  void initState() {
    super.initState();
    _handleCallback();
  }

  Future<void> _handleCallback() async {
    try {
      // Supabase SDK가 implicit flow에서 URL fragment의 토큰을
      // 자동으로 처리할 때까지 대기
      await Future.delayed(const Duration(seconds: 2));

      // 이미 인증되었는지 확인
      if (mounted) {
        if (SupabaseService.isAuthenticated) {
          await _navigateAfterLogin();
        } else {
          // 아직 미인증이면 PKCE 코드 교환 시도 (모바일 폴백)
          final uri = Uri.base;
          final code = uri.queryParameters['code'];
          if (code != null) {
            debugPrint('PKCE 코드 교환 시도: $code');
            await SupabaseService.auth.exchangeCodeForSession(code);
            await Future.delayed(const Duration(milliseconds: 500));
          }

          if (mounted) {
            if (SupabaseService.isAuthenticated) {
              await _navigateAfterLogin();
            } else {
              debugPrint('로그인 실패 - welcome으로 이동');
              context.go(AppRoutes.welcome);
            }
          }
        }
      }
    } catch (e) {
      debugPrint('OAuth 콜백 처리 에러: $e');
      if (mounted) {
        context.go(AppRoutes.welcome);
      }
    }
  }

  /// 로그인 성공 후 프로필 존재 여부에 따라 분기
  Future<void> _navigateAfterLogin() async {
    if (!mounted) return;
    try {
      final userId = SupabaseService.currentUserId;
      if (userId == null) {
        context.go(AppRoutes.welcome);
        return;
      }

      // Supabase에서 프로필 조회
      final data = await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (!mounted) return;

      if (data != null && (data['display_name'] as String?)?.isNotEmpty == true) {
        // 프로필이 이미 있으면 → 홈
        debugPrint('기존 사용자 → 홈으로 이동');
        context.go(AppRoutes.home);
      } else {
        // 프로필 없으면 → 온보딩(이름 입력)
        debugPrint('신규 사용자 → 온보딩으로 이동');
        context.go(AppRoutes.onboardingName);
      }
    } catch (e) {
      debugPrint('프로필 조회 에러: $e → 온보딩으로 이동');
      if (mounted) {
        context.go(AppRoutes.onboardingName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 24),
            Text(
              '로그인 처리 중...',
              style: TextStyle(
                color: AppColors.lightTextSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
