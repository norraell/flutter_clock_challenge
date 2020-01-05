import 'package:flutter/material.dart';
import 'dart:math' as math;

class ClockBells extends StatelessWidget {
  const ClockBells({
    @required this.color,
  }) : assert(color != null);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _BellPainter(
            color: color,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _BellPainter extends CustomPainter {
  _BellPainter({
    @required this.color,
  }) : assert(color != null);

  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final length = size.shortestSide * 0.43;
    final bellPaint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round;

    final rightBellAngle = -math.pi / 4.0;
    final rightBellPosition = center +
        Offset(math.cos(rightBellAngle), math.sin(rightBellAngle)) * length;

    canvas.drawArc(
        Rect.fromCenter(
            center: rightBellPosition,
            height: length * 6 / 8,
            width: length * 6 / 8),
        math.pi * 1.25,
        math.pi,
        false,
        bellPaint);

    final leftBellAngle = -math.pi / 4 * 3;
    final leftBellPosition = center +
        Offset(math.cos(leftBellAngle), math.sin(leftBellAngle)) * length;
    canvas.drawArc(
        Rect.fromCenter(
            center: leftBellPosition,
            height: length * 6 / 8,
            width: length * 6 / 8),
        math.pi * 0.75,
        math.pi,
        false,
        bellPaint);
  }

  @override
  bool shouldRepaint(_BellPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
