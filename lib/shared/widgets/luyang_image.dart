import 'package:flutter/material.dart';

/// 루양 캐릭터 이미지 위젯.
///
/// 에셋 이미지(`assets/images/루양.png`)를 원형 또는 사각형으로 표시하며,
/// 흰 배경을 자연스럽게 처리한다. 선택적으로 바운스 애니메이션을 지원한다.
class LuyangImage extends StatefulWidget {
  const LuyangImage({
    super.key,
    this.size = 80,
    this.circular = true,
    this.animate = false,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.shadow = true,
  });

  /// 위젯의 너비 & 높이.
  final double size;

  /// true이면 원형 클리핑, false이면 둥근 사각형.
  final bool circular;

  /// 살짝 위아래로 떠다니는 바운스 애니메이션.
  final bool animate;

  /// 배경색. null이면 자동으로 에덴 그린 연한 색.
  final Color? backgroundColor;

  /// 테두리 색.
  final Color? borderColor;

  /// 테두리 두께.
  final double borderWidth;

  /// 그림자 표시 여부.
  final bool shadow;

  @override
  State<LuyangImage> createState() => _LuyangImageState();
}

class _LuyangImageState extends State<LuyangImage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _bounceAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500),
      )..repeat(reverse: true);
      _bounceAnimation = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget image = _buildImage(context);

    if (widget.animate && _bounceAnimation != null) {
      image = AnimatedBuilder(
        animation: _bounceAnimation!,
        builder: (context, child) {
          final offset = _bounceAnimation!.value * -6.0;
          return Transform.translate(offset: Offset(0, offset), child: child);
        },
        child: image,
      );
    }

    return image;
  }

  Widget _buildImage(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor =
        widget.backgroundColor ??
        (isDark
            ? const Color(0xFF2A3A2E) // 다크 모드: 어두운 에덴 그린
            : const Color(0xFFF5F0E6)); // 라이트 모드: 따뜻한 크림색 (루양 배경과 자연스러움)

    final decoration = BoxDecoration(
      color: bgColor,
      shape: widget.circular ? BoxShape.circle : BoxShape.rectangle,
      borderRadius: widget.circular
          ? null
          : BorderRadius.circular(widget.size * 0.2),
      border: widget.borderWidth > 0 && widget.borderColor != null
          ? Border.all(color: widget.borderColor!, width: widget.borderWidth)
          : null,
      boxShadow: widget.shadow
          ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ]
          : null,
    );

    return Container(
      width: widget.size,
      height: widget.size,
      decoration: decoration,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: EdgeInsets.all(widget.size * 0.06),
        child: Image.asset(
          'assets/images/루양.png',
          fit: BoxFit.contain,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}
