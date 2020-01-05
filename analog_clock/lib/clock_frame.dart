import 'package:flutter/material.dart';

class Clockframe extends StatelessWidget {
  const Clockframe({
    @required this.color,
  }) : assert(color != null);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _FramePainter(
            color: color,
          ),
        ),
      ),
    );
  }
}

/// [CustomPainter] that draws a clock hand.
class _FramePainter extends CustomPainter {
  _FramePainter({
    @required this.color,
  }) : assert(color != null);

  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    // We want to start at the top, not at the x-axis, so add pi/2.
    final length = size.shortestSide * 0.42;

    // background of clock
    final clockPaint = Paint()..color = color;
    canvas.drawCircle(center, length, clockPaint);
  }

  @override
  bool shouldRepaint(_FramePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
