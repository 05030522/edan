import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/church_member.dart';
import '../providers/community_provider.dart';
import '../widgets/member_card.dart';
import '../widgets/no_church_empty_state.dart';

/// 커뮤니티 화면 - 내 친구 + 같은 교회 멤버 + 랭킹
class CommunityScreen extends ConsumerStatefulWidget {
  const CommunityScreen({super.key});

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 이미 데이터가 있으면 불필요한 재로드 방지
      final state = ref.read(communityProvider);
      if (state.members.isEmpty && !state.isLoading) {
        ref.read(communityProvider.notifier).refresh();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final community = ref.watch(communityProvider);
    final currentUserId = ref.watch(authProvider).profile?.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '커뮤니티',
          style: AppTypography.titleLarge(textColor),
        ),
      ),
      body: _buildBody(
        community: community,
        currentUserId: currentUserId,
        textColor: textColor,
        subTextColor: subTextColor,
      ),
    );
  }

  Widget _buildBody({
    required CommunityState community,
    required String? currentUserId,
    required Color textColor,
    required Color subTextColor,
  }) {
    // 교회 미등록
    if (community.churchId == null &&
        community.churchName == null &&
        !community.isLoading) {
      return RefreshIndicator(
        onRefresh: () => ref.read(communityProvider.notifier).refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppTheme.spacingXL),
          child: const NoChurchEmptyState(),
        ),
      );
    }

    // 로딩 중
    if (community.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    // 에러
    if (community.error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: subTextColor, size: 48),
            const SizedBox(height: AppTheme.spacingMD),
            Text(
              community.error!,
              style: AppTypography.bodyMedium(subTextColor),
            ),
            const SizedBox(height: AppTheme.spacingLG),
            ElevatedButton(
              onPressed: () =>
                  ref.read(communityProvider.notifier).refresh(),
              child: const Text('다시 시도'),
            ),
          ],
        ),
      );
    }

    // 메인 콘텐츠
    return RefreshIndicator(
      onRefresh: () => ref.read(communityProvider.notifier).refresh(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppTheme.spacingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 교회 헤더
            _buildChurchHeader(community, textColor, subTextColor),
            const SizedBox(height: AppTheme.spacingXL),

            // 받은 친구 요청 (있을 때만 표시)
            if (community.pendingReceived.isNotEmpty) ...[
              _buildPendingRequests(
                  community, currentUserId, textColor, subTextColor),
              const SizedBox(height: AppTheme.spacingXL),
            ],

            // 내 친구 섹션
            _buildFriendsSection(
                community, currentUserId, textColor, subTextColor),
            const SizedBox(height: AppTheme.spacingXL),

            // 같은 교회 멤버 섹션
            _buildMembersSection(
                community, currentUserId, textColor, subTextColor),
            const SizedBox(height: AppTheme.spacingXL),

            // 교회 랭킹 섹션
            _buildRankingSection(
                community, currentUserId, textColor, subTextColor),
            const SizedBox(height: AppTheme.spacingXL),
          ],
        ),
      ),
    );
  }

  /// 교회 헤더
  Widget _buildChurchHeader(
    CommunityState community,
    Color textColor,
    Color subTextColor,
  ) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            ),
            child: const Icon(
              Icons.church,
              color: AppColors.primaryDark,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMD),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  community.churchName ?? '교회',
                  style: AppTypography.titleLarge(textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  '멤버 ${community.members.length}명 · 친구 ${community.friends.length}명',
                  style: AppTypography.label(subTextColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 받은 친구 요청 섹션
  Widget _buildPendingRequests(
    CommunityState community,
    String? currentUserId,
    Color textColor,
    Color subTextColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.person_add, color: AppColors.streakFlame, size: 18),
            const SizedBox(width: AppTheme.spacingSM),
            Text(
              '받은 친구 요청',
              style: AppTypography.titleMedium(textColor),
            ),
            const SizedBox(width: AppTheme.spacingSM),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.streakFlame.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppTheme.radiusRound),
              ),
              child: Text(
                '${community.pendingReceived.length}',
                style: AppTypography.label(AppColors.streakFlame),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingMD),
        GlassCard(
          padding: const EdgeInsets.symmetric(
            vertical: AppTheme.spacingSM,
            horizontal: AppTheme.spacingXS,
          ),
          child: Column(
            children: community.pendingReceived.map((friendship) {
              // Key for efficient list updates
              // 요청 보낸 사람의 프로필을 멤버 목록에서 찾기
              final requester = community.members.firstWhere(
                (m) => m.id == friendship.requesterId,
                orElse: () => ChurchMember(
                  id: friendship.requesterId,
                  displayName: '에덴 사용자',
                ),
              );
              return _buildPendingCard(
                  requester, friendship, textColor, subTextColor);
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// 개별 요청 카드 (수락/거절 버튼)
  Widget _buildPendingCard(
    ChurchMember requester,
    Friendship friendship,
    Color textColor,
    Color subTextColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMD,
        vertical: AppTheme.spacingSM,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: AppColors.primaryDark, size: 22),
          ),
          const SizedBox(width: AppTheme.spacingMD),
          Expanded(
            child: Text(
              requester.displayName.isNotEmpty
                  ? requester.displayName
                  : '에덴 사용자',
              style: AppTypography.titleMedium(textColor),
            ),
          ),
          // 수락
          GestureDetector(
            onTap: () {
              ref.read(communityProvider.notifier).acceptFriendRequest(friendship.id);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryDark,
                borderRadius: BorderRadius.circular(AppTheme.radiusRound),
              ),
              child: Text(
                '수락',
                style: AppTypography.label(Colors.white),
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacingSM),
          // 거절
          GestureDetector(
            onTap: () {
              ref.read(communityProvider.notifier).removeFriendship(friendship.id);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(AppTheme.radiusRound),
              ),
              child: Text(
                '거절',
                style: AppTypography.label(AppColors.error),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 내 친구 섹션
  Widget _buildFriendsSection(
    CommunityState community,
    String? currentUserId,
    Color textColor,
    Color subTextColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.people, color: AppColors.primaryDark, size: 18),
            const SizedBox(width: AppTheme.spacingSM),
            Text(
              '내 친구',
              style: AppTypography.titleMedium(textColor),
            ),
            const SizedBox(width: AppTheme.spacingSM),
            Text(
              '${community.friends.length}명',
              style: AppTypography.label(subTextColor),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingMD),
        if (community.friends.isEmpty)
          GlassCard(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingXL),
                child: Column(
                  children: [
                    Icon(
                      Icons.people_outline,
                      color: subTextColor.withValues(alpha: 0.4),
                      size: 40,
                    ),
                    const SizedBox(height: AppTheme.spacingMD),
                    Text(
                      '아래 교회 멤버에서 친구를 추가해보세요!',
                      style: AppTypography.bodyMedium(subTextColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          GlassCard(
            padding: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingSM,
              horizontal: AppTheme.spacingXS,
            ),
            child: Column(
              children: community.friends.map((friend) {
                return MemberCard(
                  key: ValueKey(friend.id),
                  member: friend,
                  friendshipStatus: FriendshipStatus.accepted,
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  /// 같은 교회 멤버 리스트 섹션
  Widget _buildMembersSection(
    CommunityState community,
    String? currentUserId,
    Color textColor,
    Color subTextColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.church_outlined, color: AppColors.primaryDark, size: 18),
            const SizedBox(width: AppTheme.spacingSM),
            Text(
              '같은 교회 멤버',
              style: AppTypography.titleMedium(textColor),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingMD),
        if (community.members.isEmpty)
          GlassCard(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingXL),
                child: Text(
                  '아직 같은 교회 멤버가 없어요',
                  style: AppTypography.bodyMedium(subTextColor),
                ),
              ),
            ),
          )
        else
          GlassCard(
            padding: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingSM,
              horizontal: AppTheme.spacingXS,
            ),
            child: Column(
              children: community.members.map((member) {
                final isMe = member.id == currentUserId;
                final friendStatus = currentUserId != null
                    ? community.getFriendshipStatus(member.id, currentUserId)
                    : FriendshipStatus.none;

                return MemberCard(
                  key: ValueKey(member.id),
                  member: member,
                  isCurrentUser: isMe,
                  friendshipStatus: friendStatus,
                  onFriendAction: isMe
                      ? null
                      : () => _handleFriendAction(
                            member, friendStatus, community, currentUserId),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  /// 친구 버튼 액션 처리
  void _handleFriendAction(
    ChurchMember member,
    FriendshipStatus status,
    CommunityState community,
    String? currentUserId,
  ) {
    switch (status) {
      case FriendshipStatus.none:
        // 친구 요청 보내기
        ref.read(communityProvider.notifier).sendFriendRequest(member.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${member.displayName}님에게 친구 요청을 보냈어요'),
            backgroundColor: AppColors.primaryDark,
          ),
        );
      case FriendshipStatus.received:
        // 수락하기 — 해당 friendship 찾기
        final friendship = community.friendships.firstWhere(
          (f) =>
              f.requesterId == member.id &&
              f.receiverId == currentUserId &&
              f.status == 'pending',
        );
        ref.read(communityProvider.notifier).acceptFriendRequest(friendship.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${member.displayName}님과 친구가 되었어요!'),
            backgroundColor: AppColors.primaryDark,
          ),
        );
      case FriendshipStatus.pending:
      case FriendshipStatus.accepted:
        break; // 이미 처리됨
    }
  }

  /// 교회 랭킹 섹션
  Widget _buildRankingSection(
    CommunityState community,
    String? currentUserId,
    Color textColor,
    Color subTextColor,
  ) {
    final sortedMembers = community.sortedMembers;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.emoji_events_outlined,
                color: AppColors.gold, size: 18),
            const SizedBox(width: AppTheme.spacingSM),
            Text(
              '교회 랭킹',
              style: AppTypography.titleMedium(textColor),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingSM),

        // 정렬 토글 칩
        _buildSortChips(community.sortBy, textColor, subTextColor),
        const SizedBox(height: AppTheme.spacingMD),

        if (sortedMembers.isEmpty)
          GlassCard(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingXL),
                child: Text(
                  '랭킹 데이터가 없어요',
                  style: AppTypography.bodyMedium(subTextColor),
                ),
              ),
            ),
          )
        else
          GlassCard(
            padding: const EdgeInsets.symmetric(
              vertical: AppTheme.spacingSM,
              horizontal: AppTheme.spacingXS,
            ),
            child: Column(
              children: List.generate(sortedMembers.length, (index) {
                final member = sortedMembers[index];
                return MemberCard(
                  member: member,
                  rank: index + 1,
                  isCurrentUser: member.id == currentUserId,
                );
              }),
            ),
          ),
      ],
    );
  }

  /// 정렬 토글 칩
  Widget _buildSortChips(
    RankingSortType currentSort,
    Color textColor,
    Color subTextColor,
  ) {
    final chips = [
      (RankingSortType.streak, '연속 묵상', Icons.local_fire_department),
      (RankingSortType.faithPoints, '포인트', Icons.stars),
      (RankingSortType.level, '레벨', Icons.eco),
    ];

    return Row(
      children: chips.map((chip) {
        final (type, label, icon) = chip;
        final isSelected = currentSort == type;
        return Padding(
          padding: const EdgeInsets.only(right: AppTheme.spacingSM),
          child: FilterChip(
            selected: isSelected,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: isSelected ? AppColors.primaryDark : subTextColor,
                ),
                const SizedBox(width: 4),
                Text(label),
              ],
            ),
            onSelected: (_) {
              ref.read(communityProvider.notifier).changeSortType(type);
            },
            selectedColor: AppColors.primary.withValues(alpha: 0.3),
            checkmarkColor: AppColors.primaryDark,
            labelStyle: AppTypography.label(
              isSelected ? AppColors.primaryDark : subTextColor,
            ),
            side: BorderSide(
              color: isSelected
                  ? AppColors.primary
                  : subTextColor.withValues(alpha: 0.3),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusRound),
            ),
          ),
        );
      }).toList(),
    );
  }
}
