import 'package:flutter/material.dart';

class SafeIcon extends CustomPainter {
  final Color color;

  SafeIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3218750, size.height * 0.05826825);
    path_0.cubicTo(size.width * 0.1441083, size.height * 0.05826825, 0,
        size.height * 0.2023767, 0, size.height * 0.3801433);
    path_0.cubicTo(
        0,
        size.height * 0.5578583,
        size.width * 0.1440258,
        size.height * 0.7019350,
        size.width * 0.3217217,
        size.height * 0.7020183);
    path_0.lineTo(size.width * 0.3218750, size.height * 0.7020183);
    path_0.lineTo(size.width * 0.3220283, size.height * 0.7020183);
    path_0.lineTo(size.width * 0.3657967, size.height * 0.7020183);
    path_0.lineTo(size.width * 0.6875000, size.height * 0.7020183);
    path_0.cubicTo(
        size.width * 0.7131983,
        size.height * 0.7020183,
        size.width * 0.7500000,
        size.height * 0.6756525,
        size.width * 0.7500000,
        size.height * 0.6270175);
    path_0.cubicTo(
        size.width * 0.7500000,
        size.height * 0.5783842,
        size.width * 0.7131992,
        size.height * 0.5520183,
        size.width * 0.6875000,
        size.height * 0.5520183);
    path_0.lineTo(size.width * 0.5940683, size.height * 0.5520183);
    path_0.lineTo(size.width * 0.3643050, size.height * 0.5520183);
    path_0.lineTo(size.width * 0.3105267, size.height * 0.5520183);
    path_0.cubicTo(
        size.width * 0.2260517,
        size.height * 0.5520183,
        size.width * 0.1500000,
        size.height * 0.4772592,
        size.width * 0.1500000,
        size.height * 0.3770183);
    path_0.cubicTo(
        size.width * 0.1500000,
        size.height * 0.2767767,
        size.width * 0.2260517,
        size.height * 0.2020183,
        size.width * 0.3105267,
        size.height * 0.2020183);
    path_0.lineTo(size.width * 0.5900117, size.height * 0.2020183);
    path_0.cubicTo(
        size.width * 0.5323333,
        size.height * 0.1153675,
        size.width * 0.4337725,
        size.height * 0.05826825,
        size.width * 0.3218750,
        size.height * 0.05826825);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.6781250, size.height * 0.9457667);
    path_1.cubicTo(size.width * 0.8558917, size.height * 0.9457667, size.width,
        size.height * 0.8016600, size.width, size.height * 0.6238933);
    path_1.cubicTo(
        size.width,
        size.height * 0.4461267,
        size.width * 0.8558917,
        size.height * 0.3020183,
        size.width * 0.6781250,
        size.height * 0.3020183);
    path_1.lineTo(size.width * 0.6342033, size.height * 0.3020183);
    path_1.lineTo(size.width * 0.3105267, size.height * 0.3020183);
    path_1.cubicTo(
        size.width * 0.2859100,
        size.height * 0.3020183,
        size.width * 0.2500000,
        size.height * 0.3272592,
        size.width * 0.2500000,
        size.height * 0.3770183);
    path_1.cubicTo(
        size.width * 0.2500000,
        size.height * 0.4267767,
        size.width * 0.2859100,
        size.height * 0.4520183,
        size.width * 0.3105267,
        size.height * 0.4520183);
    path_1.lineTo(size.width * 0.4059317, size.height * 0.4520183);
    path_1.lineTo(size.width * 0.6356950, size.height * 0.4520183);
    path_1.lineTo(size.width * 0.6875000, size.height * 0.4520183);
    path_1.cubicTo(
        size.width * 0.7708917,
        size.height * 0.4520183,
        size.width * 0.8500000,
        size.height * 0.5256525,
        size.width * 0.8500000,
        size.height * 0.6270175);
    path_1.cubicTo(
        size.width * 0.8500000,
        size.height * 0.7283833,
        size.width * 0.7708917,
        size.height * 0.8020183,
        size.width * 0.6875000,
        size.height * 0.8020183);
    path_1.lineTo(size.width * 0.4099883, size.height * 0.8020183);
    path_1.cubicTo(
        size.width * 0.4676667,
        size.height * 0.8886667,
        size.width * 0.5662275,
        size.height * 0.9457667,
        size.width * 0.6781250,
        size.height * 0.9457667);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color;
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
