import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// 달란트 아이콘 (금화 모양 + "달" 글자)
///
/// 성경의 '달란트'를 본딴 금화 아이콘. 앱 전역에서 달란트(신앙 포인트) 표시에 사용됩니다.
/// - 라디얼 그라데이션 금빛 원형
/// - 중앙에 "달" 글자 (크기가 작으면 자동으로 점으로 대체)
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
    final base = color ?? AppColors.gold;
    // 어두운 톤: 기본 goldDark, 커스텀 컬러일 경우 15% 어둡게
    final rim = color != null
        ? HSLColor.fromColor(color!).withLightness(
            (HSLColor.fromColor(color!).lightness - 0.15).clamp(0.0, 1.0),
          ).toColor()
        : AppColors.goldDark;

    // 크기에 따라 글자/점 결정 (작은 사이즈에서는 글자가 뭉개지므로 점 사용)
    final showGlyph = size >= 14;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: const Alignment(-0.25, -0.3),
          radius: 0.9,
          colors: [
            Color.lerp(base, Colors.white, 0.4)!,
            base,
            rim,
          ],
          stops: const [0.0, 0.55, 1.0],
        ),
        border: Border.all(
          color: rim,
          width: size * 0.06,
        ),
      ),
      alignment: Alignment.center,
      child: showGlyph
          ? Text(
              '달',
              style: TextStyle(
                fontSize: size * 0.58,
                fontWeight: FontWeight.w900,
                color: Colors.white.withValues(alpha: 0.95),
                height: 1.0,
                letterSpacing: -0.3,
              ),
            )
          : Container(
              width: size * 0.32,
              height: size * 0.32,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                shape: BoxShape.circle,
              ),
            ),
    );
  }
}

/// 달란트 단위 라벨 (앱 전역에서 통일된 단위명)
const String kTalentLabel = '달란트';
