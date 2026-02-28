import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// A speech bubble from the Lamby character.
///
/// Displays [text] inside a rounded rectangle with a small triangular tail
/// pointing downward. Optionally auto-dismisses after [autoDismissDuration].
class LambyDialogue extends StatefulWidget {
  const LambyDialogue({
    super.key,
    required this.text,
    this.autoDismiss = false,
    this.autoDismissDuration = const Duration(seconds: 3),
    this.onDismissed,
    this.maxWidth = 260,
  });

  /// The dialogue text content.
  final String text;

  /// Whether the bubble should automatically fade out and dismiss.
  final bool autoDismiss;

  /// How long the bubble stays visible before fading out.
  /// Only used when [autoDismiss] is true.
  final Duration autoDismissDuration;

  /// Called when the auto-dismiss animation completes.
  final VoidCallback? onDismissed;

  /// Maximum width of the speech bubble.
  final double maxWidth;

  @override
  State<LambyDialogue> createState() => _LambyDialogueState();
}

class _LambyDialogueState extends State<LambyDialogue>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    // Start fully visible.
    _controller.value = 1.0;

    if (widget.autoDismiss) {
      _scheduleDismiss();
    }
  }

  void _scheduleDismiss() {
    Future.delayed(widget.autoDismissDuration, () {
      if (mounted) {
        _controller.reverse().then((_) {
          widget.onDismissed?.call();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bubbleColor = isDark
        ? AppColors.darkBackgroundSecondary
        : Colors.white;
    final Color textColor =
        isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

    return FadeTransition(
      opacity: _opacity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Bubble body
          Container(
            constraints: BoxConstraints(maxWidth: widget.maxWidth),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              widget.text,
              style: AppTypography.bodyMedium(textColor),
              textAlign: TextAlign.center,
            ),
          ),
          // Tail pointing down
          CustomPaint(
            size: const Size(20, 10),
            painter: _BubbleTailPainter(color: bubbleColor),
          ),
        ],
      ),
    );
  }
}

/// Paints a small downward-pointing triangle acting as the speech bubble tail.
class _BubbleTailPainter extends CustomPainter {
  const _BubbleTailPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BubbleTailPainter oldDelegate) =>
      color != oldDelegate.color;
}
