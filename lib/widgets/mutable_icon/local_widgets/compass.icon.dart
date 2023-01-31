// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CompassIcon extends CustomPainter {
  final Color color;

  CompassIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5576923, size.height * 0.07692308);
    path_0.cubicTo(
        size.width * 0.5576923,
        size.height * 0.04506038,
        size.width * 0.5318615,
        size.height * 0.01923077,
        size.width * 0.5000000,
        size.height * 0.01923077);
    path_0.cubicTo(
        size.width * 0.4681385,
        size.height * 0.01923077,
        size.width * 0.4423077,
        size.height * 0.04506038,
        size.width * 0.4423077,
        size.height * 0.07692308);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.07692308);
    path_0.close();
    path_0.moveTo(size.width * 0.4423077, size.height * 0.2307692);
    path_0.cubicTo(
        size.width * 0.4423077,
        size.height * 0.2626319,
        size.width * 0.4681385,
        size.height * 0.2884615,
        size.width * 0.5000000,
        size.height * 0.2884615);
    path_0.cubicTo(
        size.width * 0.5318615,
        size.height * 0.2884615,
        size.width * 0.5576923,
        size.height * 0.2626319,
        size.width * 0.5576923,
        size.height * 0.2307692);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.2307692);
    path_0.close();
    path_0.moveTo(size.width * 0.9230769, size.height * 0.5576923);
    path_0.cubicTo(
        size.width * 0.9549385,
        size.height * 0.5576923,
        size.width * 0.9807692,
        size.height * 0.5318615,
        size.width * 0.9807692,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9807692,
        size.height * 0.4681385,
        size.width * 0.9549385,
        size.height * 0.4423077,
        size.width * 0.9230769,
        size.height * 0.4423077);
    path_0.lineTo(size.width * 0.9230769, size.height * 0.5576923);
    path_0.close();
    path_0.moveTo(size.width * 0.7692308, size.height * 0.4423077);
    path_0.cubicTo(
        size.width * 0.7373692,
        size.height * 0.4423077,
        size.width * 0.7115385,
        size.height * 0.4681385,
        size.width * 0.7115385,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.7115385,
        size.height * 0.5318615,
        size.width * 0.7373692,
        size.height * 0.5576923,
        size.width * 0.7692308,
        size.height * 0.5576923);
    path_0.lineTo(size.width * 0.7692308, size.height * 0.4423077);
    path_0.close();
    path_0.moveTo(size.width * 0.5576923, size.height * 0.7692308);
    path_0.cubicTo(
        size.width * 0.5576923,
        size.height * 0.7373692,
        size.width * 0.5318615,
        size.height * 0.7115385,
        size.width * 0.5000000,
        size.height * 0.7115385);
    path_0.cubicTo(
        size.width * 0.4681385,
        size.height * 0.7115385,
        size.width * 0.4423077,
        size.height * 0.7373692,
        size.width * 0.4423077,
        size.height * 0.7692308);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.7692308);
    path_0.close();
    path_0.moveTo(size.width * 0.4423077, size.height * 0.9230769);
    path_0.cubicTo(
        size.width * 0.4423077,
        size.height * 0.9549385,
        size.width * 0.4681385,
        size.height * 0.9807692,
        size.width * 0.5000000,
        size.height * 0.9807692);
    path_0.cubicTo(
        size.width * 0.5318615,
        size.height * 0.9807692,
        size.width * 0.5576923,
        size.height * 0.9549385,
        size.width * 0.5576923,
        size.height * 0.9230769);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.9230769);
    path_0.close();
    path_0.moveTo(size.width * 0.2307692, size.height * 0.5576923);
    path_0.cubicTo(
        size.width * 0.2626319,
        size.height * 0.5576923,
        size.width * 0.2884615,
        size.height * 0.5318615,
        size.width * 0.2884615,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.2884615,
        size.height * 0.4681385,
        size.width * 0.2626319,
        size.height * 0.4423077,
        size.width * 0.2307692,
        size.height * 0.4423077);
    path_0.lineTo(size.width * 0.2307692, size.height * 0.5576923);
    path_0.close();
    path_0.moveTo(size.width * 0.07692308, size.height * 0.4423077);
    path_0.cubicTo(
        size.width * 0.04506038,
        size.height * 0.4423077,
        size.width * 0.01923077,
        size.height * 0.4681385,
        size.width * 0.01923077,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.01923077,
        size.height * 0.5318615,
        size.width * 0.04506038,
        size.height * 0.5576923,
        size.width * 0.07692308,
        size.height * 0.5576923);
    path_0.lineTo(size.width * 0.07692308, size.height * 0.4423077);
    path_0.close();
    path_0.moveTo(size.width * 0.7884615, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.7884615,
        size.height * 0.6593115,
        size.width * 0.6593115,
        size.height * 0.7884615,
        size.width * 0.5000000,
        size.height * 0.7884615);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.9038462);
    path_0.cubicTo(
        size.width * 0.7230385,
        size.height * 0.9038462,
        size.width * 0.9038462,
        size.height * 0.7230385,
        size.width * 0.9038462,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.7884615, size.height * 0.5000000);
    path_0.close();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.7884615);
    path_0.cubicTo(
        size.width * 0.3406869,
        size.height * 0.7884615,
        size.width * 0.2115385,
        size.height * 0.6593115,
        size.width * 0.2115385,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.09615385, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.09615385,
        size.height * 0.7230385,
        size.width * 0.2769619,
        size.height * 0.9038462,
        size.width * 0.5000000,
        size.height * 0.9038462);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.7884615);
    path_0.close();
    path_0.moveTo(size.width * 0.2115385, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.2115385,
        size.height * 0.3406869,
        size.width * 0.3406869,
        size.height * 0.2115385,
        size.width * 0.5000000,
        size.height * 0.2115385);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.09615385);
    path_0.cubicTo(
        size.width * 0.2769619,
        size.height * 0.09615385,
        size.width * 0.09615385,
        size.height * 0.2769619,
        size.width * 0.09615385,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.2115385, size.height * 0.5000000);
    path_0.close();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.2115385);
    path_0.cubicTo(
        size.width * 0.6593115,
        size.height * 0.2115385,
        size.width * 0.7884615,
        size.height * 0.3406869,
        size.width * 0.7884615,
        size.height * 0.5000000);
    path_0.lineTo(size.width * 0.9038462, size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9038462,
        size.height * 0.2769619,
        size.width * 0.7230385,
        size.height * 0.09615385,
        size.width * 0.5000000,
        size.height * 0.09615385);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.2115385);
    path_0.close();
    path_0.moveTo(size.width * 0.5576923, size.height * 0.1538462);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.07692308);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.07692308);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.1538462);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.1538462);
    path_0.close();
    path_0.moveTo(size.width * 0.4423077, size.height * 0.07692308);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.2307692);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.2307692);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.07692308);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.07692308);
    path_0.close();
    path_0.moveTo(size.width * 0.8461538, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.9230769, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.9230769, size.height * 0.4423077);
    path_0.lineTo(size.width * 0.8461538, size.height * 0.4423077);
    path_0.lineTo(size.width * 0.8461538, size.height * 0.5576923);
    path_0.close();
    path_0.moveTo(size.width * 0.9230769, size.height * 0.4423077);
    path_0.lineTo(size.width * 0.7692308, size.height * 0.4423077);
    path_0.lineTo(size.width * 0.7692308, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.9230769, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.9230769, size.height * 0.4423077);
    path_0.close();
    path_0.moveTo(size.width * 0.5576923, size.height * 0.8461538);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.7692308);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.7692308);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.8461538);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.8461538);
    path_0.close();
    path_0.moveTo(size.width * 0.4423077, size.height * 0.7692308);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.9230769);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.9230769);
    path_0.lineTo(size.width * 0.5576923, size.height * 0.7692308);
    path_0.lineTo(size.width * 0.4423077, size.height * 0.7692308);
    path_0.close();
    path_0.moveTo(size.width * 0.1538462, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.2307692, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.2307692, size.height * 0.4423077);
    path_0.lineTo(size.width * 0.1538462, size.height * 0.4423077);
    path_0.lineTo(size.width * 0.1538462, size.height * 0.5576923);
    path_0.close();
    path_0.moveTo(size.width * 0.2307692, size.height * 0.4423077);
    path_0.lineTo(size.width * 0.07692308, size.height * 0.4423077);
    path_0.lineTo(size.width * 0.07692308, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.2307692, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.2307692, size.height * 0.4423077);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = color;
    canvas.drawPath(path_0, paint_0_fill);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = color;
    canvas.drawCircle(Offset(size.width * 0.5000000, size.height * 0.5000000),
        size.width * 0.1153846, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
