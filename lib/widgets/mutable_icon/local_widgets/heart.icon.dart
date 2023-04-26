// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class HeartIcon extends CustomPainter {
  final Color color;

  HeartIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.3335112);
    path_0.cubicTo(
        0,
        size.height * 0.5613662,
        size.width * 0.1773718,
        size.height * 0.7865500,
        size.width * 0.4530635,
        size.height * 0.9786563);
    path_0.cubicTo(
        size.width * 0.4683794,
        size.height * 0.9893250,
        size.width * 0.4871541,
        size.height,
        size.width * 0.5000000,
        size.height);
    path_0.cubicTo(
        size.width * 0.5128459,
        size.height,
        size.width * 0.5316206,
        size.height * 0.9893250,
        size.width * 0.5469365,
        size.height * 0.9786563);
    path_0.cubicTo(size.width * 0.8231235, size.height * 0.7865500, size.width,
        size.height * 0.5613662, size.width, size.height * 0.3335112);
    path_0.cubicTo(size.width, size.height * 0.1366063, size.width * 0.8740118,
        0, size.width * 0.7124529, 0);
    path_0.cubicTo(
        size.width * 0.6180824,
        0,
        size.width * 0.5444665,
        size.height * 0.04642475,
        size.width * 0.5000000,
        size.height * 0.1168625);
    path_0.cubicTo(size.width * 0.4565218, size.height * 0.04695837,
        size.width * 0.3824112, 0, size.width * 0.2880435, 0);
    path_0.cubicTo(size.width * 0.1259882, 0, 0, size.height * 0.1366063, 0,
        size.height * 0.3335112);
    path_0.close();
    path_0.moveTo(size.width * 0.1017788, size.height * 0.3329775);
    path_0.cubicTo(
        size.width * 0.1017788,
        size.height * 0.1985056,
        size.width * 0.1837947,
        size.height * 0.1072575,
        size.width * 0.2939724,
        size.height * 0.1072575);
    path_0.cubicTo(
        size.width * 0.3829053,
        size.height * 0.1072575,
        size.width * 0.4328065,
        size.height * 0.1654212,
        size.width * 0.4639329,
        size.height * 0.2161150);
    path_0.cubicTo(
        size.width * 0.4777671,
        size.height * 0.2379938,
        size.width * 0.4871541,
        size.height * 0.2449306,
        size.width * 0.5000000,
        size.height * 0.2449306);
    path_0.cubicTo(
        size.width * 0.5133400,
        size.height * 0.2449306,
        size.width * 0.5217394,
        size.height * 0.2374600,
        size.width * 0.5360671,
        size.height * 0.2161150);
    path_0.cubicTo(
        size.width * 0.5696641,
        size.height * 0.1664887,
        size.width * 0.6175882,
        size.height * 0.1072575,
        size.width * 0.7060294,
        size.height * 0.1072575);
    path_0.cubicTo(
        size.width * 0.8167000,
        size.height * 0.1072575,
        size.width * 0.8987176,
        size.height * 0.1985056,
        size.width * 0.8987176,
        size.height * 0.3329775);
    path_0.cubicTo(
        size.width * 0.8987176,
        size.height * 0.5208112,
        size.width * 0.7178882,
        size.height * 0.7289250,
        size.width * 0.5093871,
        size.height * 0.8783375);
    path_0.cubicTo(
        size.width * 0.5049406,
        size.height * 0.8815375,
        size.width * 0.5019765,
        size.height * 0.8836688,
        size.width * 0.5000000,
        size.height * 0.8836688);
    path_0.cubicTo(
        size.width * 0.4980235,
        size.height * 0.8836688,
        size.width * 0.4950594,
        size.height * 0.8815375,
        size.width * 0.4911065,
        size.height * 0.8783375);
    path_0.cubicTo(
        size.width * 0.2826088,
        size.height * 0.7289250,
        size.width * 0.1017788,
        size.height * 0.5208112,
        size.width * 0.1017788,
        size.height * 0.3329775);
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
