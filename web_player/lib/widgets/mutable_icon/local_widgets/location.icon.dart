// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class LocationIcon extends CustomPainter {
  final Color color;

  LocationIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.04929358, size.height * 0.4031585);
    path_0.cubicTo(
        size.width * -0.02758458,
        size.height * 0.4357531,
        size.width * -0.01150550,
        size.height * 0.5353977,
        size.width * 0.07642708,
        size.height * 0.5358638);
    path_0.lineTo(size.width * 0.4502658, size.height * 0.5372600);
    path_0.cubicTo(
        size.width * 0.4578033,
        size.height * 0.5372600,
        size.width * 0.4603158,
        size.height * 0.5400538,
        size.width * 0.4603158,
        size.height * 0.5470385);
    path_0.lineTo(size.width * 0.4613208, size.height * 0.8911385);
    path_0.cubicTo(
        size.width * 0.4613208,
        size.height * 0.9712308,
        size.width * 0.5693517,
        size.height * 0.9893846,
        size.width * 0.6075400,
        size.height * 0.9120923);
    path_0.lineTo(size.width * 0.9879083, size.height * 0.1493900);
    path_0.cubicTo(
        size.width * 1.028608,
        size.height * 0.06790462,
        size.width * 0.9602750,
        size.height * 0.01389146,
        size.width * 0.8763583,
        size.height * 0.04974500);
    path_0.lineTo(size.width * 0.04929358, size.height * 0.4031585);
    path_0.close();
    path_0.moveTo(size.width * 0.1688817, size.height * 0.4520500);
    path_0.cubicTo(
        size.width * 0.1648625,
        size.height * 0.4520500,
        size.width * 0.1633550,
        size.height * 0.4478592,
        size.width * 0.1678767,
        size.height * 0.4455308);
    path_0.lineTo(size.width * 0.8763583, size.height * 0.1451992);
    path_0.cubicTo(
        size.width * 0.8823917,
        size.height * 0.1428715,
        size.width * 0.8859083,
        size.height * 0.1461308,
        size.width * 0.8828917,
        size.height * 0.1517185);
    path_0.lineTo(size.width * 0.5582975, size.height * 0.8063923);
    path_0.cubicTo(
        size.width * 0.5562875,
        size.height * 0.8110538,
        size.width * 0.5512625,
        size.height * 0.8101231,
        size.width * 0.5512625,
        size.height * 0.8059308);
    path_0.lineTo(size.width * 0.5532725, size.height * 0.4925600);
    path_0.cubicTo(
        size.width * 0.5532725,
        size.height * 0.4641562,
        size.width * 0.5387008,
        size.height * 0.4501877,
        size.width * 0.5070450,
        size.height * 0.4501877);
    path_0.lineTo(size.width * 0.1688817, size.height * 0.4520500);
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
