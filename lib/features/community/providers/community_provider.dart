import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/supabase_service.dart';
import '../../../core/constants/supabase_constants.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/church_member.dart';

/// 랭킹 정렬 기준
enum RankingSortType {
  streak,
  faithPoints,
  level,
}

/// 커뮤니티 상태
class CommunityState {
  final List<ChurchMember> members;
  final String? churchName;
  final String? churchId;
  final bool isLoading;
  final String? error;
  final RankingSortType sortBy;

  /// 친구 관련 상태
  final List<ChurchMember> friends;
  final List<Friendship> friendships;
  final List<Friendship> pendingReceived; // 받은 요청
  final bool isFriendsLoading;

  const CommunityState({
    this.members = const [],
    this.churchName,
    this.churchId,
    this.isLoading = false,
    this.error,
    this.sortBy = RankingSortType.streak,
    this.friends = const [],
    this.friendships = const [],
    this.pendingReceived = const [],
    this.isFriendsLoading = false,
  });

  CommunityState copyWith({
    List<ChurchMember>? members,
    String? churchName,
    String? churchId,
    bool? isLoading,
    String? error,
    RankingSortType? sortBy,
    List<ChurchMember>? friends,
    List<Friendship>? friendships,
    List<Friendship>? pendingReceived,
    bool? isFriendsLoading,
  }) {
    return CommunityState(
      members: members ?? this.members,
      churchName: churchName ?? this.churchName,
      churchId: churchId ?? this.churchId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sortBy: sortBy ?? this.sortBy,
      friends: friends ?? this.friends,
      friendships: friendships ?? this.friendships,
      pendingReceived: pendingReceived ?? this.pendingReceived,
      isFriendsLoading: isFriendsLoading ?? this.isFriendsLoading,
    );
  }

  /// 현재 정렬 기준으로 정렬된 멤버 리스트
  List<ChurchMember> get sortedMembers {
    final sorted = List<ChurchMember>.from(members);
    switch (sortBy) {
      case RankingSortType.streak:
        sorted.sort((a, b) => b.currentStreak.compareTo(a.currentStreak));
      case RankingSortType.faithPoints:
        sorted.sort((a, b) => b.faithPoints.compareTo(a.faithPoints));
      case RankingSortType.level:
        sorted.sort((a, b) => b.currentLevel.compareTo(a.currentLevel));
    }
    return sorted;
  }

  /// 특정 유저와의 친구 상태 확인
  FriendshipStatus getFriendshipStatus(String userId, String currentUserId) {
    for (final f in friendships) {
      final isRequester = f.requesterId == currentUserId && f.receiverId == userId;
      final isReceiver = f.receiverId == currentUserId && f.requesterId == userId;

      if (isRequester || isReceiver) {
        if (f.status == 'accepted') return FriendshipStatus.accepted;
        if (f.status == 'pending') {
          return isRequester
              ? FriendshipStatus.pending
              : FriendshipStatus.received;
        }
      }
    }
    return FriendshipStatus.none;
  }
}

/// 커뮤니티 프로바이더
class CommunityNotifier extends StateNotifier<CommunityState> {
  final Ref _ref;

  CommunityNotifier(this._ref) : super(const CommunityState());

  String? get _currentUserId => _ref.read(authProvider).profile?.id;

  /// 같은 교회 멤버 로드 (churchId 또는 churchName 기반)
  Future<void> loadChurchMembers() async {
    final authState = _ref.read(authProvider);
    final profile = authState.profile;

    // churchId와 churchName 둘 다 없으면 빈 상태
    final hasChurchId = profile?.churchId != null && profile!.churchId!.isNotEmpty;
    final hasChurchName = profile?.churchName != null && profile!.churchName!.isNotEmpty;

    if (!hasChurchId && !hasChurchName) {
      state = state.copyWith(
        isLoading: false,
        members: [],
        churchName: null,
        churchId: null,
      );
      return;
    }

    state = state.copyWith(
      isLoading: true,
      error: null,
      churchName: profile.churchName,
      churchId: profile.churchId,
    );

    // Dev 모드: 목데이터 반환
    if (authState.isDevMode) {
      state = state.copyWith(
        isLoading: false,
        members: _mockMembers,
        friends: [_mockMembers[0], _mockMembers[4]],
        friendships: _mockFriendships,
      );
      return;
    }

    try {
      // churchId가 있으면 churchId로, 없으면 churchName으로 조회
      List<dynamic> data;
      if (hasChurchId) {
        data = await SupabaseService.client
            .from(SupabaseConstants.tableProfiles)
            .select('id, display_name, current_level, current_streak, faith_points')
            .eq('church_id', profile.churchId!)
            .order('current_streak', ascending: false);
      } else {
        data = await SupabaseService.client
            .from(SupabaseConstants.tableProfiles)
            .select('id, display_name, current_level, current_streak, faith_points')
            .eq('church_name', profile.churchName!)
            .order('current_streak', ascending: false);
      }

      final members = (data)
          .map((json) => ChurchMember.fromJson(json as Map<String, dynamic>))
          .toList();

      if (mounted) {
        state = state.copyWith(
          isLoading: false,
          members: members,
        );
      }
    } catch (e) {
      debugPrint('교회 멤버 로드 실패: $e');
      if (mounted) {
        state = state.copyWith(
          isLoading: false,
          error: '멤버 목록을 불러오지 못했어요',
        );
      }
    }
  }

  /// 친구 목록 + 친구 관계 로드
  Future<void> loadFriendships() async {
    final userId = _currentUserId;
    if (userId == null) return;

    final authState = _ref.read(authProvider);
    if (authState.isDevMode) return;

    state = state.copyWith(isFriendsLoading: true);

    try {
      // 내가 관련된 모든 친구 관계 조회
      final data = await SupabaseService.client
          .from('friendships')
          .select()
          .or('requester_id.eq.$userId,receiver_id.eq.$userId');

      final allFriendships = (data as List)
          .map((json) => Friendship.fromJson(json as Map<String, dynamic>))
          .toList();

      // 수락된 친구의 ID 목록
      final friendIds = <String>[];
      final pendingReceived = <Friendship>[];

      for (final f in allFriendships) {
        if (f.status == 'accepted') {
          friendIds.add(
            f.requesterId == userId ? f.receiverId : f.requesterId,
          );
        } else if (f.status == 'pending' && f.receiverId == userId) {
          pendingReceived.add(f);
        }
      }

      // 친구 프로필 조회
      List<ChurchMember> friends = [];
      if (friendIds.isNotEmpty) {
        final friendData = await SupabaseService.client
            .from(SupabaseConstants.tableProfiles)
            .select('id, display_name, current_level, current_streak, faith_points')
            .inFilter('id', friendIds);

        friends = (friendData as List)
            .map((json) => ChurchMember.fromJson(json as Map<String, dynamic>))
            .toList();
      }

      if (mounted) {
        state = state.copyWith(
          isFriendsLoading: false,
          friends: friends,
          friendships: allFriendships,
          pendingReceived: pendingReceived,
        );
      }
    } catch (e) {
      debugPrint('친구 목록 로드 실패: $e');
      if (mounted) {
        state = state.copyWith(isFriendsLoading: false);
      }
    }
  }

  /// 친구 요청 보내기
  Future<bool> sendFriendRequest(String receiverId) async {
    final userId = _currentUserId;
    if (userId == null) return false;

    try {
      await SupabaseService.client.from('friendships').insert({
        'requester_id': userId,
        'receiver_id': receiverId,
        'status': 'pending',
      });
      await loadFriendships();
      return true;
    } catch (e) {
      debugPrint('친구 요청 실패: $e');
      return false;
    }
  }

  /// 친구 요청 수락
  Future<bool> acceptFriendRequest(String friendshipId) async {
    try {
      await SupabaseService.client
          .from('friendships')
          .update({'status': 'accepted', 'updated_at': DateTime.now().toIso8601String()})
          .eq('id', friendshipId);
      await loadFriendships();
      return true;
    } catch (e) {
      debugPrint('친구 수락 실패: $e');
      return false;
    }
  }

  /// 친구 요청 거절 / 친구 삭제
  Future<bool> removeFriendship(String friendshipId) async {
    try {
      await SupabaseService.client
          .from('friendships')
          .delete()
          .eq('id', friendshipId);
      await loadFriendships();
      return true;
    } catch (e) {
      debugPrint('친구 삭제 실패: $e');
      return false;
    }
  }

  /// 랭킹 정렬 기준 변경
  void changeSortType(RankingSortType type) {
    state = state.copyWith(sortBy: type);
  }

  /// 전체 새로고침
  Future<void> refresh() async {
    await Future.wait([
      loadChurchMembers(),
      loadFriendships(),
    ]);
  }

  /// Dev 모드용 목데이터
  static const _mockMembers = [
    ChurchMember(id: 'mock-1', displayName: '김민수', currentLevel: 5, currentStreak: 14, faithPoints: 1200),
    ChurchMember(id: 'mock-2', displayName: '이서연', currentLevel: 3, currentStreak: 7, faithPoints: 620),
    ChurchMember(id: 'mock-3', displayName: '박지훈', currentLevel: 4, currentStreak: 5, faithPoints: 980),
    ChurchMember(id: 'mock-4', displayName: '정하은', currentLevel: 2, currentStreak: 3, faithPoints: 280),
    ChurchMember(id: 'mock-5', displayName: '최예진', currentLevel: 6, currentStreak: 21, faithPoints: 1850),
    ChurchMember(id: 'mock-6', displayName: '한도윤', currentLevel: 1, currentStreak: 1, faithPoints: 50),
  ];

  static final _mockFriendships = [
    Friendship(id: 'f-1', requesterId: 'dev-user', receiverId: 'mock-1', status: 'accepted', createdAt: DateTime.now()),
    Friendship(id: 'f-2', requesterId: 'dev-user', receiverId: 'mock-5', status: 'accepted', createdAt: DateTime.now()),
    Friendship(id: 'f-3', requesterId: 'mock-3', receiverId: 'dev-user', status: 'pending', createdAt: DateTime.now()),
  ];
}

/// 프로바이더 정의
final communityProvider =
    StateNotifierProvider<CommunityNotifier, CommunityState>((ref) {
  return CommunityNotifier(ref);
});
