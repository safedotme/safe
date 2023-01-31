// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class FaceIDIcon extends CustomPainter {
  final Color color;

  FaceIDIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3824800, size.height * 0.7000000);
    path_0.cubicTo(
        size.width * 0.4100000,
        size.height * 0.7200000,
        size.width * 0.4500000,
        size.height * 0.7400000,
        size.width * 0.5000000,
        size.height * 0.7400000);
    path_0.cubicTo(
        size.width * 0.5500000,
        size.height * 0.7400000,
        size.width * 0.5900000,
        size.height * 0.7200000,
        size.width * 0.6175200,
        size.height * 0.7000000);
    path_0.moveTo(size.width * 0.7000000, size.height * 0.3800000);
    path_0.lineTo(size.width * 0.7000000, size.height * 0.4600000);
    path_0.moveTo(size.width * 0.3000000, size.height * 0.3800000);
    path_0.lineTo(size.width * 0.3000000, size.height * 0.4600000);
    path_0.moveTo(size.width * 0.5000000, size.height * 0.3800000);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.5400000);
    path_0.cubicTo(
        size.width * 0.5000000,
        size.height * 0.5620800,
        size.width * 0.4820800,
        size.height * 0.5800000,
        size.width * 0.4600000,
        size.height * 0.5800000);
    path_0.moveTo(size.width * 0.9400050, size.height * 0.2600100);
    path_0.lineTo(size.width * 0.9400050, size.height * 0.1400100);
    path_0.cubicTo(
        size.width * 0.9400050,
        size.height * 0.09581000,
        size.width * 0.9042050,
        size.height * 0.06001000,
        size.width * 0.8600050,
        size.height * 0.06001000);
    path_0.lineTo(size.width * 0.7400000, size.height * 0.06001000);
    path_0.moveTo(size.width * 0.2599975, size.height * 0.06001000);
    path_0.lineTo(size.width * 0.1399975, size.height * 0.06001000);
    path_0.cubicTo(
        size.width * 0.09579750,
        size.height * 0.06001000,
        size.width * 0.05999750,
        size.height * 0.09581000,
        size.width * 0.05999750,
        size.height * 0.1400100);
    path_0.lineTo(size.width * 0.05999750, size.height * 0.2600100);
    path_0.moveTo(size.width * 0.7400000, size.height * 0.9400150);
    path_0.lineTo(size.width * 0.8600050, size.height * 0.9400150);
    path_0.cubicTo(
        size.width * 0.9042050,
        size.height * 0.9400150,
        size.width * 0.9400050,
        size.height * 0.9042150,
        size.width * 0.9400050,
        size.height * 0.8600150);
    path_0.lineTo(size.width * 0.9400050, size.height * 0.7400150);
    path_0.moveTo(size.width * 0.05999750, size.height * 0.7400150);
    path_0.lineTo(size.width * 0.05999750, size.height * 0.8600150);
    path_0.cubicTo(
        size.width * 0.05999750,
        size.height * 0.9042150,
        size.width * 0.09579750,
        size.height * 0.9400150,
        size.width * 0.1399975,
        size.height * 0.9400150);
    path_0.lineTo(size.width * 0.2599975, size.height * 0.9400150);

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.1100000;
    paint_0_stroke.color = color;
    paint_0_stroke.strokeCap = StrokeCap.round;
    paint_0_stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.transparent;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
