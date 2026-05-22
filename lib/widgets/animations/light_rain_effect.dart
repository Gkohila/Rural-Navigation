import 'package:flutter/material.dart';

/// Soft diagonal rain streaks — tuned for night / light-rain scenes.
class LightRainEffect extends StatefulWidget {
  const LightRainEffect({
    super.key,
    this.dropCount = 42,
    this.opacity = 0.16,
    this.color,
    this.duration = const Duration(milliseconds: 2400),
  });

  final int dropCount;
  final double opacity;
  final Color? color;
  final Duration duration;

  @override
  State<LightRainEffect> createState() => _LightRainEffectState();
}

class _LightRainEffectState extends State<LightRainEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
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
        return CustomPaint(
          painter: _RainPainter(
            progress: _controller.value,
            dropCount: widget.dropCount,
            opacity: widget.opacity,
            color: widget.color ?? const Color(0xFFC8D8F0),
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _RainPainter extends CustomPainter {
  _RainPainter({
    required this.progress,
    required this.dropCount,
    required this.opacity,
    required this.color,
  });

  final double progress;
  final int dropCount;
  final double opacity;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < dropCount; i++) {
      final seed = i * 1.618;
      final x = (seed * 43) % size.width;
      final travel = size.height + 28;
      final y = ((seed * 29 + progress * travel) % travel) - 14;
      final length = 5 + (i % 3);
      canvas.drawLine(Offset(x, y), Offset(x - 2, y + length), paint);
    }
  }

  @override
  bool shouldRepaint(_RainPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.dropCount != dropCount ||
      oldDelegate.opacity != opacity ||
      oldDelegate.color != color;
}
