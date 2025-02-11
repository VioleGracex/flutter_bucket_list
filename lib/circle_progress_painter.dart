import 'package:flutter/material.dart';

class CircleProgressPainter extends CustomPainter {
  final double progress;

  CircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final startAngle = -90.0;
    final sweepAngle = 360.0 * progress;
    final useCenter = false;
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle * 0.0174533, sweepAngle * 0.0174533, useCenter, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}