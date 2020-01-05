import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' show radians;

class MinutePin extends StatelessWidget {
  const MinutePin({
    @required this.color,
    @required this.thickness,
  })  : assert(color != null),
        assert(thickness != null);

  final double thickness;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _HandPainter(
            lineWidth: thickness,
            color: color,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _HandPainter extends CustomPainter {
  _HandPainter({
    @required this.lineWidth,
    @required this.color,
  })  : assert(lineWidth != null),
        assert(color != null);

  double lineWidth;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    double radiansPerTick = radians(360 / 60);
    for (var i = 0; i < 60; i += 5) {
      final currentRadians = radiansPerTick * i;
      final center = (Offset.zero & size).center;
      // We want to start at the top, not at the x-axis, so add pi/2.
      final angle = currentRadians - math.pi / 2.0;
      final length = size.shortestSide * 0.4;

      // factor for lines
      final double lengthFactor = i % 5 == 0 ? 0.85 : 0.95;

      final Offset innerposition = center +
          Offset(math.cos(angle), math.sin(angle)) * length * lengthFactor;

      final Offset outerposition =
          center + Offset(math.cos(angle), math.sin(angle)) * length;
      final Paint linePaint = Paint()
        ..color = color
        ..strokeWidth = i % 5 == 0 ? lineWidth * 2 : lineWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(innerposition, outerposition, linePaint);
    }
  }

  @override
  bool shouldRepaint(_HandPainter oldDelegate) {
    return oldDelegate.lineWidth != lineWidth || oldDelegate.color != color;
  }
}
