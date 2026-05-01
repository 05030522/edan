import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/services/social_auth_service.dart';
import '../../../shared/models/user_profile.dart';
import '../../../core/constants/supabase_constants.dart';
import '../../../shared/models/app_error.dart';
import '../../../shared/utils/level_calculator.dart';

/// 현재 OAuth 사용자 metadata에서 프사 URL 추출.
///
/// 카카오/구글/네이버가 각기 다른 키를 쓰므로 후보를 순회.
/// - 카카오: `avatar_url` 또는 `picture`
/// - 구글: `picture` 또는 `avatar_url`
/// - 네이버: `picture` 또는 `profile_image`
///
/// 신규 프로필 생성(complete_screen) 및 기존 프로필 백필(auth_provider) 양쪽에서 사용.
String? extractOAuthAvatarUrl() {
  final metadata = SupabaseService.currentUser?.userMetadata;
  if (metadata == null) return null;

  const candidateKeys = [
    'avatar_url',
    'picture',
    'profile_image',
    'profile_image_url',
  ];
  for (final key in candidateKeys) {
    final value = metadata[key];
    if (value is String && value.isNotEmpty) return value;
  }
  return null;
}

/// 인증 상태
enum AuthStatus { initial, authenticated, unauthenticated, loading }

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
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
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
  ///
  /// avatar_url이 비어 있으면 OAuth metadata에서 자동 백필.
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
        var profile = UserProfile.fromJson(data);

        // OAuth 프사 자동 동기화: 프로필에 avatar_url이 없는 경우만 채움
        if (profile.avatarUrl == null) {
          final oauthAvatar = extractOAuthAvatarUrl();
          if (oauthAvatar != null) {
            profile = profile.copyWith(avatarUrl: oauthAvatar);
            // 서버에도 비동기 저장 (실패해도 로컬은 반영됨)
            unawaited(_persistAvatarUrl(userId, oauthAvatar));
          }
        }

        state = state.copyWith(profile: profile);
      }
    } catch (e) {
      debugPrint('프로필 로드 실패: $e');
    }
  }

  /// avatar_url을 서버 profiles 테이블에 비동기 저장.
  Future<void> _persistAvatarUrl(String userId, String avatarUrl) async {
    try {
      await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .update({'avatar_url': avatarUrl})
          .eq('id', userId);
    } catch (e) {
      debugPrint('avatar_url 저장 실패: $e');
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
          error:
              '${SocialAuthService.getProviderDisplayName(provider)} 로그인에 실패했습니다.',
        );
      }
      // 성공 시 onAuthStateChange 리스너가 상태를 업데이트함
    } catch (e) {
      debugPrint('소셜 로그인 에러: $e');
      final err = AppError.from(e);
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        error: err.message,
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

  /// 프로필 업데이트 (전체)
  Future<void> updateProfile(UserProfile profile) async {
    if (state.isDevMode) {
      state = state.copyWith(profile: profile);
      return;
    }
    // 변경된 필드만 추출하여 업데이트
    final oldProfile = state.profile;
    final changes = <String, dynamic>{};

    if (oldProfile == null) return;

    if (profile.displayName != oldProfile.displayName) {
      changes['display_name'] = profile.displayName;
    }
    if (profile.churchName != oldProfile.churchName) {
      changes['church_name'] = profile.churchName;
    }
    if (profile.churchId != oldProfile.churchId) {
      changes['church_id'] = profile.churchId;
    }
    if (profile.avatarUrl != oldProfile.avatarUrl) {
      changes['avatar_url'] = profile.avatarUrl;
    }
    if (profile.darkMode != oldProfile.darkMode) {
      changes['dark_mode'] = profile.darkMode;
    }
    if (profile.faithPoints != oldProfile.faithPoints) {
      changes['faith_points'] = profile.faithPoints;
    }
    if (profile.currentLevel != oldProfile.currentLevel) {
      changes['current_level'] = profile.currentLevel;
    }
    if (profile.currentStreak != oldProfile.currentStreak) {
      changes['current_streak'] = profile.currentStreak;
    }
    if (profile.longestStreak != oldProfile.longestStreak) {
      changes['longest_streak'] = profile.longestStreak;
    }

    if (changes.isEmpty) {
      state = state.copyWith(profile: profile);
      return;
    }

    try {
      await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .update(changes)
          .eq('id', profile.id);
      state = state.copyWith(profile: profile);
      debugPrint('프로필 업데이트 성공: $changes');
    } catch (e) {
      debugPrint('프로필 업데이트 실패: $e');
      state = state.copyWith(error: e.toString());
    }
  }

  /// 특정 필드만 업데이트
  Future<void> updateProfileField(Map<String, dynamic> fields) async {
    if (state.isDevMode || state.profile == null) return;
    try {
      await SupabaseService.client
          .from(SupabaseConstants.tableProfiles)
          .update(fields)
          .eq('id', state.profile!.id);
      debugPrint('필드 업데이트 성공: $fields');
    } catch (e) {
      debugPrint('필드 업데이트 실패: $e');
    }
  }

  /// 달란트 추가 (로컬 즉시 반영 + 자동 레벨업 + 서버 비동기 저장)
  Future<void> addFaithPoints(int points) async {
    final profile = state.profile;
    if (profile == null || points <= 0) return;

    final newFp = profile.faithPoints + points;
    final newLevel = LevelCalculator.calculate(newFp);

    final updated = profile.copyWith(
      faithPoints: newFp,
      currentLevel: newLevel,
    );
    // 로컬 즉시 반영
    state = state.copyWith(profile: updated);

    // 서버 비동기 저장 (dev 모드면 스킵)
    if (!state.isDevMode) {
      try {
        final updateData = <String, dynamic>{'faith_points': newFp};
        if (newLevel != profile.currentLevel) {
          updateData['current_level'] = newLevel;
        }
        await SupabaseService.client
            .from(SupabaseConstants.tableProfiles)
            .update(updateData)
            .eq('id', profile.id);
      } catch (e) {
        debugPrint('달란트 저장 실패: $e');
      }
    }
  }

  /// 스트릭 업데이트 (오늘 모든 태스크 완료 시 호출)
  /// 반환값: 새 스트릭 수 (마일스톤 체크용), 이미 오늘 기록했으면 0
  Future<int> updateStreak() async {
    final profile = state.profile;
    if (profile == null) return 0;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // 오늘 이미 스트릭을 기록했으면 무시
    if (profile.lastStudyDate != null) {
      final lastDate = DateTime(
        profile.lastStudyDate!.year,
        profile.lastStudyDate!.month,
        profile.lastStudyDate!.day,
      );
      if (lastDate == today) return 0;
    }

    // 스트릭 계산
    int newStreak;
    if (profile.lastStudyDate != null) {
      final lastDate = DateTime(
        profile.lastStudyDate!.year,
        profile.lastStudyDate!.month,
        profile.lastStudyDate!.day,
      );
      final diff = today.difference(lastDate).inDays;
      if (diff == 1) {
        // 어제 연속 → 스트릭 +1
        newStreak = profile.currentStreak + 1;
      } else {
        // 하루 이상 빠짐 → 1부터 다시
        newStreak = 1;
      }
    } else {
      // 첫 공부
      newStreak = 1;
    }

    final newLongest = newStreak > profile.longestStreak
        ? newStreak
        : profile.longestStreak;

    final updated = profile.copyWith(
      currentStreak: newStreak,
      longestStreak: newLongest,
      lastStudyDate: now,
    );

    // 로컬 즉시 반영
    state = state.copyWith(profile: updated);

    // 서버 비동기 저장
    if (!state.isDevMode) {
      try {
        await SupabaseService.client
            .from(SupabaseConstants.tableProfiles)
            .update({
              'current_streak': newStreak,
              'longest_streak': newLongest,
              'last_study_date': now.toIso8601String(),
            })
            .eq('id', profile.id);
      } catch (e) {
        debugPrint('스트릭 저장 실패: $e');
      }
    }

    return newStreak;
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
