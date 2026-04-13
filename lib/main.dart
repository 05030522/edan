import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/services/supabase_service.dart';
import 'app.dart';

/// Sentry DSN - 프로젝트 생성 후 여기에 입력
/// https://sentry.io 에서 Flutter 프로젝트 생성 → DSN 복사
const String _sentryDsn = String.fromEnvironment(
  'SENTRY_DSN',
  defaultValue: '',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 웹에서 path URL 전략 사용 (OAuth 콜백 호환)
  // /#/path → /path 형식으로 변경
  usePathUrlStrategy();

  // 상태바 스타일 설정
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // 세로 모드 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // GoogleFonts: 네트워크 실패 시 시스템 폰트 사용 (글씨 깨짐 방지)
  GoogleFonts.config.allowRuntimeFetching = true;

  // Supabase 초기화
  await SupabaseService.initialize();

  // Sentry 크래시 리포팅 초기화
  if (_sentryDsn.isNotEmpty) {
    await SentryFlutter.init((options) {
      options.dsn = _sentryDsn;
      options.tracesSampleRate = 0.3; // 성능 모니터링 30% 샘플링
      options.environment = 'production';
    }, appRunner: () => runApp(const ProviderScope(child: EdenApp())));
  } else {
    // DSN 미설정 시 Sentry 없이 실행
    runApp(const ProviderScope(child: EdenApp()));
  }
}
