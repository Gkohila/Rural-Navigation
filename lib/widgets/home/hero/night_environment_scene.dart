import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// Cinematic night road scene: sky, city silhouette, wet road, lights, mist.
class NightEnvironmentScene extends StatefulWidget {
  const NightEnvironmentScene({super.key});

  @override
  State<NightEnvironmentScene> createState() => _NightEnvironmentSceneState();
}

class _NightEnvironmentSceneState extends State<NightEnvironmentScene>
    with TickerProviderStateMixin {
  late final AnimationController _ambient;
  late final AnimationController _traffic;

  @override
  void initState() {
    super.initState();
    _ambient = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat(reverse: true);
    _traffic = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 9000),
    )..repeat();
  }

  @override
  void dispose() {
    _ambient.dispose();
    _traffic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_ambient, _traffic]),
      builder: (context, child) {
        return CustomPaint(
          painter: _NightScenePainter(
            ambient: _ambient.value,
            traffic: _traffic.value,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }
}

class _NightScenePainter extends CustomPainter {
  _NightScenePainter({required this.ambient, required this.traffic});

  final double ambient;
  final double traffic;

  static const Color _skyTop = Color(0xFF070D18);
  static const Color _skyMid = Color(0xFF121E33);
  static const Color _skyHorizon = Color(0xFF243347);
  static const Color _warmHaze = Color(0xFF3A2F28);
  static const Color _road = Color(0xFF0E1118);
  static const Color _roadWet = Color(0xFF1A2438);
  static const Color _lampWarm = Color(0xFFFFC96B);
  static const Color _headlight = Color(0xFFFFF4D6);
  static const Color _taillight = Color(0xFFFF6B5A);

  @override
  void paint(Canvas canvas, Size size) {
    final roadTop = size.height * 0.58;
    _paintSky(canvas, size, roadTop);
    _paintBuildings(canvas, size, roadTop);
    _paintRoad(canvas, size, roadTop);
    _paintWetReflections(canvas, size, roadTop);
    _paintStreetLights(canvas, size, roadTop);
    _paintVehicleLights(canvas, size, roadTop);
    _paintMist(canvas, size);
  }

  void _paintSky(Canvas canvas, Size size, double roadTop) {
    final pulse = 0.04 * math.sin(ambient * math.pi * 2);
    final rect = Offset.zero & size;
    final gradient = ui.Gradient.linear(
      const Offset(0, 0),
      Offset(size.width * 0.2, roadTop),
      [
        Color.lerp(_skyTop, const Color(0xFF0A1220), pulse)!,
        Color.lerp(_skyMid, const Color(0xFF16243D), pulse)!,
        Color.lerp(_skyHorizon, _warmHaze, 0.35 + pulse)!,
        _road.withValues(alpha: 0.9),
      ],
      [0, 0.45, 0.82, 1],
    );
    canvas.drawRect(rect, Paint()..shader = gradient);
  }

  void _paintBuildings(Canvas canvas, Size size, double roadTop) {
    final silhouette = Paint()..color = const Color(0xFF080C14);
    final window = Paint()..color = _lampWarm.withValues(alpha: 0.55);

    final blocks = [
      (0.02, 0.22, 0.14, 0.42),
      (0.14, 0.18, 0.12, 0.48),
      (0.26, 0.12, 0.16, 0.52),
      (0.44, 0.2, 0.11, 0.45),
      (0.56, 0.08, 0.18, 0.55),
      (0.76, 0.16, 0.14, 0.46),
      (0.88, 0.22, 0.1, 0.4),
    ];

    for (final b in blocks) {
      final left = size.width * b.$1;
      final width = size.width * b.$2;
      final height = size.height * b.$4;
      final top = roadTop - height;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, width, height),
          const Radius.circular(2),
        ),
        silhouette,
      );
      for (var row = 0; row < 3; row++) {
        for (var col = 0; col < 2; col++) {
          if ((row + col + (b.$1 * 10).round()) % 3 == 0) continue;
          canvas.drawRect(
            Rect.fromLTWH(
              left + width * (0.2 + col * 0.35),
              top + height * (0.15 + row * 0.22),
              width * 0.12,
              height * 0.08,
            ),
            window,
          );
        }
      }
    }
  }

  void _paintRoad(Canvas canvas, Size size, double roadTop) {
    canvas.drawRect(
      Rect.fromLTWH(0, roadTop, size.width, size.height - roadTop),
      Paint()..color = _road,
    );
    final roadGrad = ui.Gradient.linear(
      Offset(0, roadTop),
      Offset(0, size.height),
      [
        _roadWet.withValues(alpha: 0.5),
        _road,
      ],
    );
    canvas.drawRect(
      Rect.fromLTWH(0, roadTop, size.width, size.height - roadTop),
      Paint()..shader = roadGrad,
    );
  }

  void _paintWetReflections(Canvas canvas, Size size, double roadTop) {
    final shimmer = (traffic * size.width * 0.4) % size.width;
    final roadPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(shimmer - 80, roadTop + 8),
        Offset(shimmer + 120, roadTop + 28),
        [
          Colors.transparent,
          Colors.white.withValues(alpha: 0.06),
          Colors.transparent,
        ],
        const [0, 0.5, 1],
      );
    canvas.drawRect(
      Rect.fromLTWH(0, roadTop + 6, size.width, size.height - roadTop - 6),
      roadPaint,
    );

    final lampXs = [0.18, 0.48, 0.78];
    for (final fx in lampXs) {
      final x = size.width * fx;
      final glow = 0.35 + ambient * 0.2;
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(x, roadTop + (size.height - roadTop) * 0.55),
          width: 28,
          height: size.height - roadTop,
        ),
        Paint()
          ..shader = ui.Gradient.linear(
            Offset(x, roadTop + 4),
            Offset(x, size.height),
            [
              _lampWarm.withValues(alpha: glow * 0.22),
              Colors.transparent,
            ],
          ),
      );
    }
  }

  void _paintStreetLights(Canvas canvas, Size size, double roadTop) {
    final poles = [0.18, 0.48, 0.78];
    for (var i = 0; i < poles.length; i++) {
      final x = size.width * poles[i];
      final flicker = 0.85 + 0.15 * math.sin(ambient * math.pi * 2 + i);
      final poleTop = roadTop - size.height * 0.28;

      canvas.drawLine(
        Offset(x, poleTop),
        Offset(x, roadTop),
        Paint()
          ..color = const Color(0xFF2A3344)
          ..strokeWidth = 2,
      );

      final glowRadius = 38 * flicker;
      canvas.drawCircle(
        Offset(x, poleTop),
        glowRadius,
        Paint()
          ..shader = ui.Gradient.radial(
            Offset(x, poleTop),
            glowRadius,
            [
              _lampWarm.withValues(alpha: 0.45 * flicker),
              _lampWarm.withValues(alpha: 0.12),
              Colors.transparent,
            ],
            [0, 0.35, 1],
          ),
      );

      canvas.drawCircle(
        Offset(x, poleTop),
        5,
        Paint()..color = _lampWarm.withValues(alpha: 0.95),
      );
    }
  }

  void _paintVehicleLights(Canvas canvas, Size size, double roadTop) {
    final y = roadTop + (size.height - roadTop) * 0.38;

    final busX = size.width * (traffic * 1.15 - 0.1);
    _paintVehicleStreak(canvas, Offset(busX, y), headlight: true, scale: 1.2);

    final autoX = size.width * (1.05 - traffic * 0.95);
    _paintVehicleStreak(canvas, Offset(autoX, y + 10), headlight: false, scale: 0.7);

    final bikeX = size.width * ((traffic * 0.7 + 0.15) % 1.0);
    _paintVehicleStreak(canvas, Offset(bikeX, y + 6), headlight: true, scale: 0.45);
  }

  void _paintVehicleStreak(
    Canvas canvas,
    Offset center, {
    required bool headlight,
    required double scale,
  }) {
    final color = headlight ? _headlight : _taillight;
    final w = 36.0 * scale;
    final h = 8.0 * scale;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: w, height: h),
        Radius.circular(h / 2),
      ),
      Paint()..color = color.withValues(alpha: headlight ? 0.75 : 0.55),
    );

    canvas.drawCircle(
      center + Offset(headlight ? w * 0.35 : -w * 0.35, 0),
      h * 0.9,
      Paint()
        ..shader = ui.Gradient.radial(
          center,
          18 * scale,
          [
            color.withValues(alpha: 0.35),
            Colors.transparent,
          ],
        ),
    );
  }

  void _paintMist(Canvas canvas, Size size) {
    final drift = math.sin(ambient * math.pi * 2) * 12;
    final topMist = Paint()
      ..shader = ui.Gradient.linear(
        Offset(drift, 0),
        Offset(size.width * 0.5 + drift, size.height * 0.45),
        [
          const Color(0xFF9EB4D4).withValues(alpha: 0.1),
          Colors.transparent,
        ],
      );
    canvas.drawRect(Offset.zero & size, topMist);

    final bottomMist = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, size.height * 0.5),
        Offset(size.width, size.height),
        [
          Colors.transparent,
          const Color(0xFF8FA8C8).withValues(alpha: 0.14 + ambient * 0.04),
        ],
      );
    canvas.drawRect(Offset.zero & size, bottomMist);
  }

  @override
  bool shouldRepaint(_NightScenePainter oldDelegate) =>
      oldDelegate.ambient != ambient || oldDelegate.traffic != traffic;
}
