import 'package:flutter/material.dart';

/// 문자열 아이콘 이름을 IconData로 변환
///
/// 업적/퀘스트 데이터에서 iconName 문자열로 아이콘을 참조할 때 사용
IconData iconFromName(String name) {
  const map = <String, IconData>{
    'menu_book': Icons.menu_book,
    'volunteer_activism': Icons.volunteer_activism,
    'auto_stories': Icons.auto_stories,
    'local_fire_department': Icons.local_fire_department,
    'emoji_events': Icons.emoji_events,
    'spa': Icons.spa,
    'nature': Icons.nature,
    'eco': Icons.eco,
    'auto_awesome': Icons.auto_awesome,
    'monetization_on': Icons.monetization_on,
  };
  return map[name] ?? Icons.star;
}
