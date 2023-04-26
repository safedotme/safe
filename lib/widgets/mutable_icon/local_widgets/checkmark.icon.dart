// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CheckmarkIcon extends CustomPainter {
  final Color color;
  CheckmarkIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3376425, size.height * 0.8388917);
    path_0.cubicTo(
        size.width * 0.3116225,
        size.height * 0.8389000,
        size.width * 0.2866675,
        size.height * 0.8283933,
        size.width * 0.2682842,
        size.height * 0.8096875);
    path_0.lineTo(size.width * 0.05858917, size.height * 0.5967458);
    path_0.cubicTo(
        size.width * 0.03602583,
        size.height * 0.5738175,
        size.width * 0.03602583,
        size.height * 0.5366500,
        size.width * 0.05858917,
        size.height * 0.5137217);
    path_0.cubicTo(
        size.width * 0.08115967,
        size.height * 0.4908008,
        size.width * 0.1177467,
        size.height * 0.4908008,
        size.width * 0.1403167,
        size.height * 0.5137217);
    path_0.lineTo(size.width * 0.3376425, size.height * 0.7141767);
    path_0.lineTo(size.width * 0.8596833, size.height * 0.1838575);
    path_0.cubicTo(
        size.width * 0.8822500,
        size.height * 0.1609367,
        size.width * 0.9188417,
        size.height * 0.1609367,
        size.width * 0.9414083,
        size.height * 0.1838575);
    path_0.cubicTo(
        size.width * 0.9639750,
        size.height * 0.2067858,
        size.width * 0.9639750,
        size.height * 0.2439533,
        size.width * 0.9414083,
        size.height * 0.2668817);
    path_0.lineTo(size.width * 0.4070017, size.height * 0.8096875);
    path_0.cubicTo(
        size.width * 0.3886175,
        size.height * 0.8283933,
        size.width * 0.3636633,
        size.height * 0.8389000,
        size.width * 0.3376425,
        size.height * 0.8388917);
    path_0.close();

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint_0_stroke.color = color;
    canvas.drawPath(path_0, paint_0_stroke);

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
