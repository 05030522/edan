import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/constants/app_constants.dart';
import '../models/church_member.dart';

/// 교회 멤버 카드 위젯
/// 멤버 리스트와 랭킹 모드에서 모두 사용
class MemberCard extends StatelessWidget {
  final ChurchMember member;
  final int? rank; // null이면 일반 모드, 숫자면 랭킹 모드
  final bool isCurrentUser;
  final FriendshipStatus friendshipStatus;
  final VoidCallback? onFriendAction; // 친구 추가/수락/취소 등

  const MemberCard({
    super.key,
    required this.member,
    this.rank,
    this.isCurrentUser = false,
    this.friendshipStatus = FriendshipStatus.none,
    this.onFriendAction,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subTextColor =
        isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

    final levelIndex =
        (member.currentLevel - 1).clamp(0, AppConstants.levelNames.length - 1);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMD,
        vertical: AppTheme.spacingSM + 2,
      ),
      decoration: isCurrentUser
          ? BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
            )
          : null,
      child: Row(
        children: [
          // 랭킹 번호
          if (rank != null) ...[
            SizedBox(
              width: 32,
              child: _buildRankWidget(rank!, textColor),
            ),
            const SizedBox(width: AppTheme.spacingSM),
          ],

          // 아바타
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.primaryDark,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacingMD),

          // 이름 + 레벨
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        member.displayName.isNotEmpty
                            ? member.displayName
                            : '에덴 사용자',
                        style: AppTypography.titleMedium(textColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isCurrentUser) ...[
                      const SizedBox(width: AppTheme.spacingXS),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryDark.withValues(alpha: 0.15),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusRound),
                        ),
                        child: Text(
                          '나',
                          style: AppTypography.label(AppColors.primaryDark),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Lv.${member.currentLevel} ${AppConstants.levelNames[levelIndex]}',
                  style: AppTypography.label(subTextColor),
                ),
              ],
            ),
          ),

          // 친구 상태 버튼 (본인 제외, 랭킹 모드가 아닐 때)
          if (!isCurrentUser && rank == null) ...[
            _buildFriendButton(subTextColor),
            const SizedBox(width: AppTheme.spacingSM),
          ],

          // 스트릭 + FP
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: AppColors.streakFlame,
                    size: 16,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${member.currentStreak}',
                    style: AppTypography.titleMedium(AppColors.streakFlame),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.stars,
                    color: AppColors.gold,
                    size: 14,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${member.faithPoints}',
                    style: AppTypography.label(AppColors.gold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 친구 상태 버튼
  Widget _buildFriendButton(Color subTextColor) {
    switch (friendshipStatus) {
      case FriendshipStatus.none:
        return _friendActionButton(
          icon: Icons.person_add_outlined,
          color: AppColors.primaryDark,
          bgColor: AppColors.primary.withValues(alpha: 0.15),
          onTap: onFriendAction,
        );
      case FriendshipStatus.pending:
        return _friendActionButton(
          icon: Icons.hourglass_top,
          color: AppColors.warning,
          bgColor: AppColors.warning.withValues(alpha: 0.15),
          onTap: null, // 대기 중 - 탭 불가
        );
      case FriendshipStatus.received:
        return _friendActionButton(
          icon: Icons.check_circle_outline,
          color: AppColors.success,
          bgColor: AppColors.success.withValues(alpha: 0.15),
          onTap: onFriendAction, // 수락하기
        );
      case FriendshipStatus.accepted:
        return _friendActionButton(
          icon: Icons.people,
          color: AppColors.primaryDark,
          bgColor: AppColors.primary.withValues(alpha: 0.15),
          onTap: null,
        );
    }
  }

  Widget _friendActionButton({
    required IconData icon,
    required Color color,
    required Color bgColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }

  /// 랭킹 순위 위젯 (1~3위 메달, 4위+ 숫자)
  Widget _buildRankWidget(int rank, Color textColor) {
    if (rank <= 3) {
      final colors = [
        const Color(0xFFFFD700), // 금
        const Color(0xFFC0C0C0), // 은
        const Color(0xFFCD7F32), // 동
      ];
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: colors[rank - 1].withValues(alpha: 0.2),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          '$rank',
          style: AppTypography.titleMedium(colors[rank - 1]),
        ),
      );
    }
    return Text(
      '$rank',
      style: AppTypography.bodyMedium(textColor),
      textAlign: TextAlign.center,
    );
  }
}
