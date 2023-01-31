//Copy this CustomPainter code to the Bottom of the File
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class MenuIcon extends CustomPainter {
  final Color color;

  MenuIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6428571, size.height * 0.1785714);
    path_0.cubicTo(
        size.width * 0.6428571,
        size.height * 0.2180204,
        size.width * 0.5788979,
        size.height * 0.2500000,
        size.width * 0.5000000,
        size.height * 0.2500000);
    path_0.cubicTo(
        size.width * 0.4211021,
        size.height * 0.2500000,
        size.width * 0.3571429,
        size.height * 0.2180204,
        size.width * 0.3571429,
        size.height * 0.1785714);
    path_0.cubicTo(
        size.width * 0.3571429,
        size.height * 0.1391225,
        size.width * 0.4211021,
        size.height * 0.1071429,
        size.width * 0.5000000,
        size.height * 0.1071429);
    path_0.cubicTo(
        size.width * 0.5788979,
        size.height * 0.1071429,
        size.width * 0.6428571,
        size.height * 0.1391225,
        size.width * 0.6428571,
        size.height * 0.1785714);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xffFBFCFF).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.6428571, size.height * 0.4285714);
    path_1.cubicTo(
        size.width * 0.6428571,
        size.height * 0.4680214,
        size.width * 0.5788979,
        size.height * 0.5000000,
        size.width * 0.5000000,
        size.height * 0.5000000);
    path_1.cubicTo(
        size.width * 0.4211021,
        size.height * 0.5000000,
        size.width * 0.3571429,
        size.height * 0.4680214,
        size.width * 0.3571429,
        size.height * 0.4285714);
    path_1.cubicTo(
        size.width * 0.3571429,
        size.height * 0.3891214,
        size.width * 0.4211021,
        size.height * 0.3571429,
        size.width * 0.5000000,
        size.height * 0.3571429);
    path_1.cubicTo(
        size.width * 0.5788979,
        size.height * 0.3571429,
        size.width * 0.6428571,
        size.height * 0.3891214,
        size.width * 0.6428571,
        size.height * 0.4285714);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xffFBFCFF).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.6428571, size.height * 0.6785714);
    path_2.cubicTo(
        size.width * 0.6428571,
        size.height * 0.7180214,
        size.width * 0.5788979,
        size.height * 0.7500000,
        size.width * 0.5000000,
        size.height * 0.7500000);
    path_2.cubicTo(
        size.width * 0.4211021,
        size.height * 0.7500000,
        size.width * 0.3571429,
        size.height * 0.7180214,
        size.width * 0.3571429,
        size.height * 0.6785714);
    path_2.cubicTo(
        size.width * 0.3571429,
        size.height * 0.6391214,
        size.width * 0.4211021,
        size.height * 0.6071429,
        size.width * 0.5000000,
        size.height * 0.6071429);
    path_2.cubicTo(
        size.width * 0.5788979,
        size.height * 0.6071429,
        size.width * 0.6428571,
        size.height * 0.6391214,
        size.width * 0.6428571,
        size.height * 0.6785714);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = color;
    canvas.drawPath(path_2, paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
