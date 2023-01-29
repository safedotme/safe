import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;

class MutableCircularProgressIndicator extends CustomPainter {
  const MutableCircularProgressIndicator({
    required this.backColor,
    required this.frontColor,
    required this.strokeWidth,
    required this.value,
  });
  final Color backColor, frontColor;
  final double strokeWidth, value;

  double deltaSize(double val) {
    final pos = -4 * val * (val - 1);

    return 100 * pos;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width, h = size.height;
    final paint1 = Paint()
      ..strokeWidth = strokeWidth - 1
      ..color = backColor
      ..style = PaintingStyle.stroke;
    final paint2 = Paint()
      ..strokeWidth = strokeWidth
      ..color = frontColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final r =
        Rect.fromCenter(center: Offset(w / 2, h / 2), width: w, height: h);

    canvas.drawArc(r, math.radians(0), math.radians(360), false, paint1);
    canvas.drawArc(r, math.radians(360 * value + 225),
        math.radians(100 + deltaSize(value)), false, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
