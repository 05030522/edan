import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_service.dart';

/// 소셜 로그인 프로바이더 타입
enum SocialProvider {
  kakao,
  google,
  naver,
}

/// 소셜 로그인 서비스
/// Supabase OAuth를 통한 카카오, 구글, 네이버 로그인 처리
class SocialAuthService {
  SocialAuthService._();

  /// 딥링크 콜백 URL (Android/iOS)
  static const String _redirectUrl = 'com.eden.app://login-callback';

  /// 웹 리다이렉트 URL을 동적으로 생성
  static String get _webRedirectUrl {
    if (kIsWeb) {
      // Uri.base는 현재 페이지의 전체 URL을 반환 (base href 포함)
      // 예: https://05030522.github.io/edan/ → /edan/ 경로 포함
      final base = Uri.base;
      final basePath = base.path.endsWith('/') ? base.path : '${base.path}/';
      return '${base.origin}${basePath}auth/callback';
    }
    return _redirectUrl;
  }

  /// Supabase OAuth 프로바이더 이름 변환
  static OAuthProvider? _toOAuthProvider(SocialProvider provider) {
    switch (provider) {
      case SocialProvider.kakao:
        return OAuthProvider.kakao;
      case SocialProvider.google:
        return OAuthProvider.google;
      case SocialProvider.naver:
        // 네이버는 Supabase 기본 OAuth에 포함되지 않음
        // Custom OIDC 설정 시 별도 구현 필요
        return null;
    }
  }

  /// 네이버 로그인 지원 여부
  static bool isProviderSupported(SocialProvider provider) {
    return provider != SocialProvider.naver;
  }

  /// 소셜 로그인 실행
  /// Supabase의 signInWithOAuth를 사용하여 외부 브라우저로 인증
  static Future<bool> signInWithSocial(SocialProvider provider) async {
    try {
      // 네이버는 아직 미지원
      if (!isProviderSupported(provider)) {
        debugPrint('네이버 로그인은 준비 중입니다.');
        return false;
      }

      final redirectUrl = kIsWeb ? _webRedirectUrl : _redirectUrl;

      final res = await SupabaseService.auth.signInWithOAuth(
        _toOAuthProvider(provider)!,
        redirectTo: redirectUrl,
      );

      return res;
    } catch (e) {
      debugPrint('소셜 로그인 에러 ($provider): $e');
      return false;
    }
  }

  /// 딥링크 콜백 처리 (앱으로 돌아왔을 때)
  static Future<AuthSessionUrlResponse?> handleCallback(Uri uri) async {
    try {
      final code = uri.queryParameters['code'];
      if (code == null) return null;

      final response = await SupabaseService.auth.exchangeCodeForSession(code);
      return response;
    } catch (e) {
      debugPrint('콜백 처리 에러: $e');
      return null;
    }
  }

  /// 프로바이더별 표시 이름
  static String getProviderDisplayName(SocialProvider provider) {
    switch (provider) {
      case SocialProvider.kakao:
        return '카카오';
      case SocialProvider.google:
        return 'Google';
      case SocialProvider.naver:
        return '네이버';
    }
  }

  /// 프로바이더별 브랜드 컬러
  static Map<String, dynamic> getProviderBrandInfo(SocialProvider provider) {
    switch (provider) {
      case SocialProvider.kakao:
        return {
          'color': const Color(0xFFFEE500),
          'textColor': const Color(0xFF191919),
          'icon': 'kakao',
          'label': '카카오 로그인',
        };
      case SocialProvider.google:
        return {
          'color': const Color(0xFFFFFFFF),
          'textColor': const Color(0xFF757575),
          'icon': 'google',
          'label': 'Google 로그인',
        };
      case SocialProvider.naver:
        return {
          'color': const Color(0xFF03C75A),
          'textColor': const Color(0xFFFFFFFF),
          'icon': 'naver',
          'label': '네이버 로그인',
        };
    }
  }
}
