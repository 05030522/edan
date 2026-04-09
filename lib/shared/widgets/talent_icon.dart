import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 달란트 아이콘 (FP 대체용 금화 모양)
///
/// 성경의 '달란트'를 본딴 금화 아이콘. 앱 전역에서 포인트 표시에 사용됩니다.
/// Material Icons `Icons.monetization_on`(금화+달러)을 기반으로,
/// 중앙에 작은 십자 마크를 겹쳐 달란트(신앙 포인트) 느낌을 줍니다.
class TalentIcon extends StatelessWidget {
  const TalentIcon({
    super.key,
    this.size = 18,
    this.color,
  });

  /// 아이콘 크기 (px)
  final double size;

  /// 아이콘 색상 (기본: AppColors.gold)
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.gold;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 금화 베이스
          Icon(Icons.monetization_on, color: c, size: size),
          // 중앙 십자가 (달란트의 신앙적 상징)
          Icon(
            Icons.add,
            color: Colors.white.withValues(alpha: 0.95),
            size: size * 0.55,
          ),
        ],
      ),
    );
  }
}

/// 달란트 단위 라벨 (앱 전역에서 "FP" 대신 사용)
const String kTalentLabel = '달란트';
