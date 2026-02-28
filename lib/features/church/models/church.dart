/// 교회 모델
class Church {
  final String id;
  final String name;
  final String? denomination;
  final String? address;
  final String? city;
  final String? district;
  final int memberCount;
  final bool verified;
  final DateTime createdAt;

  const Church({
    required this.id,
    required this.name,
    this.denomination,
    this.address,
    this.city,
    this.district,
    this.memberCount = 0,
    this.verified = false,
    required this.createdAt,
  });

  factory Church.fromJson(Map<String, dynamic> json) {
    return Church(
      id: json['id'] as String,
      name: json['name'] as String,
      denomination: json['denomination'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      district: json['district'] as String?,
      memberCount: json['member_count'] as int? ?? 0,
      verified: json['verified'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  /// 교회 위치 표시 문자열
  String get location {
    final parts = <String>[];
    if (city != null) parts.add(city!);
    if (district != null) parts.add(district!);
    return parts.isEmpty ? '' : parts.join(' ');
  }
}
