import 'dart:math';

import 'package:flutter/material.dart';

/// Available Lamby expressions.
enum LambyExpression {
  happy,
  thinking,
  excited,
  sleeping,
  cheering,
  sad,
  praying,
  surprised,
  gardening,
  reading,
}

/// A cute lamb character rendered with [CustomPaint].
///
/// Supports 10 distinct [LambyExpression]s and an optional bouncing animation.
/// The character has a cream-colored body, pink ears/cheeks, and sparkly eyes.
class LambyWidget extends StatefulWidget {
  const LambyWidget({
    super.key,
    this.expression = LambyExpression.happy,
    this.size = 120,
    this.animate = true,
  });

  /// Current facial expression / pose.
  final LambyExpression expression;

  /// Overall size of the character (width & height).
  final double size;

  /// Whether to play the idle bouncing animation.
  final bool animate;

  @override
  State<LambyWidget> createState() => _LambyWidgetState();
}

class _LambyWidgetState extends State<LambyWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _bounceAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );

    if (widget.animate) {
      _bounceController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(LambyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate && !_bounceController.isAnimating) {
      _bounceController.repeat(reverse: true);
    } else if (!widget.animate && _bounceController.isAnimating) {
      _bounceController.stop();
      _bounceController.value = 0;
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounceAnimation,
      builder: (context, child) {
        final double bounceOffset =
            sin(_bounceAnimation.value * pi) * (widget.size * 0.04);
        return Transform.translate(
          offset: Offset(0, -bounceOffset),
          child: child,
        );
      },
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _LambyPainter(expression: widget.expression),
      ),
    );
  }
}

// ─── Painter ───

class _LambyPainter extends CustomPainter {
  const _LambyPainter({required this.expression});

  final LambyExpression expression;

  // Palette
  static const Color _cream = Color(0xFFFFF8E7);
  static const Color _creamShadow = Color(0xFFF5E6C8);
  static const Color _pink = Color(0xFFFFB6C1);
  static const Color _darkPink = Color(0xFFFF8FAA);
  static const Color _eyeColor = Color(0xFF2D2A3A);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _gold = Color(0xFFE5C88E);

  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width;
    final double cx = s / 2;
    final double cy = s / 2;

    _drawEars(canvas, s, cx, cy);
    _drawBody(canvas, s, cx, cy);
    _drawFace(canvas, s, cx, cy);
    _drawCheeks(canvas, s, cx, cy);
    _drawExpression(canvas, s, cx, cy);
    _drawExpressionAccessories(canvas, s, cx, cy);
  }

  // ─── Body ───

  void _drawBody(Canvas canvas, double s, double cx, double cy) {
    // Woolly body (overlapping circles)
    final Paint woolPaint = Paint()..color = _cream;
    final Paint woolShadow = Paint()..color = _creamShadow;

    final double bodyR = s * 0.32;
    final Offset bodyCenter = Offset(cx, cy + s * 0.08);

    // Shadow layer
    canvas.drawCircle(
      bodyCenter + Offset(0, s * 0.02),
      bodyR,
      woolShadow,
    );

    // Main body
    canvas.drawCircle(bodyCenter, bodyR, woolPaint);

    // Wool tufts around the body
    final double tuftR = s * 0.12;
    for (int i = 0; i < 7; i++) {
      final double angle = (i / 7) * 2 * pi - pi / 2;
      final Offset tuftPos = Offset(
        bodyCenter.dx + cos(angle) * bodyR * 0.75,
        bodyCenter.dy + sin(angle) * bodyR * 0.75,
      );
      canvas.drawCircle(tuftPos, tuftR, woolPaint);
    }

    // Head
    final double headR = s * 0.24;
    final Offset headCenter = Offset(cx, cy - s * 0.08);
    canvas.drawCircle(headCenter, headR, woolPaint);

    // Head wool tufts (top)
    for (int i = 0; i < 5; i++) {
      final double angle = -pi + (i / 4) * pi;
      final Offset tuftPos = Offset(
        headCenter.dx + cos(angle) * headR * 0.7,
        headCenter.dy + sin(angle) * headR * 0.6,
      );
      canvas.drawCircle(tuftPos, s * 0.08, woolPaint);
    }

    // Little feet
    final Paint feetPaint = Paint()..color = _creamShadow;
    final double footR = s * 0.06;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - s * 0.12, cy + s * 0.38),
        width: footR * 2,
        height: footR * 1.4,
      ),
      feetPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx + s * 0.12, cy + s * 0.38),
        width: footR * 2,
        height: footR * 1.4,
      ),
      feetPaint,
    );
  }

  // ─── Ears ───

  void _drawEars(Canvas canvas, double s, double cx, double cy) {
    final Paint earOuter = Paint()..color = _cream;
    final Paint earInner = Paint()..color = _pink;

    // Left ear
    _drawEar(
      canvas,
      center: Offset(cx - s * 0.22, cy - s * 0.22),
      angle: -0.4,
      s: s,
      outerPaint: earOuter,
      innerPaint: earInner,
    );
    // Right ear
    _drawEar(
      canvas,
      center: Offset(cx + s * 0.22, cy - s * 0.22),
      angle: 0.4,
      s: s,
      outerPaint: earOuter,
      innerPaint: earInner,
    );
  }

  void _drawEar(
    Canvas canvas, {
    required Offset center,
    required double angle,
    required double s,
    required Paint outerPaint,
    required Paint innerPaint,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle);

    // Outer ear
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset.zero,
        width: s * 0.13,
        height: s * 0.20,
      ),
      outerPaint,
    );
    // Inner ear (pink)
    canvas.drawOval(
      Rect.fromCenter(
        center: const Offset(0, 2),
        width: s * 0.08,
        height: s * 0.13,
      ),
      innerPaint,
    );

    canvas.restore();
  }

  // ─── Face (eyes, nose, mouth) ───

  void _drawFace(Canvas canvas, double s, double cx, double cy) {
    final Offset headCenter = Offset(cx, cy - s * 0.08);

    switch (expression) {
      case LambyExpression.sleeping:
        _drawSleepingEyes(canvas, s, headCenter);
        break;
      case LambyExpression.sad:
        _drawSadEyes(canvas, s, headCenter);
        break;
      case LambyExpression.surprised:
        _drawSurprisedEyes(canvas, s, headCenter);
        break;
      default:
        _drawNormalEyes(canvas, s, headCenter);
        break;
    }

    _drawNose(canvas, s, headCenter);
    _drawMouth(canvas, s, headCenter);
  }

  void _drawNormalEyes(Canvas canvas, double s, Offset head) {
    final Paint eyePaint = Paint()..color = _eyeColor;
    final Paint sparklePaint = Paint()..color = _white;

    final double eyeR = s * 0.032;
    final double eyeY = head.dy - s * 0.01;

    // Left eye
    final Offset leftEye = Offset(head.dx - s * 0.08, eyeY);
    canvas.drawCircle(leftEye, eyeR, eyePaint);
    canvas.drawCircle(leftEye + Offset(-eyeR * 0.3, -eyeR * 0.3),
        eyeR * 0.4, sparklePaint);

    // Right eye
    final Offset rightEye = Offset(head.dx + s * 0.08, eyeY);
    canvas.drawCircle(rightEye, eyeR, eyePaint);
    canvas.drawCircle(rightEye + Offset(-eyeR * 0.3, -eyeR * 0.3),
        eyeR * 0.4, sparklePaint);

    // Extra sparkle for excited expression
    if (expression == LambyExpression.excited ||
        expression == LambyExpression.cheering) {
      final Paint starPaint = Paint()..color = _gold;
      canvas.drawCircle(
          leftEye + Offset(eyeR * 0.4, -eyeR * 0.5), eyeR * 0.25, starPaint);
      canvas.drawCircle(rightEye + Offset(eyeR * 0.4, -eyeR * 0.5),
          eyeR * 0.25, starPaint);
    }
  }

  void _drawSleepingEyes(Canvas canvas, double s, Offset head) {
    final Paint linePaint = Paint()
      ..color = _eyeColor
      ..strokeWidth = s * 0.02
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double eyeY = head.dy - s * 0.01;
    final double halfW = s * 0.04;

    // Left closed eye (arc)
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(head.dx - s * 0.08, eyeY),
        width: halfW * 2,
        height: halfW,
      ),
      0,
      pi,
      false,
      linePaint,
    );

    // Right closed eye (arc)
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(head.dx + s * 0.08, eyeY),
        width: halfW * 2,
        height: halfW,
      ),
      0,
      pi,
      false,
      linePaint,
    );
  }

  void _drawSadEyes(Canvas canvas, double s, Offset head) {
    final Paint eyePaint = Paint()..color = _eyeColor;
    final Paint sparklePaint = Paint()..color = _white;

    final double eyeR = s * 0.03;
    final double eyeY = head.dy;

    // Slightly upward-looking sad eyes
    final Offset leftEye = Offset(head.dx - s * 0.08, eyeY);
    canvas.drawCircle(leftEye, eyeR, eyePaint);
    canvas.drawCircle(
        leftEye + Offset(-eyeR * 0.3, -eyeR * 0.3), eyeR * 0.35,
        sparklePaint);

    final Offset rightEye = Offset(head.dx + s * 0.08, eyeY);
    canvas.drawCircle(rightEye, eyeR, eyePaint);
    canvas.drawCircle(
        rightEye + Offset(-eyeR * 0.3, -eyeR * 0.3), eyeR * 0.35,
        sparklePaint);

    // Sad eyebrows (angled inward-up)
    final Paint browPaint = Paint()
      ..color = _eyeColor.withValues(alpha: 0.5)
      ..strokeWidth = s * 0.012
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(leftEye.dx - s * 0.04, eyeY - s * 0.05),
      Offset(leftEye.dx + s * 0.03, eyeY - s * 0.035),
      browPaint,
    );
    canvas.drawLine(
      Offset(rightEye.dx + s * 0.04, eyeY - s * 0.05),
      Offset(rightEye.dx - s * 0.03, eyeY - s * 0.035),
      browPaint,
    );
  }

  void _drawSurprisedEyes(Canvas canvas, double s, Offset head) {
    final Paint eyePaint = Paint()..color = _eyeColor;
    final Paint sparklePaint = Paint()..color = _white;

    // Larger round eyes for surprise
    final double eyeR = s * 0.042;
    final double eyeY = head.dy - s * 0.01;

    final Offset leftEye = Offset(head.dx - s * 0.09, eyeY);
    canvas.drawCircle(leftEye, eyeR, eyePaint);
    canvas.drawCircle(
        leftEye + Offset(-eyeR * 0.25, -eyeR * 0.25), eyeR * 0.4,
        sparklePaint);

    final Offset rightEye = Offset(head.dx + s * 0.09, eyeY);
    canvas.drawCircle(rightEye, eyeR, eyePaint);
    canvas.drawCircle(
        rightEye + Offset(-eyeR * 0.25, -eyeR * 0.25), eyeR * 0.4,
        sparklePaint);
  }

  void _drawNose(Canvas canvas, double s, Offset head) {
    final Paint nosePaint = Paint()..color = _darkPink;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(head.dx, head.dy + s * 0.04),
        width: s * 0.04,
        height: s * 0.025,
      ),
      nosePaint,
    );
  }

  void _drawMouth(Canvas canvas, double s, Offset head) {
    final Paint mouthPaint = Paint()
      ..color = _eyeColor.withValues(alpha: 0.6)
      ..strokeWidth = s * 0.012
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final double mouthY = head.dy + s * 0.07;

    switch (expression) {
      case LambyExpression.happy:
      case LambyExpression.excited:
      case LambyExpression.cheering:
      case LambyExpression.gardening:
      case LambyExpression.reading:
        // Smile
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(head.dx, mouthY),
            width: s * 0.08,
            height: s * 0.04,
          ),
          0,
          pi,
          false,
          mouthPaint,
        );
        break;
      case LambyExpression.thinking:
        // Small "o" mouth
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(head.dx + s * 0.02, mouthY),
            width: s * 0.03,
            height: s * 0.025,
          ),
          mouthPaint,
        );
        break;
      case LambyExpression.sleeping:
        // Gentle closed mouth
        canvas.drawLine(
          Offset(head.dx - s * 0.03, mouthY),
          Offset(head.dx + s * 0.03, mouthY),
          mouthPaint,
        );
        break;
      case LambyExpression.sad:
        // Frown
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(head.dx, mouthY + s * 0.02),
            width: s * 0.06,
            height: s * 0.04,
          ),
          pi,
          pi,
          false,
          mouthPaint,
        );
        break;
      case LambyExpression.praying:
        // Serene slight smile
        canvas.drawArc(
          Rect.fromCenter(
            center: Offset(head.dx, mouthY),
            width: s * 0.05,
            height: s * 0.02,
          ),
          0,
          pi,
          false,
          mouthPaint,
        );
        break;
      case LambyExpression.surprised:
        // Open "O" mouth
        final Paint fillMouth = Paint()..color = _darkPink.withValues(alpha: 0.3);
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(head.dx, mouthY),
            width: s * 0.05,
            height: s * 0.05,
          ),
          fillMouth,
        );
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset(head.dx, mouthY),
            width: s * 0.05,
            height: s * 0.05,
          ),
          mouthPaint,
        );
        break;
    }
  }

  // ─── Cheeks ───

  void _drawCheeks(Canvas canvas, double s, double cx, double cy) {
    final Offset head = Offset(cx, cy - s * 0.08);
    final Paint blush = Paint()..color = _pink.withValues(alpha: 0.45);
    final double cheekR = s * 0.04;

    canvas.drawCircle(
        Offset(head.dx - s * 0.14, head.dy + s * 0.04), cheekR, blush);
    canvas.drawCircle(
        Offset(head.dx + s * 0.14, head.dy + s * 0.04), cheekR, blush);
  }

  // ─── Expression specific accessories ───

  void _drawExpression(Canvas canvas, double s, double cx, double cy) {
    // Intentionally empty -- split into _drawExpressionAccessories.
  }

  void _drawExpressionAccessories(
      Canvas canvas, double s, double cx, double cy) {
    switch (expression) {
      case LambyExpression.thinking:
        _drawThinkingBubble(canvas, s, cx, cy);
        break;
      case LambyExpression.sleeping:
        _drawZzz(canvas, s, cx, cy);
        break;
      case LambyExpression.cheering:
        _drawConfetti(canvas, s, cx, cy);
        break;
      case LambyExpression.sad:
        _drawTear(canvas, s, cx, cy);
        break;
      case LambyExpression.praying:
        _drawPrayerHands(canvas, s, cx, cy);
        break;
      case LambyExpression.surprised:
        _drawExclamation(canvas, s, cx, cy);
        break;
      case LambyExpression.gardening:
        _drawFlower(canvas, s, cx, cy);
        break;
      case LambyExpression.reading:
        _drawBook(canvas, s, cx, cy);
        break;
      case LambyExpression.excited:
        _drawSparkles(canvas, s, cx, cy);
        break;
      case LambyExpression.happy:
        // Default happy -- no extra accessories.
        break;
    }
  }

  // ── Thinking: question mark bubble ──

  void _drawThinkingBubble(Canvas canvas, double s, double cx, double cy) {
    final Paint bubblePaint = Paint()..color = _white.withValues(alpha: 0.9);
    final Paint textPaint = Paint()
      ..color = _eyeColor
      ..strokeWidth = s * 0.018
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Small thought dots
    canvas.drawCircle(
        Offset(cx + s * 0.18, cy - s * 0.2), s * 0.02, bubblePaint);
    canvas.drawCircle(
        Offset(cx + s * 0.24, cy - s * 0.28), s * 0.03, bubblePaint);

    // Main thought bubble
    canvas.drawCircle(
        Offset(cx + s * 0.32, cy - s * 0.38), s * 0.08, bubblePaint);

    // Question mark
    final Offset qCenter = Offset(cx + s * 0.32, cy - s * 0.40);
    final Path qPath = Path()
      ..moveTo(qCenter.dx - s * 0.02, qCenter.dy - s * 0.02)
      ..quadraticBezierTo(
        qCenter.dx - s * 0.02,
        qCenter.dy - s * 0.05,
        qCenter.dx,
        qCenter.dy - s * 0.05,
      )
      ..quadraticBezierTo(
        qCenter.dx + s * 0.025,
        qCenter.dy - s * 0.05,
        qCenter.dx + s * 0.025,
        qCenter.dy - s * 0.03,
      )
      ..quadraticBezierTo(
        qCenter.dx + s * 0.025,
        qCenter.dy - s * 0.01,
        qCenter.dx,
        qCenter.dy,
      );
    canvas.drawPath(qPath, textPaint);

    // Dot of question mark
    canvas.drawCircle(
      Offset(qCenter.dx, qCenter.dy + s * 0.025),
      s * 0.008,
      Paint()..color = _eyeColor,
    );
  }

  // ── Sleeping: ZZZ ──

  void _drawZzz(Canvas canvas, double s, double cx, double cy) {
    final Paint zPaint = Paint()
      ..color = _eyeColor.withValues(alpha: 0.4)
      ..strokeWidth = s * 0.015
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    void drawZ(Offset origin, double zSize) {
      canvas.drawLine(
          origin, origin + Offset(zSize, 0), zPaint);
      canvas.drawLine(
          origin + Offset(zSize, 0), origin + Offset(0, zSize), zPaint);
      canvas.drawLine(
          origin + Offset(0, zSize), origin + Offset(zSize, zSize), zPaint);
    }

    drawZ(Offset(cx + s * 0.2, cy - s * 0.28), s * 0.06);
    drawZ(Offset(cx + s * 0.28, cy - s * 0.38), s * 0.08);
    drawZ(Offset(cx + s * 0.35, cy - s * 0.50), s * 0.1);
  }

  // ── Cheering: confetti sparkles ──

  void _drawConfetti(Canvas canvas, double s, double cx, double cy) {
    final List<Color> colors = [_pink, _gold, const Color(0xFF90CAF9), const Color(0xFFCE93D8)];
    final Random rng = Random(42); // Deterministic for consistent painting.

    for (int i = 0; i < 12; i++) {
      final double angle = (i / 12) * 2 * pi;
      final double dist = s * 0.42 + rng.nextDouble() * s * 0.1;
      final Offset pos = Offset(
        cx + cos(angle) * dist,
        cy + sin(angle) * dist - s * 0.1,
      );
      final Paint p = Paint()..color = colors[i % colors.length];
      if (i % 3 == 0) {
        // Star-shaped dot
        canvas.drawCircle(pos, s * 0.02, p);
      } else {
        // Small rectangle confetti
        canvas.save();
        canvas.translate(pos.dx, pos.dy);
        canvas.rotate(angle);
        canvas.drawRect(
          Rect.fromCenter(
              center: Offset.zero, width: s * 0.025, height: s * 0.012),
          p,
        );
        canvas.restore();
      }
    }
  }

  // ── Sad: tear drop ──

  void _drawTear(Canvas canvas, double s, double cx, double cy) {
    final Offset head = Offset(cx, cy - s * 0.08);
    final Paint tearPaint = Paint()..color = const Color(0x9090CAF9);

    // Left tear
    final Offset tearStart = Offset(head.dx - s * 0.08, head.dy + s * 0.02);
    final Path tearPath = Path()
      ..moveTo(tearStart.dx, tearStart.dy)
      ..quadraticBezierTo(
        tearStart.dx - s * 0.015,
        tearStart.dy + s * 0.05,
        tearStart.dx,
        tearStart.dy + s * 0.06,
      )
      ..quadraticBezierTo(
        tearStart.dx + s * 0.015,
        tearStart.dy + s * 0.05,
        tearStart.dx,
        tearStart.dy,
      );
    canvas.drawPath(tearPath, tearPaint);
  }

  // ── Praying: folded hands ──

  void _drawPrayerHands(Canvas canvas, double s, double cx, double cy) {
    final Paint handPaint = Paint()..color = _creamShadow;
    final Paint linePaint = Paint()
      ..color = _eyeColor.withValues(alpha: 0.3)
      ..strokeWidth = s * 0.01
      ..style = PaintingStyle.stroke;

    final Offset handCenter = Offset(cx, cy + s * 0.24);

    // Two overlapping ovals forming praying hands
    canvas.save();
    canvas.translate(handCenter.dx, handCenter.dy);

    // Left hand
    canvas.save();
    canvas.rotate(-0.15);
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(-s * 0.02, 0), width: s * 0.08, height: s * 0.14),
      handPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(-s * 0.02, 0), width: s * 0.08, height: s * 0.14),
      linePaint,
    );
    canvas.restore();

    // Right hand
    canvas.save();
    canvas.rotate(0.15);
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(s * 0.02, 0), width: s * 0.08, height: s * 0.14),
      handPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(s * 0.02, 0), width: s * 0.08, height: s * 0.14),
      linePaint,
    );
    canvas.restore();

    canvas.restore();

    // Small glow / halo above
    final Paint haloPaint = Paint()
      ..color = _gold.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(
      Offset(cx, cy - s * 0.35),
      s * 0.06,
      haloPaint,
    );
  }

  // ── Surprised: exclamation mark ──

  void _drawExclamation(Canvas canvas, double s, double cx, double cy) {
    final Paint paint = Paint()
      ..color = _gold
      ..strokeWidth = s * 0.025
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Offset top = Offset(cx + s * 0.25, cy - s * 0.40);
    canvas.drawLine(top, top + Offset(0, s * 0.08), paint);
    canvas.drawCircle(
      top + Offset(0, s * 0.12),
      s * 0.012,
      Paint()..color = _gold,
    );
  }

  // ── Gardening: flower ──

  void _drawFlower(Canvas canvas, double s, double cx, double cy) {
    final Offset flowerPos = Offset(cx + s * 0.28, cy + s * 0.15);

    // Stem
    final Paint stemPaint = Paint()
      ..color = const Color(0xFF66BB6A)
      ..strokeWidth = s * 0.015
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      flowerPos,
      flowerPos + Offset(0, s * 0.15),
      stemPaint,
    );

    // Leaf
    final Paint leafPaint = Paint()..color = const Color(0xFF81C784);
    final Path leafPath = Path()
      ..moveTo(flowerPos.dx, flowerPos.dy + s * 0.08)
      ..quadraticBezierTo(
        flowerPos.dx + s * 0.06,
        flowerPos.dy + s * 0.05,
        flowerPos.dx + s * 0.08,
        flowerPos.dy + s * 0.08,
      )
      ..quadraticBezierTo(
        flowerPos.dx + s * 0.06,
        flowerPos.dy + s * 0.11,
        flowerPos.dx,
        flowerPos.dy + s * 0.08,
      );
    canvas.drawPath(leafPath, leafPaint);

    // Petals
    final Paint petalPaint = Paint()..color = _pink;
    for (int i = 0; i < 5; i++) {
      final double angle = (i / 5) * 2 * pi - pi / 2;
      final Offset petalCenter = Offset(
        flowerPos.dx + cos(angle) * s * 0.04,
        flowerPos.dy + sin(angle) * s * 0.04,
      );
      canvas.drawCircle(petalCenter, s * 0.03, petalPaint);
    }

    // Center
    canvas.drawCircle(flowerPos, s * 0.02, Paint()..color = _gold);
  }

  // ── Reading: book ──

  void _drawBook(Canvas canvas, double s, double cx, double cy) {
    final Paint coverPaint = Paint()..color = const Color(0xFF8D6E63);
    final Paint pagePaint = Paint()..color = _white;
    final Paint linePaint = Paint()
      ..color = _eyeColor.withValues(alpha: 0.2)
      ..strokeWidth = s * 0.006;

    final Offset bookCenter = Offset(cx, cy + s * 0.26);
    final double bw = s * 0.22;
    final double bh = s * 0.14;

    // Book cover
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: bookCenter, width: bw, height: bh),
        Radius.circular(s * 0.015),
      ),
      coverPaint,
    );

    // Left page
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          bookCenter.dx - bw / 2 + s * 0.008,
          bookCenter.dy - bh / 2 + s * 0.008,
          bw / 2 - s * 0.012,
          bh - s * 0.016,
        ),
        Radius.circular(s * 0.008),
      ),
      pagePaint,
    );

    // Right page
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          bookCenter.dx + s * 0.004,
          bookCenter.dy - bh / 2 + s * 0.008,
          bw / 2 - s * 0.012,
          bh - s * 0.016,
        ),
        Radius.circular(s * 0.008),
      ),
      pagePaint,
    );

    // Text lines on left page
    for (int i = 0; i < 3; i++) {
      final double y =
          bookCenter.dy - bh / 2 + s * 0.03 + i * s * 0.025;
      canvas.drawLine(
        Offset(bookCenter.dx - bw / 2 + s * 0.025, y),
        Offset(bookCenter.dx - s * 0.02, y),
        linePaint,
      );
    }

    // Spine
    canvas.drawLine(
      Offset(bookCenter.dx, bookCenter.dy - bh / 2),
      Offset(bookCenter.dx, bookCenter.dy + bh / 2),
      Paint()
        ..color = _eyeColor.withValues(alpha: 0.15)
        ..strokeWidth = s * 0.008,
    );
  }

  // ── Excited: sparkles ──

  void _drawSparkles(Canvas canvas, double s, double cx, double cy) {
    final Paint sparklePaint = Paint()..color = _gold;

    void drawStar(Offset center, double r) {
      final Path star = Path();
      for (int i = 0; i < 4; i++) {
        final double angle = (i / 4) * 2 * pi - pi / 2;
        final double outerX = center.dx + cos(angle) * r;
        final double outerY = center.dy + sin(angle) * r;
        final double innerAngle = angle + pi / 4;
        final double innerR = r * 0.35;
        final double innerX = center.dx + cos(innerAngle) * innerR;
        final double innerY = center.dy + sin(innerAngle) * innerR;

        if (i == 0) {
          star.moveTo(outerX, outerY);
        } else {
          star.lineTo(outerX, outerY);
        }
        star.lineTo(innerX, innerY);
      }
      star.close();
      canvas.drawPath(star, sparklePaint);
    }

    drawStar(Offset(cx - s * 0.3, cy - s * 0.3), s * 0.04);
    drawStar(Offset(cx + s * 0.3, cy - s * 0.35), s * 0.035);
    drawStar(Offset(cx + s * 0.35, cy - s * 0.1), s * 0.03);
    drawStar(Offset(cx - s * 0.33, cy), s * 0.025);
  }

  @override
  bool shouldRepaint(_LambyPainter oldDelegate) =>
      expression != oldDelegate.expression;
}
