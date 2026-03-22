import 'dart:convert';
import 'package:http/http.dart' as http;

/// 카카오 로컬 API - 키워드 장소 검색 서비스
/// 실제 존재하는 교회만 검색 가능
class KakaoPlaceService {
  KakaoPlaceService._();

  static const String _restApiKey = 'e16ec4d92b108cba0871ed527a2e4bf0';
  static const String _baseUrl =
      'https://dapi.kakao.com/v2/local/search/keyword.json';

  /// 교회 키워드로 장소 검색
  /// [query] 사용자 입력 (예: "사랑의교회")
  /// 카카오 카테고리 "종교 > 기독교" 필터 적용
  static Future<List<KakaoChurchResult>> searchChurch(String query) async {
    if (query.trim().isEmpty) return [];

    // "교회"가 포함되지 않으면 자동 추가
    final searchQuery = query.contains('교회') ? query : '$query교회';

    try {
      final uri = Uri.parse(_baseUrl).replace(queryParameters: {
        'query': searchQuery,
        'category_group_code': 'RE',  // 종교 카테고리
        'size': '15',
      });

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'KakaoAK $_restApiKey',
        },
      );

      if (response.statusCode != 200) {
        return [];
      }

      final data = json.decode(response.body);
      final documents = data['documents'] as List<dynamic>;

      // "교회"가 포함된 결과만 필터
      return documents
          .where((doc) =>
              (doc['place_name'] as String).contains('교회') ||
              (doc['category_name'] as String?)?.contains('기독교') == true)
          .map((doc) => KakaoChurchResult.fromJson(doc))
          .toList();
    } catch (e) {
      return [];
    }
  }
}

/// 카카오 장소 검색 결과 모델
class KakaoChurchResult {
  final String id;
  final String name;
  final String address;
  final String? roadAddress;
  final String? phone;
  final double? latitude;
  final double? longitude;

  const KakaoChurchResult({
    required this.id,
    required this.name,
    required this.address,
    this.roadAddress,
    this.phone,
    this.latitude,
    this.longitude,
  });

  factory KakaoChurchResult.fromJson(Map<String, dynamic> json) {
    return KakaoChurchResult(
      id: json['id'] as String,
      name: json['place_name'] as String,
      address: json['address_name'] as String,
      roadAddress: json['road_address_name'] as String?,
      phone: json['phone'] as String?,
      latitude: double.tryParse(json['y'] ?? ''),
      longitude: double.tryParse(json['x'] ?? ''),
    );
  }

  /// 화면에 표시할 짧은 주소 (시/구 까지만)
  String get shortAddress {
    final parts = address.split(' ');
    if (parts.length >= 2) {
      return parts.take(2).join(' ');
    }
    return address;
  }
}
