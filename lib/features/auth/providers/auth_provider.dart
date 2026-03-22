import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/services/social_auth_service.dart';
import '../../../shared/models/user_profile.dart';
import '../../../core/constants/supabase_constants.dart';

/// 인증 상태
enum AuthStatus {
  initial,
  authenticated,
  unauthenticated,
  loading,
}

/// 인증 상태 모델
class AuthState {
  final AuthStatus status;
  final User? user;
  final UserProfile? profile;
  final String? error;
  final bool isDevMode;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.profile,
    this.error,
    this.isDevMode = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    UserProfile? profile,
    String? error,
    bool? isDevMode,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      profile: profile ?? this.profile,
      error: error,
      isDevMode: isDevMode ?? this.isDevMode,
    );
  }
}

/// 인증 프로바이더
class AuthNotifier extends StateNotifier<AuthState> {
  StreamSubscription<dynamic>? _authSubscription;

  AuthNotifier() : super(const AuthState()) {
    _init();
  }

  void _init() {
    final user = SupabaseService.currentUser;
    if (user != null) {
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
      );
      _loadProfile();
    } else {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }

    // 인증 상태 변경 구독
    _authSubscription?.cancel();
    _authSubscription = SupabaseService.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session != null) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: session.user,
          isDevMode: false,
        );
        _loadProfile();
      } else if (event == AuthChangeEvent.signedOut) {
        state = const AuthState(status: AuthStatus.unauthenticated);
      }
    });
  }

  /// 프로필 로드
  Future<void> _loadProfile() async {
    final userId = SupabaseService.currentUserId;
    if (userId == null) return;

    try {
      final data = await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (data != null) {
        state = state.copyWith(profile: UserProfile.fromJson(data));
      }
    } catch (e) {
      debugPrint('프로필 로드 실패: $e');
    }
  }

  /// 소셜 로그인 (카카오, 구글, 네이버)
  Future<void> signInWithSocial(SocialProvider provider) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    try {
      final success = await SocialAuthService.signInWithSocial(provider);
      if (!success) {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          error: '${SocialAuthService.getProviderDisplayName(provider)} 로그인에 실패했습니다.',
        );
      }
      // 성공 시 onAuthStateChange 리스너가 상태를 업데이트함
    } catch (e) {
      debugPrint('소셜 로그인 에러: $e');
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        error: '로그인 중 오류가 발생했습니다: ${e.toString()}',
      );
    }
  }

  /// 편집자(Dev) 모드 진입 - 인증 없이 앱 탐색 가능
  void enterDevMode() {
    state = state.copyWith(
      status: AuthStatus.authenticated,
      isDevMode: true,
      profile: UserProfile(
        id: 'dev-user',
        displayName: '편집자 모드',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// 로그아웃
  Future<void> signOut() async {
    if (state.isDevMode) {
      state = const AuthState(status: AuthStatus.unauthenticated);
      return;
    }
    await SupabaseService.auth.signOut();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  /// 프로필 업데이트
  Future<void> updateProfile(UserProfile profile) async {
    if (state.isDevMode) {
      state = state.copyWith(profile: profile);
      return;
    }
    try {
      await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .upsert(profile.toJson());
      state = state.copyWith(profile: profile);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// 프로필 새로고침
  Future<void> refreshProfile() async {
    if (state.isDevMode) return;
    await _loadProfile();
  }

  /// 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}

/// 프로바이더 정의
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
