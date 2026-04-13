import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 달란트 아이콘 (금화/동전 모양)
///
/// 성경의 '달란트'를 본딴 금화 아이콘. 앱 전역에서 달란트(신앙 포인트) 표시에 사용됩니다.
/// - 라디얼 그라데이션으로 금속 광택
/// - 바깥 테두리(rim) + 안쪽 원(각인선)으로 "동전 얼굴" 느낌
/// - 글자/기호 없이 모든 크기에서 일관된 금화 형태
class TalentIcon extends StatelessWidget {
  const TalentIcon({super.key, this.size = 18, this.color});

  /// 아이콘 크기 (px)
  final double size;

  /// 아이콘 색상 (기본: AppColors.gold)
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final base = color ?? AppColors.gold;
    // 어두운 톤: 기본 goldDark, 커스텀 컬러일 경우 15% 어둡게
    final rim = color != null
        ? HSLColor.fromColor(color!)
              .withLightness(
                (HSLColor.fromColor(color!).lightness - 0.18).clamp(0.0, 1.0),
              )
              .toColor()
        : AppColors.goldDark;
    final highlight = Color.lerp(base, Colors.white, 0.55)!;

    // 바깥 테두리 두께 (크기에 비례)
    final rimWidth = (size * 0.09).clamp(0.8, 2.2);
    // 안쪽 각인 원 크기
    final innerSize = size * 0.58;
    // 안쪽 각인 테두리 두께
    final innerBorder = (size * 0.045).clamp(0.5, 1.2);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // 금속 광택: 좌상단에서 빛이 들어오는 라디얼 그라데이션
        gradient: RadialGradient(
          center: const Alignment(-0.35, -0.4),
          radius: 1.0,
          colors: [highlight, base, rim],
          stops: const [0.0, 0.55, 1.0],
        ),
        // 바깥 테두리 (코인 림)
        border: Border.all(color: rim, width: rimWidth),
      ),
      child: Center(
        // 안쪽 각인 원 (동전 얼굴의 테두리 느낌)
        child: Container(
          width: innerSize,
          height: innerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: rim.withValues(alpha: 0.55),
              width: innerBorder,
            ),
          ),
        ),
      ),
    );
  }
}

/// 달란트 단위 라벨 (앱 전역에서 통일된 단위명)
const String kTalentLabel = '달란트';
