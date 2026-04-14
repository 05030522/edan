import 'dart:math';

import 'package:flutter/material.dart';

/// 파티클 스타일
enum ParticleStyle {
  /// 중심에서 위로 떠오르는 금색/흰색 별 (업적 달성용)
  stars,

  /// 중심에서 위로 뻗어나가는 주황/빨강 불꽃 (스트릭 마일스톤용)
  fire,

  /// 중심에서 중력 낙하하는 다색 종이 조각 (완성/레벨업용)
  confetti,
}

/// 개별 파티클 상태
class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  final double size;
  final Color color;
  final double rotation;
  final double rotationSpeed;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
    required this.rotation,
    required this.rotationSpeed,
  });

  void advance(double dt, {double gravity = 0}) {
    x += vx * dt;
    y += vy * dt;
    vy += gravity * dt;
  }
}

/// 축하 파티클 오버레이 위젯
///
/// Stack 내부에 오버레이로 배치. 다이얼로그 콘텐츠 뒤/앞 어디든 가능.
class CelebrationParticles extends StatefulWidget {
  final ParticleStyle style;
  final Duration duration;
  final int count;

  const CelebrationParticles({
    super.key,
    this.style = ParticleStyle.stars,
    this.duration = const Duration(milliseconds: 2000),
    this.count = 28,
  });

  @override
  State<CelebrationParticles> createState() => _CelebrationParticlesState();
}

class _CelebrationParticlesState extends State<CelebrationParticles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;
  final _rng = Random();
  Duration _lastTick = Duration.zero;

  @override
  void initState() {
    super.initState();
    _particles = _spawnParticles();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(_onTick)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_Particle> _spawnParticles() {
    final palette = _paletteForStyle(widget.style);
    return List.generate(widget.count, (i) {
      final angle = _rng.nextDouble() * 2 * pi;
      final speed = 60 + _rng.nextDouble() * 140;
      return _Particle(
        x: 0,
        y: 0,
        vx: cos(angle) * speed,
        vy: sin(angle) * speed - _initialUpBias(),
        size: 4 + _rng.nextDouble() * 6,
        color: palette[_rng.nextInt(palette.length)],
        rotation: _rng.nextDouble() * 2 * pi,
        rotationSpeed: (_rng.nextDouble() - 0.5) * 6,
      );
    });
  }

  double _initialUpBias() {
    switch (widget.style) {
      case ParticleStyle.stars:
      case ParticleStyle.fire:
        return 100; // 위로 떠오름
      case ParticleStyle.confetti:
        return 20; // 약간만 위로, 이후 중력
    }
  }

  double _gravity() {
    switch (widget.style) {
      case ParticleStyle.stars:
        return -20; // 계속 떠오름
      case ParticleStyle.fire:
        return -40; // 빠르게 상승
      case ParticleStyle.confetti:
        return 120; // 낙하
    }
  }

  List<Color> _paletteForStyle(ParticleStyle style) {
    switch (style) {
      case ParticleStyle.stars:
        return const [
          Color(0xFFFFD54F),
          Color(0xFFFFF176),
          Color(0xFFFFFFFF),
          Color(0xFFE5C88E),
        ];
      case ParticleStyle.fire:
        return const [
          Color(0xFFFF7043),
          Color(0xFFFFB74D),
          Color(0xFFFFD54F),
          Color(0xFFFF8A65),
        ];
      case ParticleStyle.confetti:
        return const [
          Color(0xFFE57373),
          Color(0xFF64B5F6),
          Color(0xFF81C784),
          Color(0xFFFFD54F),
          Color(0xFFBA68C8),
        ];
    }
  }

  void _onTick() {
    final now = _controller.lastElapsedDuration ?? Duration.zero;
    final dtSec = (now - _lastTick).inMicroseconds / 1e6;
    _lastTick = now;
    if (dtSec <= 0) return;

    final gravity = _gravity();
    for (final p in _particles) {
      p.advance(dtSec, gravity: gravity);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final progress = _controller.value;
          final opacity = progress < 0.8 ? 1.0 : (1.0 - progress) * 5;
          return CustomPaint(
            painter: _ParticlePainter(
              particles: _particles,
              opacity: opacity.clamp(0.0, 1.0),
              isStar: widget.style != ParticleStyle.confetti,
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double opacity;
  final bool isStar;

  _ParticlePainter({
    required this.particles,
    required this.opacity,
    required this.isStar,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    for (final p in particles) {
      final pos = center.translate(p.x, p.y);
      final paint = Paint()..color = p.color.withValues(alpha: opacity);
      if (isStar) {
        canvas.drawCircle(pos, p.size / 2, paint);
      } else {
        // confetti 직사각형
        canvas.save();
        canvas.translate(pos.dx, pos.dy);
        canvas.rotate(p.rotation);
        canvas.drawRect(
          Rect.fromCenter(
            center: Offset.zero,
            width: p.size,
            height: p.size * 0.4,
          ),
          paint,
        );
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) => true;
}
