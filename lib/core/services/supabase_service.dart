import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/supabase_constants.dart';

/// Supabase 클라이언트 초기화 및 접근
class SupabaseService {
  SupabaseService._();

  static SupabaseClient get client => Supabase.instance.client;

  static GoTrueClient get auth => client.auth;

  static User? get currentUser => auth.currentUser;

  static String? get currentUserId => currentUser?.id;

  static bool get isAuthenticated => currentUser != null;

  /// Supabase 초기화 (main.dart에서 호출)
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConstants.supabaseUrl,
      anonKey: SupabaseConstants.supabaseAnonKey,
      authOptions: FlutterAuthClientOptions(
        // 웹: implicit flow (토큰이 URL fragment로 전달, verifier 불필요)
        // 모바일: PKCE flow (딥링크 기반, 더 안전)
        authFlowType: kIsWeb
            ? AuthFlowType.implicit
            : AuthFlowType.pkce,
      ),
    );
  }
}
