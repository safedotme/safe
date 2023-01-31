//Copy this CustomPainter code to the Bottom of the File
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class NextBorderlessIcon extends CustomPainter {
  final Color color;

  NextBorderlessIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9771667, size.height * 0.4989350);
    path_0.cubicTo(
        size.width * 0.9771667,
        size.height * 0.5308340,
        size.width * 0.9674167,
        size.height * 0.5552910,
        size.width * 0.9461500,
        size.height * 0.5797470);
    path_0.lineTo(size.width * 0.6333575, size.height * 0.9487170);
    path_0.cubicTo(
        size.width * 0.6174083,
        size.height * 0.9667940,
        size.width * 0.5996858,
        size.height * 0.9763640,
        size.width * 0.5766475,
        size.height * 0.9763640);
    path_0.cubicTo(
        size.width * 0.5332292,
        size.height * 0.9763640,
        size.width * 0.5022150,
        size.height * 0.9370210,
        size.width * 0.5022150,
        size.height * 0.8838550);
    path_0.cubicTo(
        size.width * 0.5022150,
        size.height * 0.8572720,
        size.width * 0.5110767,
        size.height * 0.8328160,
        size.width * 0.5261400,
        size.height * 0.8158030);
    path_0.lineTo(size.width * 0.6377883, size.height * 0.6882050);
    path_0.lineTo(size.width * 0.7405750, size.height * 0.5893170);
    path_0.lineTo(size.width * 0.5518367, size.height * 0.5999500);
    path_0.lineTo(size.width * 0.1043583, size.height * 0.5999500);
    path_0.cubicTo(
        size.width * 0.05650900,
        size.height * 0.5999500,
        size.width * 0.02283733,
        size.height * 0.5574170,
        size.width * 0.02283733,
        size.height * 0.4999980);
    path_0.cubicTo(
        size.width * 0.02283733,
        size.height * 0.4415160,
        size.width * 0.05739508,
        size.height * 0.3989830,
        size.width * 0.1043583,
        size.height * 0.3989830);
    path_0.lineTo(size.width * 0.5518367, size.height * 0.3989830);
    path_0.lineTo(size.width * 0.7405750, size.height * 0.4096160);
    path_0.lineTo(size.width * 0.6369025, size.height * 0.3107280);
    path_0.lineTo(size.width * 0.5261400, size.height * 0.1831300);
    path_0.cubicTo(
        size.width * 0.5119625,
        size.height * 0.1661170,
        size.width * 0.5022150,
        size.height * 0.1416610,
        size.width * 0.5022150,
        size.height * 0.1150780);
    path_0.cubicTo(
        size.width * 0.5022150,
        size.height * 0.06191220,
        size.width * 0.5332292,
        size.height * 0.02363280,
        size.width * 0.5766475,
        size.height * 0.02363280);
    path_0.cubicTo(
        size.width * 0.5996858,
        size.height * 0.02363280,
        size.width * 0.6174083,
        size.height * 0.03107600,
        size.width * 0.6333575,
        size.height * 0.05021570);
    path_0.lineTo(size.width * 0.9461500, size.height * 0.4202500);
    path_0.cubicTo(
        size.width * 0.9683000,
        size.height * 0.4447060,
        size.width * 0.9771667,
        size.height * 0.4691620,
        size.width * 0.9771667,
        size.height * 0.4989350);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
