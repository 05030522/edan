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
        .where(
          (c) =>
              c.name.contains(keyword) ||
              c.address.contains(keyword) ||
              (c.roadAddress?.contains(keyword) ?? false),
        )
        .take(15)
        .toList();
  }

  /// 한국 주요 교회 데이터
  static final List<KakaoChurchResult> _churches = [
    // 서울
    const KakaoChurchResult(
      id: '1',
      name: '명성교회',
      address: '서울 강동구 명일동',
      roadAddress: '서울 강동구 강동대로 52길 43',
    ),
    const KakaoChurchResult(
      id: '2',
      name: '여의도순복음교회',
      address: '서울 영등포구 여의도동',
      roadAddress: '서울 영등포구 의사당대로 12',
    ),
    const KakaoChurchResult(
      id: '3',
      name: '사랑의교회',
      address: '서울 서초구 서초동',
      roadAddress: '서울 서초구 반포대로 121',
    ),
    const KakaoChurchResult(
      id: '4',
      name: '온누리교회',
      address: '서울 용산구 이태원동',
      roadAddress: '서울 용산구 녹사평대로 244',
    ),
    const KakaoChurchResult(
      id: '5',
      name: '소망교회',
      address: '서울 마포구 성산동',
      roadAddress: '서울 마포구 성산로 175',
    ),
    const KakaoChurchResult(
      id: '6',
      name: '충신교회',
      address: '서울 종로구 충신동',
      roadAddress: '서울 종로구 대학로 133',
    ),
    const KakaoChurchResult(
      id: '7',
      name: '영락교회',
      address: '서울 중구 저동',
      roadAddress: '서울 중구 저동 1가 120',
    ),
    const KakaoChurchResult(
      id: '8',
      name: '광림교회',
      address: '서울 강남구 신사동',
      roadAddress: '서울 강남구 압구정로 29길 40',
    ),
    const KakaoChurchResult(
      id: '9',
      name: '할렐루야교회',
      address: '서울 송파구 가락동',
      roadAddress: '서울 송파구 동남로 263',
    ),
    const KakaoChurchResult(
      id: '10',
      name: '지구촌교회',
      address: '서울 서초구 양재동',
      roadAddress: '서울 서초구 바우뫼로 150',
    ),
    const KakaoChurchResult(
      id: '11',
      name: '꿈의교회',
      address: '서울 강동구 천호동',
      roadAddress: '서울 강동구 천호대로 1077',
    ),
    const KakaoChurchResult(
      id: '12',
      name: '강남중앙교회',
      address: '서울 강남구 역삼동',
      roadAddress: '서울 강남구 테헤란로 151',
    ),
    const KakaoChurchResult(
      id: '13',
      name: '새문안교회',
      address: '서울 종로구 신문로',
      roadAddress: '서울 종로구 새문안로 42',
    ),
    const KakaoChurchResult(
      id: '14',
      name: '경동교회',
      address: '서울 동대문구 창신동',
      roadAddress: '서울 동대문구 지봉로 128',
    ),
    const KakaoChurchResult(
      id: '15',
      name: '동대문교회',
      address: '서울 동대문구 용두동',
      roadAddress: '서울 동대문구 왕산로 12',
    ),
    const KakaoChurchResult(
      id: '16',
      name: '서울교회',
      address: '서울 종로구 혜화동',
      roadAddress: '서울 종로구 대학로10길 23',
    ),
    const KakaoChurchResult(
      id: '17',
      name: '남서울교회',
      address: '서울 서초구 양재동',
      roadAddress: '서울 서초구 강남대로 22길 28',
    ),
    const KakaoChurchResult(
      id: '18',
      name: '한소망교회',
      address: '서울 강서구 화곡동',
      roadAddress: '서울 강서구 화곡로 309',
    ),
    const KakaoChurchResult(
      id: '19',
      name: '홍은교회',
      address: '서울 서대문구 홍은동',
      roadAddress: '서울 서대문구 통일로 430',
    ),
    const KakaoChurchResult(
      id: '20',
      name: '성암교회',
      address: '서울 종로구 평창동',
      roadAddress: '서울 종로구 평창문화로 85',
    ),
    const KakaoChurchResult(
      id: '21',
      name: '강변교회',
      address: '서울 광진구 구의동',
      roadAddress: '서울 광진구 광나루로 417',
    ),
    const KakaoChurchResult(
      id: '22',
      name: '연세중앙교회',
      address: '서울 양천구 신정동',
      roadAddress: '서울 양천구 오목로 205',
    ),
    const KakaoChurchResult(
      id: '23',
      name: '장충교회',
      address: '서울 중구 장충동',
      roadAddress: '서울 중구 동호로 249',
    ),
    const KakaoChurchResult(
      id: '24',
      name: '만나교회',
      address: '서울 송파구 방이동',
      roadAddress: '서울 송파구 올림픽로 35길 124',
    ),
    const KakaoChurchResult(
      id: '25',
      name: '반포교회',
      address: '서울 서초구 반포동',
      roadAddress: '서울 서초구 반포대로 265',
    ),
    // 경기도
    const KakaoChurchResult(
      id: '26',
      name: '분당우리교회',
      address: '경기 성남시 분당구 이매동',
      roadAddress: '경기 성남시 분당구 이매로 30',
    ),
    const KakaoChurchResult(
      id: '27',
      name: '일산교회',
      address: '경기 고양시 일산동구',
      roadAddress: '경기 고양시 일산동구 중앙로 1275번길',
    ),
    const KakaoChurchResult(
      id: '28',
      name: '수원중앙교회',
      address: '경기 수원시 팔달구',
      roadAddress: '경기 수원시 팔달구 효원로 298',
    ),
    const KakaoChurchResult(
      id: '29',
      name: '안양신교회',
      address: '경기 안양시 만안구',
      roadAddress: '경기 안양시 만안구 안양로 287',
    ),
    const KakaoChurchResult(
      id: '30',
      name: '평촌교회',
      address: '경기 안양시 동안구',
      roadAddress: '경기 안양시 동안구 평촌대로 150',
    ),
    const KakaoChurchResult(
      id: '31',
      name: '용인교회',
      address: '경기 용인시 처인구',
      roadAddress: '경기 용인시 처인구 금학로 19',
    ),
    const KakaoChurchResult(
      id: '32',
      name: '화정교회',
      address: '경기 고양시 덕양구 화정동',
      roadAddress: '경기 고양시 덕양구 화신로 260',
    ),
    const KakaoChurchResult(
      id: '33',
      name: '성남교회',
      address: '경기 성남시 수정구',
      roadAddress: '경기 성남시 수정구 산성대로 312',
    ),
    const KakaoChurchResult(
      id: '34',
      name: '남양주교회',
      address: '경기 남양주시 와부읍',
      roadAddress: '경기 남양주시 와부읍 덕소로 49',
    ),
    const KakaoChurchResult(
      id: '35',
      name: '파주교회',
      address: '경기 파주시 금촌동',
      roadAddress: '경기 파주시 중앙로 79',
    ),
    const KakaoChurchResult(
      id: '36',
      name: '동탄교회',
      address: '경기 화성시 동탄',
      roadAddress: '경기 화성시 동탄반석로 133',
    ),
    const KakaoChurchResult(
      id: '37',
      name: '김포교회',
      address: '경기 김포시 사우동',
      roadAddress: '경기 김포시 김포대로 791',
    ),
    const KakaoChurchResult(
      id: '38',
      name: '의정부교회',
      address: '경기 의정부시 의정부동',
      roadAddress: '경기 의정부시 시민로 45',
    ),
    const KakaoChurchResult(
      id: '39',
      name: '부천교회',
      address: '경기 부천시 원미구',
      roadAddress: '경기 부천시 원미구 부일로 652',
    ),
    const KakaoChurchResult(
      id: '40',
      name: '광명교회',
      address: '경기 광명시 광명동',
      roadAddress: '경기 광명시 오리로 820',
    ),
    // 인천
    const KakaoChurchResult(
      id: '41',
      name: '인천제일교회',
      address: '인천 중구 내동',
      roadAddress: '인천 중구 신포로 38',
    ),
    const KakaoChurchResult(
      id: '42',
      name: '부평교회',
      address: '인천 부평구 부평동',
      roadAddress: '인천 부평구 부평대로 21',
    ),
    const KakaoChurchResult(
      id: '43',
      name: '송도교회',
      address: '인천 연수구 송도동',
      roadAddress: '인천 연수구 송도과학로 49',
    ),
    // 부산
    const KakaoChurchResult(
      id: '44',
      name: '수영로교회',
      address: '부산 수영구 수영동',
      roadAddress: '부산 수영구 수영로 661',
    ),
    const KakaoChurchResult(
      id: '45',
      name: '부산중앙교회',
      address: '부산 동구 범일동',
      roadAddress: '부산 동구 중앙대로 396',
    ),
    const KakaoChurchResult(
      id: '46',
      name: '해운대교회',
      address: '부산 해운대구 좌동',
      roadAddress: '부산 해운대구 세실로 67',
    ),
    const KakaoChurchResult(
      id: '47',
      name: '동래교회',
      address: '부산 동래구 수안동',
      roadAddress: '부산 동래구 중앙대로 1407',
    ),
    const KakaoChurchResult(
      id: '48',
      name: '부전교회',
      address: '부산 부산진구 부전동',
      roadAddress: '부산 부산진구 중앙대로 749',
    ),
    const KakaoChurchResult(
      id: '49',
      name: '초량교회',
      address: '부산 동구 초량동',
      roadAddress: '부산 동구 초량중로 45',
    ),
    const KakaoChurchResult(
      id: '50',
      name: '남포교회',
      address: '부산 중구 남포동',
      roadAddress: '부산 중구 광복로 49',
    ),
    // 대구
    const KakaoChurchResult(
      id: '51',
      name: '대구동산교회',
      address: '대구 중구 동산동',
      roadAddress: '대구 중구 달구벌대로 2029',
    ),
    const KakaoChurchResult(
      id: '52',
      name: '대구제일교회',
      address: '대구 중구 남산동',
      roadAddress: '대구 중구 국채보상로 140길 32',
    ),
    const KakaoChurchResult(
      id: '53',
      name: '서문교회',
      address: '대구 달서구 두류동',
      roadAddress: '대구 달서구 달구벌대로 1640',
    ),
    const KakaoChurchResult(
      id: '54',
      name: '수성교회',
      address: '대구 수성구 범어동',
      roadAddress: '대구 수성구 범어로 31',
    ),
    // 대전
    const KakaoChurchResult(
      id: '55',
      name: '대전중앙교회',
      address: '대전 중구 대흥동',
      roadAddress: '대전 중구 보문로 234',
    ),
    const KakaoChurchResult(
      id: '56',
      name: '충남교회',
      address: '대전 서구 둔산동',
      roadAddress: '대전 서구 둔산대로 127번길 43',
    ),
    const KakaoChurchResult(
      id: '57',
      name: '한빛교회',
      address: '대전 유성구 봉명동',
      roadAddress: '대전 유성구 대학로 219',
    ),
    const KakaoChurchResult(
      id: '58',
      name: '새로남교회',
      address: '대전 서구 갈마동',
      roadAddress: '대전 서구 갈마로 50',
    ),
    // 광주
    const KakaoChurchResult(
      id: '59',
      name: '광주제일교회',
      address: '광주 동구 금남로',
      roadAddress: '광주 동구 금남로 234',
    ),
    const KakaoChurchResult(
      id: '60',
      name: '광주중앙교회',
      address: '광주 서구 양동',
      roadAddress: '광주 서구 상무중앙로 66',
    ),
    const KakaoChurchResult(
      id: '61',
      name: '무등교회',
      address: '광주 동구 산수동',
      roadAddress: '광주 동구 서석로 35',
    ),
    // 울산
    const KakaoChurchResult(
      id: '62',
      name: '울산중앙교회',
      address: '울산 남구 달동',
      roadAddress: '울산 남구 삼산로 278',
    ),
    const KakaoChurchResult(
      id: '63',
      name: '울산교회',
      address: '울산 중구 성남동',
      roadAddress: '울산 중구 새즈믄해거리로 23',
    ),
    // 세종/충청
    const KakaoChurchResult(
      id: '64',
      name: '천안중앙교회',
      address: '충남 천안시 동남구',
      roadAddress: '충남 천안시 동남구 중앙로 98',
    ),
    const KakaoChurchResult(
      id: '65',
      name: '청주교회',
      address: '충북 청주시 상당구',
      roadAddress: '충북 청주시 상당구 상당로 92',
    ),
    const KakaoChurchResult(
      id: '66',
      name: '세종교회',
      address: '세종시 조치원읍',
      roadAddress: '세종시 조치원읍 새내로 62',
    ),
    const KakaoChurchResult(
      id: '67',
      name: '충주교회',
      address: '충북 충주시 교현동',
      roadAddress: '충북 충주시 번영대로 43',
    ),
    // 전라도
    const KakaoChurchResult(
      id: '68',
      name: '전주중앙교회',
      address: '전북 전주시 완산구',
      roadAddress: '전북 전주시 완산구 전주객사4길 26',
    ),
    const KakaoChurchResult(
      id: '69',
      name: '군산제일교회',
      address: '전북 군산시 영화동',
      roadAddress: '전북 군산시 구영1길 12',
    ),
    const KakaoChurchResult(
      id: '70',
      name: '목포중앙교회',
      address: '전남 목포시 대성동',
      roadAddress: '전남 목포시 영산로 226',
    ),
    const KakaoChurchResult(
      id: '71',
      name: '순천교회',
      address: '전남 순천시 장천동',
      roadAddress: '전남 순천시 장천로 8',
    ),
    const KakaoChurchResult(
      id: '72',
      name: '여수교회',
      address: '전남 여수시 교동',
      roadAddress: '전남 여수시 좌수영로 1',
    ),
    // 경상도
    const KakaoChurchResult(
      id: '73',
      name: '포항중앙교회',
      address: '경북 포항시 북구',
      roadAddress: '경북 포항시 북구 중앙로 291',
    ),
    const KakaoChurchResult(
      id: '74',
      name: '경주교회',
      address: '경북 경주시 성건동',
      roadAddress: '경북 경주시 태종로 776',
    ),
    const KakaoChurchResult(
      id: '75',
      name: '안동교회',
      address: '경북 안동시 북문동',
      roadAddress: '경북 안동시 경동로 581',
    ),
    const KakaoChurchResult(
      id: '76',
      name: '창원중앙교회',
      address: '경남 창원시 성산구',
      roadAddress: '경남 창원시 성산구 원이대로 451',
    ),
    const KakaoChurchResult(
      id: '77',
      name: '진주교회',
      address: '경남 진주시 본성동',
      roadAddress: '경남 진주시 진주대로 840',
    ),
    const KakaoChurchResult(
      id: '78',
      name: '김해교회',
      address: '경남 김해시 내동',
      roadAddress: '경남 김해시 가야로 75',
    ),
    const KakaoChurchResult(
      id: '79',
      name: '거제교회',
      address: '경남 거제시 고현동',
      roadAddress: '경남 거제시 거제중앙로 1575',
    ),
    const KakaoChurchResult(
      id: '80',
      name: '마산교회',
      address: '경남 창원시 마산합포구',
      roadAddress: '경남 창원시 마산합포구 3.15대로 183',
    ),
    // 강원도
    const KakaoChurchResult(
      id: '81',
      name: '춘천교회',
      address: '강원 춘천시 죽림동',
      roadAddress: '강원 춘천시 중앙로 58',
    ),
    const KakaoChurchResult(
      id: '82',
      name: '원주교회',
      address: '강원 원주시 중앙동',
      roadAddress: '강원 원주시 원일로 95',
    ),
    const KakaoChurchResult(
      id: '83',
      name: '강릉교회',
      address: '강원 강릉시 임당동',
      roadAddress: '강원 강릉시 경강로 2070',
    ),
    const KakaoChurchResult(
      id: '84',
      name: '속초교회',
      address: '강원 속초시 교동',
      roadAddress: '강원 속초시 수복로 150',
    ),
    // 제주도
    const KakaoChurchResult(
      id: '85',
      name: '제주교회',
      address: '제주 제주시 이도동',
      roadAddress: '제주 제주시 중앙로 65',
    ),
    const KakaoChurchResult(
      id: '86',
      name: '서귀포교회',
      address: '제주 서귀포시 서귀동',
      roadAddress: '제주 서귀포시 중앙로 106',
    ),
    // 대형/유명 교회 추가
    const KakaoChurchResult(
      id: '87',
      name: '새벽교회',
      address: '서울 노원구 상계동',
      roadAddress: '서울 노원구 상계로 10길 50',
    ),
    const KakaoChurchResult(
      id: '88',
      name: '풍성한교회',
      address: '서울 송파구 문정동',
      roadAddress: '서울 송파구 법원로 114',
    ),
    const KakaoChurchResult(
      id: '89',
      name: '열린문교회',
      address: '서울 성북구 정릉동',
      roadAddress: '서울 성북구 정릉로 207',
    ),
    const KakaoChurchResult(
      id: '90',
      name: '동안교회',
      address: '경기 안양시 동안구',
      roadAddress: '경기 안양시 동안구 평촌대로 387',
    ),
    const KakaoChurchResult(
      id: '91',
      name: '은혜교회',
      address: '서울 관악구 봉천동',
      roadAddress: '서울 관악구 관악로 230',
    ),
    const KakaoChurchResult(
      id: '92',
      name: '신촌교회',
      address: '서울 서대문구 신촌동',
      roadAddress: '서울 서대문구 연세로 7길 33',
    ),
    const KakaoChurchResult(
      id: '93',
      name: '감리교신학대학교교회',
      address: '서울 서대문구 냉천동',
      roadAddress: '서울 서대문구 냉천로 21',
    ),
    const KakaoChurchResult(
      id: '94',
      name: '강서교회',
      address: '서울 강서구 등촌동',
      roadAddress: '서울 강서구 강서로 160',
    ),
    const KakaoChurchResult(
      id: '95',
      name: '목동교회',
      address: '서울 양천구 목동',
      roadAddress: '서울 양천구 목동서로 215',
    ),
    const KakaoChurchResult(
      id: '96',
      name: '잠실교회',
      address: '서울 송파구 잠실동',
      roadAddress: '서울 송파구 올림픽로 289',
    ),
    const KakaoChurchResult(
      id: '97',
      name: '구리교회',
      address: '경기 구리시 인창동',
      roadAddress: '경기 구리시 건원대로 7',
    ),
    const KakaoChurchResult(
      id: '98',
      name: '산본교회',
      address: '경기 군포시 산본동',
      roadAddress: '경기 군포시 번영로 147',
    ),
    const KakaoChurchResult(
      id: '99',
      name: '시흥교회',
      address: '경기 시흥시 대야동',
      roadAddress: '경기 시흥시 서울대학로 55',
    ),
    const KakaoChurchResult(
      id: '100',
      name: '하남교회',
      address: '경기 하남시 신장동',
      roadAddress: '경기 하남시 대청로 64',
    ),
    // ─── 추가 교회 (101~200) ───
    // 서울 추가
    const KakaoChurchResult(
      id: '101',
      name: '영동제일교회',
      address: '서울 강남구 대치동',
      roadAddress: '서울 강남구 삼성로 51길 7',
    ),
    const KakaoChurchResult(
      id: '102',
      name: '동대문중앙교회',
      address: '서울 동대문구 전농동',
      roadAddress: '서울 동대문구 전농로 36',
    ),
    const KakaoChurchResult(
      id: '103',
      name: '성내교회',
      address: '서울 강동구 성내동',
      roadAddress: '서울 강동구 성내로 25',
    ),
    const KakaoChurchResult(
      id: '104',
      name: '삼성교회',
      address: '서울 강남구 삼성동',
      roadAddress: '서울 강남구 봉은사로 608',
    ),
    const KakaoChurchResult(
      id: '105',
      name: '동작교회',
      address: '서울 동작구 상도동',
      roadAddress: '서울 동작구 상도로 272',
    ),
    const KakaoChurchResult(
      id: '106',
      name: '도봉교회',
      address: '서울 도봉구 도봉동',
      roadAddress: '서울 도봉구 도봉로 164길 11',
    ),
    const KakaoChurchResult(
      id: '107',
      name: '성락교회',
      address: '서울 구로구 오류동',
      roadAddress: '서울 구로구 경인로 20길 28',
    ),
    const KakaoChurchResult(
      id: '108',
      name: '금란교회',
      address: '서울 구로구 구로동',
      roadAddress: '서울 구로구 구로중앙로 288',
    ),
    const KakaoChurchResult(
      id: '109',
      name: '중앙성결교회',
      address: '서울 용산구 한강로',
      roadAddress: '서울 용산구 한강대로 92',
    ),
    const KakaoChurchResult(
      id: '110',
      name: '청파교회',
      address: '서울 용산구 청파동',
      roadAddress: '서울 용산구 백범로 67',
    ),
    const KakaoChurchResult(
      id: '111',
      name: '서초중앙교회',
      address: '서울 서초구 방배동',
      roadAddress: '서울 서초구 방배로 226',
    ),
    const KakaoChurchResult(
      id: '112',
      name: '안암교회',
      address: '서울 성북구 안암동',
      roadAddress: '서울 성북구 고려대로 104',
    ),
    const KakaoChurchResult(
      id: '113',
      name: '미아교회',
      address: '서울 강북구 미아동',
      roadAddress: '서울 강북구 도봉로 148',
    ),
    const KakaoChurchResult(
      id: '114',
      name: '노량진교회',
      address: '서울 동작구 노량진동',
      roadAddress: '서울 동작구 만양로 14길 12',
    ),
    const KakaoChurchResult(
      id: '115',
      name: '대방교회',
      address: '서울 동작구 대방동',
      roadAddress: '서울 동작구 여의대방로 175',
    ),
    // 경기도 추가
    const KakaoChurchResult(
      id: '116',
      name: '분당중앙교회',
      address: '경기 성남시 분당구 서현동',
      roadAddress: '경기 성남시 분당구 분당로 53번길 11',
    ),
    const KakaoChurchResult(
      id: '117',
      name: '판교교회',
      address: '경기 성남시 분당구 판교동',
      roadAddress: '경기 성남시 분당구 판교로 228번길 15',
    ),
    const KakaoChurchResult(
      id: '118',
      name: '수지교회',
      address: '경기 용인시 수지구',
      roadAddress: '경기 용인시 수지구 풍덕천로 120',
    ),
    const KakaoChurchResult(
      id: '119',
      name: '기흥교회',
      address: '경기 용인시 기흥구',
      roadAddress: '경기 용인시 기흥구 구갈로 60',
    ),
    const KakaoChurchResult(
      id: '120',
      name: '광교교회',
      address: '경기 수원시 영통구',
      roadAddress: '경기 수원시 영통구 광교로 145',
    ),
    const KakaoChurchResult(
      id: '121',
      name: '영통교회',
      address: '경기 수원시 영통구',
      roadAddress: '경기 수원시 영통구 영통로 200',
    ),
    const KakaoChurchResult(
      id: '122',
      name: '안산중앙교회',
      address: '경기 안산시 단원구',
      roadAddress: '경기 안산시 단원구 광덕대로 253',
    ),
    const KakaoChurchResult(
      id: '123',
      name: '시화교회',
      address: '경기 시흥시 정왕동',
      roadAddress: '경기 시흥시 서해안로 277',
    ),
    const KakaoChurchResult(
      id: '124',
      name: '오산교회',
      address: '경기 오산시 오산동',
      roadAddress: '경기 오산시 경기대로 130',
    ),
    const KakaoChurchResult(
      id: '125',
      name: '이천교회',
      address: '경기 이천시 중리동',
      roadAddress: '경기 이천시 이섭대천로 1230',
    ),
    const KakaoChurchResult(
      id: '126',
      name: '양주교회',
      address: '경기 양주시 양주동',
      roadAddress: '경기 양주시 부흥로 1522',
    ),
    const KakaoChurchResult(
      id: '127',
      name: '포천교회',
      address: '경기 포천시 신읍동',
      roadAddress: '경기 포천시 중앙로 69',
    ),
    const KakaoChurchResult(
      id: '128',
      name: '하남미사교회',
      address: '경기 하남시 미사동',
      roadAddress: '경기 하남시 미사강변대로 195',
    ),
    const KakaoChurchResult(
      id: '129',
      name: '위례교회',
      address: '경기 성남시 수정구 창곡동',
      roadAddress: '경기 성남시 수정구 위례광장로 20',
    ),
    const KakaoChurchResult(
      id: '130',
      name: '동탄중앙교회',
      address: '경기 화성시 동탄',
      roadAddress: '경기 화성시 동탄반석로 204',
    ),
    // 인천 추가
    const KakaoChurchResult(
      id: '131',
      name: '인천중앙교회',
      address: '인천 남동구 구월동',
      roadAddress: '인천 남동구 인하로 489',
    ),
    const KakaoChurchResult(
      id: '132',
      name: '계양교회',
      address: '인천 계양구 계산동',
      roadAddress: '인천 계양구 계양산로 98',
    ),
    const KakaoChurchResult(
      id: '133',
      name: '청라교회',
      address: '인천 서구 청라동',
      roadAddress: '인천 서구 청라에메랄드로 55',
    ),
    const KakaoChurchResult(
      id: '134',
      name: '검단교회',
      address: '인천 서구 검단동',
      roadAddress: '인천 서구 검단로 549',
    ),
    // 부산 추가
    const KakaoChurchResult(
      id: '135',
      name: '서면교회',
      address: '부산 부산진구 부전동',
      roadAddress: '부산 부산진구 서전로 37',
    ),
    const KakaoChurchResult(
      id: '136',
      name: '사직교회',
      address: '부산 동래구 사직동',
      roadAddress: '부산 동래구 사직북로 31',
    ),
    const KakaoChurchResult(
      id: '137',
      name: '기장교회',
      address: '부산 기장군 기장읍',
      roadAddress: '부산 기장군 기장읍 기장대로 380',
    ),
    const KakaoChurchResult(
      id: '138',
      name: '덕천교회',
      address: '부산 북구 덕천동',
      roadAddress: '부산 북구 금곡대로 232',
    ),
    const KakaoChurchResult(
      id: '139',
      name: '금정교회',
      address: '부산 금정구 부곡동',
      roadAddress: '부산 금정구 금정로 65',
    ),
    const KakaoChurchResult(
      id: '140',
      name: '센텀교회',
      address: '부산 해운대구 우동',
      roadAddress: '부산 해운대구 센텀중앙로 78',
    ),
    // 대구 추가
    const KakaoChurchResult(
      id: '141',
      name: '달서교회',
      address: '대구 달서구 월성동',
      roadAddress: '대구 달서구 달구벌대로 1434',
    ),
    const KakaoChurchResult(
      id: '142',
      name: '남산교회',
      address: '대구 중구 남산동',
      roadAddress: '대구 중구 달구벌대로 2077',
    ),
    const KakaoChurchResult(
      id: '143',
      name: '북대구교회',
      address: '대구 북구 산격동',
      roadAddress: '대구 북구 대학로 15길 14',
    ),
    const KakaoChurchResult(
      id: '144',
      name: '칠곡교회',
      address: '대구 북구 칠곡동',
      roadAddress: '대구 북구 칠곡중앙대로 300',
    ),
    // 대전 추가
    const KakaoChurchResult(
      id: '145',
      name: '둔산교회',
      address: '대전 서구 둔산동',
      roadAddress: '대전 서구 둔산로 31',
    ),
    const KakaoChurchResult(
      id: '146',
      name: '유성교회',
      address: '대전 유성구 장대동',
      roadAddress: '대전 유성구 유성대로 767',
    ),
    const KakaoChurchResult(
      id: '147',
      name: '대덕교회',
      address: '대전 대덕구 오정동',
      roadAddress: '대전 대덕구 한밭대로 1120',
    ),
    // 광주 추가
    const KakaoChurchResult(
      id: '148',
      name: '광주서문교회',
      address: '광주 서구 치평동',
      roadAddress: '광주 서구 상무중앙로 44',
    ),
    const KakaoChurchResult(
      id: '149',
      name: '남광주교회',
      address: '광주 남구 봉선동',
      roadAddress: '광주 남구 봉선로 104',
    ),
    const KakaoChurchResult(
      id: '150',
      name: '하남교회',
      address: '광주 광산구 하남동',
      roadAddress: '광주 광산구 하남대로 300',
    ),
    // 충청도 추가
    const KakaoChurchResult(
      id: '151',
      name: '아산교회',
      address: '충남 아산시 온천동',
      roadAddress: '충남 아산시 온천대로 1467',
    ),
    const KakaoChurchResult(
      id: '152',
      name: '당진교회',
      address: '충남 당진시 읍내동',
      roadAddress: '충남 당진시 당진중앙2로 86',
    ),
    const KakaoChurchResult(
      id: '153',
      name: '서산교회',
      address: '충남 서산시 동문동',
      roadAddress: '충남 서산시 중앙로 11',
    ),
    const KakaoChurchResult(
      id: '154',
      name: '홍성교회',
      address: '충남 홍성군 홍성읍',
      roadAddress: '충남 홍성군 홍성읍 충서로 23',
    ),
    const KakaoChurchResult(
      id: '155',
      name: '제천교회',
      address: '충북 제천시 화산동',
      roadAddress: '충북 제천시 의림대로 220',
    ),
    const KakaoChurchResult(
      id: '156',
      name: '옥천교회',
      address: '충북 옥천군 옥천읍',
      roadAddress: '충북 옥천군 옥천읍 중앙로 40',
    ),
    // 전라도 추가
    const KakaoChurchResult(
      id: '157',
      name: '익산교회',
      address: '전북 익산시 영등동',
      roadAddress: '전북 익산시 익산대로 168',
    ),
    const KakaoChurchResult(
      id: '158',
      name: '남원교회',
      address: '전북 남원시 도통동',
      roadAddress: '전북 남원시 충정로 96',
    ),
    const KakaoChurchResult(
      id: '159',
      name: '정읍교회',
      address: '전북 정읍시 수성동',
      roadAddress: '전북 정읍시 충정로 73',
    ),
    const KakaoChurchResult(
      id: '160',
      name: '광양교회',
      address: '전남 광양시 광양읍',
      roadAddress: '전남 광양시 광양읍 순광로 60',
    ),
    const KakaoChurchResult(
      id: '161',
      name: '나주교회',
      address: '전남 나주시 송월동',
      roadAddress: '전남 나주시 금계로 56',
    ),
    const KakaoChurchResult(
      id: '162',
      name: '해남교회',
      address: '전남 해남군 해남읍',
      roadAddress: '전남 해남군 해남읍 중앙2로 35',
    ),
    // 경상도 추가
    const KakaoChurchResult(
      id: '163',
      name: '구미교회',
      address: '경북 구미시 원평동',
      roadAddress: '경북 구미시 송원동로 12',
    ),
    const KakaoChurchResult(
      id: '164',
      name: '김천교회',
      address: '경북 김천시 남산동',
      roadAddress: '경북 김천시 자산로 52',
    ),
    const KakaoChurchResult(
      id: '165',
      name: '영주교회',
      address: '경북 영주시 영주동',
      roadAddress: '경북 영주시 광복로 76',
    ),
    const KakaoChurchResult(
      id: '166',
      name: '상주교회',
      address: '경북 상주시 남성동',
      roadAddress: '경북 상주시 왕산로 226',
    ),
    const KakaoChurchResult(
      id: '167',
      name: '통영교회',
      address: '경남 통영시 무전동',
      roadAddress: '경남 통영시 중앙로 257',
    ),
    const KakaoChurchResult(
      id: '168',
      name: '사천교회',
      address: '경남 사천시 동금동',
      roadAddress: '경남 사천시 사천읍 충무공로 27',
    ),
    const KakaoChurchResult(
      id: '169',
      name: '양산교회',
      address: '경남 양산시 중부동',
      roadAddress: '경남 양산시 중부로 10',
    ),
    const KakaoChurchResult(
      id: '170',
      name: '밀양교회',
      address: '경남 밀양시 내일동',
      roadAddress: '경남 밀양시 중앙로 299',
    ),
    // 강원도 추가
    const KakaoChurchResult(
      id: '171',
      name: '동해교회',
      address: '강원 동해시 천곡동',
      roadAddress: '강원 동해시 천곡로 50',
    ),
    const KakaoChurchResult(
      id: '172',
      name: '삼척교회',
      address: '강원 삼척시 남양동',
      roadAddress: '강원 삼척시 중앙로 2',
    ),
    const KakaoChurchResult(
      id: '173',
      name: '태백교회',
      address: '강원 태백시 황지동',
      roadAddress: '강원 태백시 태백로 84',
    ),
    const KakaoChurchResult(
      id: '174',
      name: '횡성교회',
      address: '강원 횡성군 횡성읍',
      roadAddress: '강원 횡성군 횡성읍 태기로 16',
    ),
    const KakaoChurchResult(
      id: '175',
      name: '양양교회',
      address: '강원 양양군 양양읍',
      roadAddress: '강원 양양군 양양읍 남문로 44',
    ),
    // 유명 대형교회 추가
    const KakaoChurchResult(
      id: '176',
      name: '우리들교회',
      address: '서울 강남구 역삼동',
      roadAddress: '서울 강남구 테헤란로 325',
    ),
    const KakaoChurchResult(
      id: '177',
      name: '높은뜻숭의교회',
      address: '서울 강남구 일원동',
      roadAddress: '서울 강남구 일원로 21',
    ),
    const KakaoChurchResult(
      id: '178',
      name: '높은뜻하나교회',
      address: '경기 용인시 수지구',
      roadAddress: '경기 용인시 수지구 동천로 535',
    ),
    const KakaoChurchResult(
      id: '179',
      name: '두레교회',
      address: '경기 성남시 중원구',
      roadAddress: '경기 성남시 중원구 둔촌대로 484',
    ),
    const KakaoChurchResult(
      id: '180',
      name: '갈보리교회',
      address: '서울 중구 충무로',
      roadAddress: '서울 중구 퇴계로 200',
    ),
    const KakaoChurchResult(
      id: '181',
      name: '동산교회',
      address: '서울 성동구 옥수동',
      roadAddress: '서울 성동구 독서당로 85',
    ),
    const KakaoChurchResult(
      id: '182',
      name: '대한교회',
      address: '서울 서초구 양재동',
      roadAddress: '서울 서초구 바우뫼로 27',
    ),
    const KakaoChurchResult(
      id: '183',
      name: '성민교회',
      address: '서울 구로구 고척동',
      roadAddress: '서울 구로구 경서로 3',
    ),
    const KakaoChurchResult(
      id: '184',
      name: '향상교회',
      address: '서울 송파구 석촌동',
      roadAddress: '서울 송파구 백제고분로 45길 14',
    ),
    const KakaoChurchResult(
      id: '185',
      name: '새빛교회',
      address: '서울 노원구 공릉동',
      roadAddress: '서울 노원구 공릉로 232',
    ),
    const KakaoChurchResult(
      id: '186',
      name: '수원제일교회',
      address: '경기 수원시 장안구',
      roadAddress: '경기 수원시 장안구 정조로 883',
    ),
    const KakaoChurchResult(
      id: '187',
      name: '번동교회',
      address: '서울 강북구 번동',
      roadAddress: '서울 강북구 한천로 140길 5',
    ),
    const KakaoChurchResult(
      id: '188',
      name: '거룩한빛교회',
      address: '서울 강남구 수서동',
      roadAddress: '서울 강남구 광평로 280',
    ),
    const KakaoChurchResult(
      id: '189',
      name: '세움교회',
      address: '서울 마포구 서교동',
      roadAddress: '서울 마포구 와우산로 94',
    ),
    const KakaoChurchResult(
      id: '190',
      name: '한성교회',
      address: '서울 종로구 명륜동',
      roadAddress: '서울 종로구 성균관로 26',
    ),
    const KakaoChurchResult(
      id: '191',
      name: '백석교회',
      address: '경기 고양시 일산동구 백석동',
      roadAddress: '경기 고양시 일산동구 중앙로 1036',
    ),
    const KakaoChurchResult(
      id: '192',
      name: '세계로교회',
      address: '경기 부천시 원미구 중동',
      roadAddress: '경기 부천시 원미구 길주로 1',
    ),
    const KakaoChurchResult(
      id: '193',
      name: '산성교회',
      address: '경기 성남시 수정구 신흥동',
      roadAddress: '경기 성남시 수정구 수정로 171',
    ),
    const KakaoChurchResult(
      id: '194',
      name: '남양주중앙교회',
      address: '경기 남양주시 다산동',
      roadAddress: '경기 남양주시 다산중앙로 82',
    ),
    const KakaoChurchResult(
      id: '195',
      name: '세교교회',
      address: '경기 화성시 세교동',
      roadAddress: '경기 화성시 세교중앙로 50',
    ),
    const KakaoChurchResult(
      id: '196',
      name: '광명중앙교회',
      address: '경기 광명시 철산동',
      roadAddress: '경기 광명시 철산로 22',
    ),
    const KakaoChurchResult(
      id: '197',
      name: '소사교회',
      address: '경기 부천시 소사구',
      roadAddress: '경기 부천시 소사구 경인로 170',
    ),
    const KakaoChurchResult(
      id: '198',
      name: '덕소교회',
      address: '경기 남양주시 와부읍',
      roadAddress: '경기 남양주시 와부읍 덕소로 85',
    ),
    const KakaoChurchResult(
      id: '199',
      name: '세마교회',
      address: '경기 오산시 세마동',
      roadAddress: '경기 오산시 세마역로 20',
    ),
    const KakaoChurchResult(
      id: '200',
      name: '조안교회',
      address: '경기 남양주시 조안면',
      roadAddress: '경기 남양주시 조안면 다산로 541',
    ),
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
