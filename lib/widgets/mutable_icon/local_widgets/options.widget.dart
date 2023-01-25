import 'package:flutter/material.dart';

class OptionsIcon extends CustomPainter {
  final Color color;

  OptionsIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1086957;
    paint_0_stroke.color = color;
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.5000000),
        size.width * 0.4456522, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.transparent;
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.5000000),
        size.width * 0.4456522, paint_0_fill);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color;
    canvas.drawCircle(Offset(size.width * 0.2826087, size.height * 0.5000000),
        size.width * 0.06521739, paint_1_fill);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = color;
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.5000000),
        size.width * 0.06521739, paint_2_fill);

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = color;
    canvas.drawCircle(Offset(size.width * 0.7173913, size.height * 0.5000000),
        size.width * 0.06521739, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
