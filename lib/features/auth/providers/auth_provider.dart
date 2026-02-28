import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/supabase_service.dart';
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

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.profile,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    UserProfile? profile,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      profile: profile ?? this.profile,
      error: error,
    );
  }
}

/// 인증 프로바이더
class AuthNotifier extends StateNotifier<AuthState> {
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
    SupabaseService.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.signedIn && session != null) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          user: session.user,
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
      // 프로필이 아직 없을 수 있음 (온보딩 전)
    }
  }

  /// 이메일 회원가입
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    try {
      await SupabaseService.auth.signUp(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.message,
      );
    }
  }

  /// 이메일 로그인
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);
    try {
      await SupabaseService.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        error: e.message,
      );
    }
  }

  /// 로그아웃
  Future<void> signOut() async {
    await SupabaseService.auth.signOut();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  /// 프로필 업데이트
  Future<void> updateProfile(UserProfile profile) async {
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
    await _loadProfile();
  }

  /// 에러 초기화
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// 프로바이더 정의
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
