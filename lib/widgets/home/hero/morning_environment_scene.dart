import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Warm morning sky with sun glow and Western Ghats silhouette.
class MorningEnvironmentScene extends StatefulWidget {
  const MorningEnvironmentScene({super.key});

  @override
  State<MorningEnvironmentScene> createState() =>
      _MorningEnvironmentSceneState();
}

class _MorningEnvironmentSceneState extends State<MorningEnvironmentScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ambient;

  @override
  void initState() {
    super.initState();
    _ambient = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ambient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ambient,
      builder: (context, child) {
        return CustomPaint(
          painter: _MorningScenePainter(ambient: _ambient.value),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _MorningScenePainter extends CustomPainter {
  _MorningScenePainter({required this.ambient});

  final double ambient;

  @override
  void paint(Canvas canvas, Size size) {
    final pulse = 0.06 * math.sin(ambient * math.pi * 2);
    final horizon = size.height * 0.62;

    final sky = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(0, horizon),
      [
        Color.lerp(const Color(0xFF4A90D9), const Color(0xFF5B9FE0), pulse)!,
        Color.lerp(const Color(0xFF87CEEB), const Color(0xFF9AD4F0), pulse)!,
        Color.lerp(const Color(0xFFFFE0B2), const Color(0xFFFFF3C8), pulse)!,
        const Color(0xFFE8F5E9),
      ],
      const [0, 0.35, 0.72, 1],
    );
    canvas.drawRect(Offset.zero & size, Paint()..shader = sky);

    final sunCenter = Offset(size.width * 0.78, size.height * 0.2);
    final sunGlow = 56 + pulse * 12;
    canvas.drawCircle(
      sunCenter,
      sunGlow,
      Paint()
        ..shader = ui.Gradient.radial(
          sunCenter,
          sunGlow,
          [
            const Color(0xFFFFF59D).withValues(alpha: 0.55),
            const Color(0xFFFFB74D).withValues(alpha: 0.2),
            Colors.transparent,
          ],
          const [0, 0.45, 1],
        ),
    );
    canvas.drawCircle(
      sunCenter,
      22,
      Paint()..color = const Color(0xFFFFF176),
    );

    final hills = Paint()..color = const Color(0xFF2E7D32);
    final path = Path()
      ..moveTo(0, horizon)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, horizon)
      ..quadraticBezierTo(
        size.width * 0.75,
        horizon - size.height * 0.08,
        size.width * 0.5,
        horizon,
      )
      ..quadraticBezierTo(
        size.width * 0.2,
        horizon + size.height * 0.04,
        0,
        horizon,
      )
      ..close();
    canvas.drawPath(path, hills);

    final mist = ui.Gradient.linear(
      Offset(0, horizon - 20),
      Offset(0, size.height),
      [
        Colors.white.withValues(alpha: 0.12 + pulse * 0.04),
        Colors.transparent,
      ],
    );
    canvas.drawRect(
      Rect.fromLTWH(0, horizon - 20, size.width, size.height - horizon + 20),
      Paint()..shader = mist,
    );
  }

  @override
  bool shouldRepaint(_MorningScenePainter oldDelegate) =>
      oldDelegate.ambient != ambient;
}
