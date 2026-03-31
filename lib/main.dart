import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/services/supabase_service.dart';
import 'app.dart';

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

  runApp(
    const ProviderScope(
      child: EdenApp(),
    ),
  );
}
