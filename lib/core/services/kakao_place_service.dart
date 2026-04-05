/// 교회 검색 서비스
/// 로컬 데이터베이스에서 교회를 검색합니다
class KakaoPlaceService {
  KakaoPlaceService._();

  /// 교회 키워드로 검색
  /// [query] 사용자 입력 (예: "명성", "사랑의교회")
  static Future<List<KakaoChurchResult>> searchChurch(String query) async {
    if (query.trim().isEmpty) return [];

    final keyword = query.trim().replaceAll('교회', '').trim();
    if (keyword.isEmpty) return _churches.take(15).toList();

    return _churches
        .where((c) =>
            c.name.contains(keyword) ||
            c.address.contains(keyword) ||
            (c.roadAddress?.contains(keyword) ?? false))
        .take(15)
        .toList();
  }

  /// 한국 주요 교회 데이터
  static final List<KakaoChurchResult> _churches = [
    // 서울
    const KakaoChurchResult(id: '1', name: '명성교회', address: '서울 강동구 명일동', roadAddress: '서울 강동구 강동대로 52길 43'),
    const KakaoChurchResult(id: '2', name: '여의도순복음교회', address: '서울 영등포구 여의도동', roadAddress: '서울 영등포구 의사당대로 12'),
    const KakaoChurchResult(id: '3', name: '사랑의교회', address: '서울 서초구 서초동', roadAddress: '서울 서초구 반포대로 121'),
    const KakaoChurchResult(id: '4', name: '온누리교회', address: '서울 용산구 이태원동', roadAddress: '서울 용산구 녹사평대로 244'),
    const KakaoChurchResult(id: '5', name: '소망교회', address: '서울 마포구 성산동', roadAddress: '서울 마포구 성산로 175'),
    const KakaoChurchResult(id: '6', name: '충신교회', address: '서울 종로구 충신동', roadAddress: '서울 종로구 대학로 133'),
    const KakaoChurchResult(id: '7', name: '영락교회', address: '서울 중구 저동', roadAddress: '서울 중구 저동 1가 120'),
    const KakaoChurchResult(id: '8', name: '광림교회', address: '서울 강남구 신사동', roadAddress: '서울 강남구 압구정로 29길 40'),
    const KakaoChurchResult(id: '9', name: '할렐루야교회', address: '서울 송파구 가락동', roadAddress: '서울 송파구 동남로 263'),
    const KakaoChurchResult(id: '10', name: '지구촌교회', address: '서울 서초구 양재동', roadAddress: '서울 서초구 바우뫼로 150'),
    const KakaoChurchResult(id: '11', name: '꿈의교회', address: '서울 강동구 천호동', roadAddress: '서울 강동구 천호대로 1077'),
    const KakaoChurchResult(id: '12', name: '강남중앙교회', address: '서울 강남구 역삼동', roadAddress: '서울 강남구 테헤란로 151'),
    const KakaoChurchResult(id: '13', name: '새문안교회', address: '서울 종로구 신문로', roadAddress: '서울 종로구 새문안로 42'),
    const KakaoChurchResult(id: '14', name: '경동교회', address: '서울 동대문구 창신동', roadAddress: '서울 동대문구 지봉로 128'),
    const KakaoChurchResult(id: '15', name: '동대문교회', address: '서울 동대문구 용두동', roadAddress: '서울 동대문구 왕산로 12'),
    const KakaoChurchResult(id: '16', name: '서울교회', address: '서울 종로구 혜화동', roadAddress: '서울 종로구 대학로10길 23'),
    const KakaoChurchResult(id: '17', name: '남서울교회', address: '서울 서초구 양재동', roadAddress: '서울 서초구 강남대로 22길 28'),
    const KakaoChurchResult(id: '18', name: '한소망교회', address: '서울 강서구 화곡동', roadAddress: '서울 강서구 화곡로 309'),
    const KakaoChurchResult(id: '19', name: '홍은교회', address: '서울 서대문구 홍은동', roadAddress: '서울 서대문구 통일로 430'),
    const KakaoChurchResult(id: '20', name: '성암교회', address: '서울 종로구 평창동', roadAddress: '서울 종로구 평창문화로 85'),
    const KakaoChurchResult(id: '21', name: '강변교회', address: '서울 광진구 구의동', roadAddress: '서울 광진구 광나루로 417'),
    const KakaoChurchResult(id: '22', name: '연세중앙교회', address: '서울 양천구 신정동', roadAddress: '서울 양천구 오목로 205'),
    const KakaoChurchResult(id: '23', name: '장충교회', address: '서울 중구 장충동', roadAddress: '서울 중구 동호로 249'),
    const KakaoChurchResult(id: '24', name: '만나교회', address: '서울 송파구 방이동', roadAddress: '서울 송파구 올림픽로 35길 124'),
    const KakaoChurchResult(id: '25', name: '반포교회', address: '서울 서초구 반포동', roadAddress: '서울 서초구 반포대로 265'),
    // 경기도
    const KakaoChurchResult(id: '26', name: '분당우리교회', address: '경기 성남시 분당구 이매동', roadAddress: '경기 성남시 분당구 이매로 30'),
    const KakaoChurchResult(id: '27', name: '일산교회', address: '경기 고양시 일산동구', roadAddress: '경기 고양시 일산동구 중앙로 1275번길'),
    const KakaoChurchResult(id: '28', name: '수원중앙교회', address: '경기 수원시 팔달구', roadAddress: '경기 수원시 팔달구 효원로 298'),
    const KakaoChurchResult(id: '29', name: '안양신교회', address: '경기 안양시 만안구', roadAddress: '경기 안양시 만안구 안양로 287'),
    const KakaoChurchResult(id: '30', name: '평촌교회', address: '경기 안양시 동안구', roadAddress: '경기 안양시 동안구 평촌대로 150'),
    const KakaoChurchResult(id: '31', name: '용인교회', address: '경기 용인시 처인구', roadAddress: '경기 용인시 처인구 금학로 19'),
    const KakaoChurchResult(id: '32', name: '화정교회', address: '경기 고양시 덕양구 화정동', roadAddress: '경기 고양시 덕양구 화신로 260'),
    const KakaoChurchResult(id: '33', name: '성남교회', address: '경기 성남시 수정구', roadAddress: '경기 성남시 수정구 산성대로 312'),
    const KakaoChurchResult(id: '34', name: '남양주교회', address: '경기 남양주시 와부읍', roadAddress: '경기 남양주시 와부읍 덕소로 49'),
    const KakaoChurchResult(id: '35', name: '파주교회', address: '경기 파주시 금촌동', roadAddress: '경기 파주시 중앙로 79'),
    const KakaoChurchResult(id: '36', name: '동탄교회', address: '경기 화성시 동탄', roadAddress: '경기 화성시 동탄반석로 133'),
    const KakaoChurchResult(id: '37', name: '김포교회', address: '경기 김포시 사우동', roadAddress: '경기 김포시 김포대로 791'),
    const KakaoChurchResult(id: '38', name: '의정부교회', address: '경기 의정부시 의정부동', roadAddress: '경기 의정부시 시민로 45'),
    const KakaoChurchResult(id: '39', name: '부천교회', address: '경기 부천시 원미구', roadAddress: '경기 부천시 원미구 부일로 652'),
    const KakaoChurchResult(id: '40', name: '광명교회', address: '경기 광명시 광명동', roadAddress: '경기 광명시 오리로 820'),
    // 인천
    const KakaoChurchResult(id: '41', name: '인천제일교회', address: '인천 중구 내동', roadAddress: '인천 중구 신포로 38'),
    const KakaoChurchResult(id: '42', name: '부평교회', address: '인천 부평구 부평동', roadAddress: '인천 부평구 부평대로 21'),
    const KakaoChurchResult(id: '43', name: '송도교회', address: '인천 연수구 송도동', roadAddress: '인천 연수구 송도과학로 49'),
    // 부산
    const KakaoChurchResult(id: '44', name: '수영로교회', address: '부산 수영구 수영동', roadAddress: '부산 수영구 수영로 661'),
    const KakaoChurchResult(id: '45', name: '부산중앙교회', address: '부산 동구 범일동', roadAddress: '부산 동구 중앙대로 396'),
    const KakaoChurchResult(id: '46', name: '해운대교회', address: '부산 해운대구 좌동', roadAddress: '부산 해운대구 세실로 67'),
    const KakaoChurchResult(id: '47', name: '동래교회', address: '부산 동래구 수안동', roadAddress: '부산 동래구 중앙대로 1407'),
    const KakaoChurchResult(id: '48', name: '부전교회', address: '부산 부산진구 부전동', roadAddress: '부산 부산진구 중앙대로 749'),
    const KakaoChurchResult(id: '49', name: '초량교회', address: '부산 동구 초량동', roadAddress: '부산 동구 초량중로 45'),
    const KakaoChurchResult(id: '50', name: '남포교회', address: '부산 중구 남포동', roadAddress: '부산 중구 광복로 49'),
    // 대구
    const KakaoChurchResult(id: '51', name: '대구동산교회', address: '대구 중구 동산동', roadAddress: '대구 중구 달구벌대로 2029'),
    const KakaoChurchResult(id: '52', name: '대구제일교회', address: '대구 중구 남산동', roadAddress: '대구 중구 국채보상로 140길 32'),
    const KakaoChurchResult(id: '53', name: '서문교회', address: '대구 달서구 두류동', roadAddress: '대구 달서구 달구벌대로 1640'),
    const KakaoChurchResult(id: '54', name: '수성교회', address: '대구 수성구 범어동', roadAddress: '대구 수성구 범어로 31'),
    // 대전
    const KakaoChurchResult(id: '55', name: '대전중앙교회', address: '대전 중구 대흥동', roadAddress: '대전 중구 보문로 234'),
    const KakaoChurchResult(id: '56', name: '충남교회', address: '대전 서구 둔산동', roadAddress: '대전 서구 둔산대로 127번길 43'),
    const KakaoChurchResult(id: '57', name: '한빛교회', address: '대전 유성구 봉명동', roadAddress: '대전 유성구 대학로 219'),
    const KakaoChurchResult(id: '58', name: '새로남교회', address: '대전 서구 갈마동', roadAddress: '대전 서구 갈마로 50'),
    // 광주
    const KakaoChurchResult(id: '59', name: '광주제일교회', address: '광주 동구 금남로', roadAddress: '광주 동구 금남로 234'),
    const KakaoChurchResult(id: '60', name: '광주중앙교회', address: '광주 서구 양동', roadAddress: '광주 서구 상무중앙로 66'),
    const KakaoChurchResult(id: '61', name: '무등교회', address: '광주 동구 산수동', roadAddress: '광주 동구 서석로 35'),
    // 울산
    const KakaoChurchResult(id: '62', name: '울산중앙교회', address: '울산 남구 달동', roadAddress: '울산 남구 삼산로 278'),
    const KakaoChurchResult(id: '63', name: '울산교회', address: '울산 중구 성남동', roadAddress: '울산 중구 새즈믄해거리로 23'),
    // 세종/충청
    const KakaoChurchResult(id: '64', name: '천안중앙교회', address: '충남 천안시 동남구', roadAddress: '충남 천안시 동남구 중앙로 98'),
    const KakaoChurchResult(id: '65', name: '청주교회', address: '충북 청주시 상당구', roadAddress: '충북 청주시 상당구 상당로 92'),
    const KakaoChurchResult(id: '66', name: '세종교회', address: '세종시 조치원읍', roadAddress: '세종시 조치원읍 새내로 62'),
    const KakaoChurchResult(id: '67', name: '충주교회', address: '충북 충주시 교현동', roadAddress: '충북 충주시 번영대로 43'),
    // 전라도
    const KakaoChurchResult(id: '68', name: '전주중앙교회', address: '전북 전주시 완산구', roadAddress: '전북 전주시 완산구 전주객사4길 26'),
    const KakaoChurchResult(id: '69', name: '군산제일교회', address: '전북 군산시 영화동', roadAddress: '전북 군산시 구영1길 12'),
    const KakaoChurchResult(id: '70', name: '목포중앙교회', address: '전남 목포시 대성동', roadAddress: '전남 목포시 영산로 226'),
    const KakaoChurchResult(id: '71', name: '순천교회', address: '전남 순천시 장천동', roadAddress: '전남 순천시 장천로 8'),
    const KakaoChurchResult(id: '72', name: '여수교회', address: '전남 여수시 교동', roadAddress: '전남 여수시 좌수영로 1'),
    // 경상도
    const KakaoChurchResult(id: '73', name: '포항중앙교회', address: '경북 포항시 북구', roadAddress: '경북 포항시 북구 중앙로 291'),
    const KakaoChurchResult(id: '74', name: '경주교회', address: '경북 경주시 성건동', roadAddress: '경북 경주시 태종로 776'),
    const KakaoChurchResult(id: '75', name: '안동교회', address: '경북 안동시 북문동', roadAddress: '경북 안동시 경동로 581'),
    const KakaoChurchResult(id: '76', name: '창원중앙교회', address: '경남 창원시 성산구', roadAddress: '경남 창원시 성산구 원이대로 451'),
    const KakaoChurchResult(id: '77', name: '진주교회', address: '경남 진주시 본성동', roadAddress: '경남 진주시 진주대로 840'),
    const KakaoChurchResult(id: '78', name: '김해교회', address: '경남 김해시 내동', roadAddress: '경남 김해시 가야로 75'),
    const KakaoChurchResult(id: '79', name: '거제교회', address: '경남 거제시 고현동', roadAddress: '경남 거제시 거제중앙로 1575'),
    const KakaoChurchResult(id: '80', name: '마산교회', address: '경남 창원시 마산합포구', roadAddress: '경남 창원시 마산합포구 3.15대로 183'),
    // 강원도
    const KakaoChurchResult(id: '81', name: '춘천교회', address: '강원 춘천시 죽림동', roadAddress: '강원 춘천시 중앙로 58'),
    const KakaoChurchResult(id: '82', name: '원주교회', address: '강원 원주시 중앙동', roadAddress: '강원 원주시 원일로 95'),
    const KakaoChurchResult(id: '83', name: '강릉교회', address: '강원 강릉시 임당동', roadAddress: '강원 강릉시 경강로 2070'),
    const KakaoChurchResult(id: '84', name: '속초교회', address: '강원 속초시 교동', roadAddress: '강원 속초시 수복로 150'),
    // 제주도
    const KakaoChurchResult(id: '85', name: '제주교회', address: '제주 제주시 이도동', roadAddress: '제주 제주시 중앙로 65'),
    const KakaoChurchResult(id: '86', name: '서귀포교회', address: '제주 서귀포시 서귀동', roadAddress: '제주 서귀포시 중앙로 106'),
    // 대형/유명 교회 추가
    const KakaoChurchResult(id: '87', name: '새벽교회', address: '서울 노원구 상계동', roadAddress: '서울 노원구 상계로 10길 50'),
    const KakaoChurchResult(id: '88', name: '풍성한교회', address: '서울 송파구 문정동', roadAddress: '서울 송파구 법원로 114'),
    const KakaoChurchResult(id: '89', name: '열린문교회', address: '서울 성북구 정릉동', roadAddress: '서울 성북구 정릉로 207'),
    const KakaoChurchResult(id: '90', name: '동안교회', address: '경기 안양시 동안구', roadAddress: '경기 안양시 동안구 평촌대로 387'),
    const KakaoChurchResult(id: '91', name: '은혜교회', address: '서울 관악구 봉천동', roadAddress: '서울 관악구 관악로 230'),
    const KakaoChurchResult(id: '92', name: '신촌교회', address: '서울 서대문구 신촌동', roadAddress: '서울 서대문구 연세로 7길 33'),
    const KakaoChurchResult(id: '93', name: '감리교신학대학교교회', address: '서울 서대문구 냉천동', roadAddress: '서울 서대문구 냉천로 21'),
    const KakaoChurchResult(id: '94', name: '강서교회', address: '서울 강서구 등촌동', roadAddress: '서울 강서구 강서로 160'),
    const KakaoChurchResult(id: '95', name: '목동교회', address: '서울 양천구 목동', roadAddress: '서울 양천구 목동서로 215'),
    const KakaoChurchResult(id: '96', name: '잠실교회', address: '서울 송파구 잠실동', roadAddress: '서울 송파구 올림픽로 289'),
    const KakaoChurchResult(id: '97', name: '구리교회', address: '경기 구리시 인창동', roadAddress: '경기 구리시 건원대로 7'),
    const KakaoChurchResult(id: '98', name: '산본교회', address: '경기 군포시 산본동', roadAddress: '경기 군포시 번영로 147'),
    const KakaoChurchResult(id: '99', name: '시흥교회', address: '경기 시흥시 대야동', roadAddress: '경기 시흥시 서울대학로 55'),
    const KakaoChurchResult(id: '100', name: '하남교회', address: '경기 하남시 신장동', roadAddress: '경기 하남시 대청로 64'),
  ];
}

/// 교회 검색 결과 모델
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
