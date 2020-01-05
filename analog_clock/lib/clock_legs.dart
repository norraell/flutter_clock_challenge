import 'package:flutter/material.dart';

import 'dart:math' as math;

class ClockLegs extends StatelessWidget {
  const ClockLegs({
    @required this.color,
  }) : assert(color != null);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _LegPainter(
            color: color,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _LegPainter extends CustomPainter {
  _LegPainter({
    @required this.color,
  }) : assert(color != null);

  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final length = size.shortestSide * 0.5;

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = length * 0.06
      ..strokeCap = StrokeCap.square;

    final leftFootAngle = math.pi / 4;
    final rightFootAngle = math.pi / 4 * 3;

    final leftFootPosition = center +
        Offset(math.cos(leftFootAngle), math.sin(leftFootAngle)) * length * 0.9;
    final leftFootPositionEnd = center +
        Offset(math.cos(leftFootAngle), math.sin(leftFootAngle)) * length * 1.1;
    final rightFootPosition = center +
        Offset(math.cos(rightFootAngle), math.sin(rightFootAngle)) *
            length *
            0.9;
    final rightFootPositionEnd = center +
        Offset(math.cos(rightFootAngle), math.sin(rightFootAngle)) *
            length *
            1.1;

    canvas.drawLine(leftFootPosition, leftFootPositionEnd, linePaint);
    canvas.drawLine(rightFootPosition, rightFootPositionEnd, linePaint);
  }

  @override
  bool shouldRepaint(_LegPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
