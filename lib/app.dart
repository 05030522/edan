import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'features/auth/providers/auth_provider.dart';

/// 에덴 앱 루트 위젯
class EdenApp extends ConsumerWidget {
  const EdenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final authState = ref.watch(authProvider);

    // 다크 모드 설정 (프로필에서 가져오거나 시스템 설정)
    final isDarkMode = authState.profile?.darkMode ?? false;

    return MaterialApp.router(
      title: '에덴',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routerConfig: router,
      locale: const Locale('ko', 'KR'),
    );
  }
}
