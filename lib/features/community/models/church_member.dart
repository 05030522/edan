/// 교회 멤버 모델 (커뮤니티 탭에서 표시할 공개 정보만 포함)
class ChurchMember {
  final String id;
  final String displayName;
  final int currentLevel;
  final int currentStreak;
  final int faithPoints;

  /// 고유 태그 번호 (id 해시 기반, 0000~9999)
  String get tag {
    final hash = id.hashCode.abs() % 10000;
    return '#${hash.toString().padLeft(4, '0')}';
  }

  /// 이름 + 태그
  String get displayNameWithTag => '$displayName $tag';

  const ChurchMember({
    required this.id,
    required this.displayName,
    this.currentLevel = 1,
    this.currentStreak = 0,
    this.faithPoints = 0,
  });

  factory ChurchMember.fromJson(Map<String, dynamic> json) {
    return ChurchMember(
      id: json['id'] as String,
      displayName: json['display_name'] as String? ?? '',
      currentLevel: json['current_level'] as int? ?? 1,
      currentStreak: json['current_streak'] as int? ?? 0,
      faithPoints: json['faith_points'] as int? ?? 0,
    );
  }
}

/// 친구 관계 상태
enum FriendshipStatus {
  none,        // 관계 없음
  pending,     // 내가 요청 보냄 (대기 중)
  received,    // 상대방이 나에게 요청 보냄
  accepted,    // 친구
}

/// 친구 관계 모델
class Friendship {
  final String id;
  final String requesterId;
  final String receiverId;
  final String status; // 'pending', 'accepted', 'rejected'
  final DateTime createdAt;

  const Friendship({
    required this.id,
    required this.requesterId,
    required this.receiverId,
    required this.status,
    required this.createdAt,
  });

  factory Friendship.fromJson(Map<String, dynamic> json) {
    return Friendship(
      id: json['id'] as String,
      requesterId: json['requester_id'] as String,
      receiverId: json['receiver_id'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
