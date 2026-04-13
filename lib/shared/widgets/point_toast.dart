import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import 'talent_icon.dart';

/// 달란트 획득 토스트 ("+N 달란트"가 위로 떠오르며 사라지는 애니메이션)
///
/// Use [PointToast.show] to display the toast as an overlay anchored to a
/// source position, or embed the widget directly in a Stack.
class PointToast extends StatefulWidget {
  const PointToast({
    super.key,
    required this.points,
    this.label = kTalentLabel,
    this.duration = const Duration(milliseconds: 1000),
    this.onComplete,
  });

  /// Number of points to show (e.g. 10 renders "+10 달란트").
  final int points;

  /// Suffix label after the number. Defaults to "달란트".
  final String label;

  /// Total animation duration (float up + fade out).
  final Duration duration;

  /// Called when the animation completes.
  final VoidCallback? onComplete;

  /// Convenience helper to show the toast as an overlay entry.
  ///
  /// [context] is used to find the [Overlay].
  /// [sourceOffset] is the position in global coordinates where the toast
  /// should originate from.
  static void show(
    BuildContext context, {
    required int points,
    required Offset sourceOffset,
    String label = kTalentLabel,
  }) {
    final OverlayState overlay = Overlay.of(context);
    late final OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: sourceOffset.dx - 40,
        top: sourceOffset.dy - 20,
        child: PointToast(
          points: points,
          label: label,
          onComplete: () => entry.remove(),
        ),
      ),
    );

    overlay.insert(entry);
  }

  @override
  State<PointToast> createState() => _PointToastState();
}

class _PointToastState extends State<PointToast>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _translateY;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    // Float up by 60px.
    _translateY = Tween<double>(
      begin: 0,
      end: -60,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Fade out in the last 40% of the animation.
    _opacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 60),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 40,
      ),
    ]).animate(_controller);

    // Slight scale-up on entry.
    _scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0.6,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 30,
      ),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 20),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
    ]).animate(_controller);

    _controller.forward().then((_) {
      widget.onComplete?.call();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _translateY.value),
          child: Opacity(
            opacity: _opacity.value,
            child: Transform.scale(scale: _scale.value, child: child),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '+${widget.points}',
            style: AppTypography.headlineMedium(AppColors.gold).copyWith(
              decoration: TextDecoration.none,
              decorationStyle: null,
              decorationColor: Colors.transparent,
              decorationThickness: 0,
            ),
          ),
          const SizedBox(width: 4),
          const TalentIcon(size: 22),
          const SizedBox(width: 2),
          Text(
            widget.label,
            style: AppTypography.headlineMedium(AppColors.gold).copyWith(
              fontSize: 16,
              decoration: TextDecoration.none,
              decorationStyle: null,
              decorationColor: Colors.transparent,
              decorationThickness: 0,
            ),
          ),
        ],
      ),
    );
  }
}
