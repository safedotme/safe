// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class CloudIcon extends CustomPainter {
  final Color color;

  CloudIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7651176, size.height);
    path_0.cubicTo(
        size.width * 0.8800059,
        size.height,
        size.width * 0.9705882,
        size.height * 0.8712036,
        size.width * 0.9705882,
        size.height * 0.7103491);
    path_0.cubicTo(
        size.width * 0.9705882,
        size.height * 0.5905509,
        size.width * 0.9260353,
        size.height * 0.4842518,
        size.width * 0.8527588,
        size.height * 0.4375700);
    path_0.cubicTo(size.width * 0.8531235, size.height * 0.1833518,
        size.width * 0.7330824, 0, size.width * 0.5787994, 0);
    path_0.cubicTo(
        size.width * 0.4808524,
        0,
        size.width * 0.4072076,
        size.height * 0.07705291,
        size.width * 0.3611800,
        size.height * 0.1794155);
    path_0.cubicTo(
        size.width * 0.2676518,
        size.height * 0.1411700,
        size.width * 0.1693365,
        size.height * 0.2474691,
        size.width * 0.1656541,
        size.height * 0.4060745);
    path_0.cubicTo(
        size.width * 0.08133118,
        size.height * 0.4291336,
        size.width * 0.02941176,
        size.height * 0.5444318,
        size.width * 0.02941176,
        size.height * 0.6856018);
    path_0.cubicTo(
        size.width * 0.02941176,
        size.height * 0.8565809,
        size.width * 0.1273588,
        size.height * 0.9994364,
        size.width * 0.2562365,
        size.height * 0.9994364);
    path_0.lineTo(size.width * 0.7651176, size.height);
    path_0.close();
    path_0.moveTo(size.width * 0.7651176, size.height * 0.8875145);
    path_0.lineTo(size.width * 0.2566047, size.height * 0.8875145);
    path_0.cubicTo(
        size.width * 0.1689682,
        size.height * 0.8875145,
        size.width * 0.1037929,
        size.height * 0.7941509,
        size.width * 0.1037929,
        size.height * 0.6856018);
    path_0.cubicTo(
        size.width * 0.1037929,
        size.height * 0.5731155,
        size.width * 0.1490841,
        size.height * 0.4898764,
        size.width * 0.2242012,
        size.height * 0.4898764);
    path_0.cubicTo(
        size.width * 0.2297247,
        size.height * 0.4898764,
        size.width * 0.2319341,
        size.height * 0.4853773,
        size.width * 0.2315659,
        size.height * 0.4775027);
    path_0.cubicTo(
        size.width * 0.2293565,
        size.height * 0.3104609,
        size.width * 0.3077876,
        size.height * 0.2530936,
        size.width * 0.3869559,
        size.height * 0.2913382);
    path_0.cubicTo(
        size.width * 0.3917424,
        size.height * 0.2935882,
        size.width * 0.3946882,
        size.height * 0.2919009,
        size.width * 0.3968976,
        size.height * 0.2857145);
    path_0.cubicTo(
        size.width * 0.4333518,
        size.height * 0.1878518,
        size.width * 0.4871124,
        size.height * 0.1119236,
        size.width * 0.5784312,
        size.height * 0.1119236);
    path_0.cubicTo(
        size.width * 0.6940529,
        size.height * 0.1119236,
        size.width * 0.7765353,
        size.height * 0.2519682,
        size.width * 0.7820588,
        size.height * 0.4156355);
    path_0.cubicTo(
        size.width * 0.7831647,
        size.height * 0.4460064,
        size.width * 0.7816882,
        size.height * 0.4786273,
        size.width * 0.7802176,
        size.height * 0.5056245);
    path_0.cubicTo(
        size.width * 0.7794824,
        size.height * 0.5134982,
        size.width * 0.7816882,
        size.height * 0.5179982,
        size.width * 0.7864765,
        size.height * 0.5191227);
    path_0.cubicTo(
        size.width * 0.8531235,
        size.height * 0.5388073,
        size.width * 0.8962059,
        size.height * 0.6107991,
        size.width * 0.8962059,
        size.height * 0.7103491);
    path_0.cubicTo(
        size.width * 0.8962059,
        size.height * 0.8087736,
        size.width * 0.8391353,
        size.height * 0.8875145,
        size.width * 0.7651176,
        size.height * 0.8875145);
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
