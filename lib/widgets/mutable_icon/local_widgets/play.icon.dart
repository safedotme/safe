// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class PlayIcon extends CustomPainter {
  final Color color;

  PlayIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.09557684, size.height);
    path_0.cubicTo(
        size.width * 0.1207821,
        size.height,
        size.width * 0.1429868,
        size.height * 0.9914500,
        size.width * 0.1705932,
        size.height * 0.9760550);
    path_0.lineTo(size.width * 0.8793474, size.height * 0.5866600);
    path_0.cubicTo(
        size.width * 0.9309579,
        size.height * 0.5581550,
        size.width * 0.9525632,
        size.height * 0.5359200,
        size.width * 0.9525632,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9525632,
        size.height * 0.4640820,
        size.width * 0.9309579,
        size.height * 0.4424175,
        size.width * 0.8793474,
        size.height * 0.4133410);
    path_0.lineTo(size.width * 0.1705932, size.height * 0.02394525);
    path_0.cubicTo(size.width * 0.1429868, size.height * 0.008551900,
        size.width * 0.1207821, 0, size.width * 0.09557684, 0);
    path_0.cubicTo(
        size.width * 0.04636579,
        0,
        size.width * 0.01155811,
        size.height * 0.03591790,
        size.width * 0.01155811,
        size.height * 0.09236050);
    path_0.lineTo(size.width * 0.01155811, size.height * 0.9076400);
    path_0.cubicTo(
        size.width * 0.01155811,
        size.height * 0.9646500,
        size.width * 0.04636579,
        size.height,
        size.width * 0.09557684,
        size.height);
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
