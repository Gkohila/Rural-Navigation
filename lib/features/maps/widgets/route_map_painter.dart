import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:smartnav/theme/smart_nav_theme.dart';

/// Soft faded road-map background matching the HTML screenshot aesthetic.
class MapBackgroundPainter extends CustomPainter {
  const MapBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = SmartNavColors.mapBase,
    );

    final blockPaint = Paint()
      ..color = SmartNavColors.mapRoad.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    final rng = math.Random(7);
    const blockCount = 18;
    for (var i = 0; i < blockCount; i++) {
      final w = size.width * (0.08 + rng.nextDouble() * 0.14);
      final h = size.height * (0.1 + rng.nextDouble() * 0.18);
      final left = rng.nextDouble() * (size.width - w);
      final top = rng.nextDouble() * (size.height - h);
      final rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, w, h),
        Radius.circular(4 + rng.nextDouble() * 6),
      );
      canvas.drawRRect(rrect, blockPaint);
    }

    final roadPaint = Paint()
      ..color = SmartNavColors.mapRoad
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final dimRoadPaint = Paint()
      ..color = SmartNavColors.mapRoadDim.withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    // Major roads
    final hRoads = [0.22, 0.48, 0.72];
    for (final y in hRoads) {
      final path = Path()
        ..moveTo(0, size.height * y)
        ..quadraticBezierTo(
          size.width * 0.5,
          size.height * (y + 0.04),
          size.width,
          size.height * y,
        );
      canvas.drawPath(path, roadPaint);
    }

    final vRoads = [0.18, 0.42, 0.68, 0.88];
    for (final x in vRoads) {
      final path = Path()
        ..moveTo(size.width * x, 0)
        ..quadraticBezierTo(
          size.width * (x - 0.02),
          size.height * 0.55,
          size.width * x,
          size.height,
        );
      canvas.drawPath(path, roadPaint);
    }

    // Minor grid roads
    for (var i = 1; i < 5; i++) {
      final y = size.height * (i / 5);
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        dimRoadPaint,
      );
    }
    for (var i = 1; i < 6; i++) {
      final x = size.width * (i / 6);
      canvas.drawLine(
        Offset(x, 0),
        Offset(x, size.height),
        dimRoadPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MapBackgroundPainter oldDelegate) => false;
}

/// Curved transit route overlay — smoother curve, thinner stroke, modern markers.
class RouteMapPainter extends CustomPainter {
  const RouteMapPainter();

  static const double _refWidth = 600;
  static const double _refHeight = 300;

  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / _refWidth;
    final scaleY = size.height / _refHeight;

    final path = Path()
      ..moveTo(100 * scaleX, 200 * scaleY)
      ..cubicTo(
        170 * scaleX,
        155 * scaleY,
        250 * scaleX,
        145 * scaleY,
        330 * scaleX,
        175 * scaleY,
      )
      ..cubicTo(
        410 * scaleX,
        205 * scaleY,
        460 * scaleX,
        95 * scaleY,
        500 * scaleX,
        120 * scaleY,
      );

    final routePaint = Paint()
      ..color = SmartNavColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, routePaint);

    _drawEndpoint(
      canvas,
      Offset(100 * scaleX, 200 * scaleY),
      strokeColor: SmartNavColors.primary,
    );
    _drawEndpoint(
      canvas,
      Offset(500 * scaleX, 120 * scaleY),
      strokeColor: SmartNavColors.error,
    );
  }

  void _drawEndpoint(
    Canvas canvas,
    Offset center, {
    required Color strokeColor,
  }) {
    const outerRadius = 6.0;
    const strokeWidth = 2.0;
    const innerRadius = 2.5;

    canvas.drawCircle(
      center,
      outerRadius,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      center,
      outerRadius,
      Paint()
        ..color = strokeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
    canvas.drawCircle(
      center,
      innerRadius,
      Paint()
        ..color = strokeColor.withValues(alpha: 0.35)
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant RouteMapPainter oldDelegate) => false;
}
