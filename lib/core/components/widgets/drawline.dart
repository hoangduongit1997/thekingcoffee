import 'package:flutter/material.dart';

class Drawhorizontalline extends CustomPainter {
  Paint _paint;
  bool reverse;

  Drawhorizontalline(this.reverse) {
    _paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 0.2
      ..strokeCap = StrokeCap.round;
  }
  @override
  void paint(Canvas canvas, Size size) {
    if (!reverse) {
      canvas.drawLine(Offset(0.0, 0.0), Offset(200.0, 0.0), _paint);
    } else {
      canvas.drawLine(Offset(-90.0, 0.0), Offset(-10.0, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
