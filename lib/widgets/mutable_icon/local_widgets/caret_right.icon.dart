import 'package:flutter/material.dart';

class CaretRightIcon extends CustomPainter {
  final Color color;

  CaretRightIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.6129825, size.height * 0.5029740);
    path_0.cubicTo(
        size.width * 0.6184137,
        size.height * 0.5058633,
        size.width * 0.6227238,
        size.height * 0.5092967,
        size.width * 0.6256650,
        size.height * 0.5130767);
    path_0.cubicTo(
        size.width * 0.6286050,
        size.height * 0.5168560,
        size.width * 0.6301187,
        size.height * 0.5209080,
        size.width * 0.6301187,
        size.height * 0.5250000);
    path_0.cubicTo(
        size.width * 0.6301187,
        size.height * 0.5290920,
        size.width * 0.6286050,
        size.height * 0.5331440,
        size.width * 0.6256650,
        size.height * 0.5369233);
    path_0.cubicTo(
        size.width * 0.6227238,
        size.height * 0.5407033,
        size.width * 0.6184137,
        size.height * 0.5441367,
        size.width * 0.6129825,
        size.height * 0.5470260);
    path_0.lineTo(size.width * 0.07795763, size.height * 0.8323133);
    path_0.cubicTo(
        size.width * 0.04512875,
        size.height * 0.8498133,
        size.width * 0.02667962,
        size.height * 0.8735467,
        size.width * 0.02666863,
        size.height * 0.8983067);
    path_0.cubicTo(
        size.width * 0.02665775,
        size.height * 0.9230600,
        size.width * 0.04508600,
        size.height * 0.9468067,
        size.width * 0.07789925,
        size.height * 0.9643133);
    path_0.cubicTo(
        size.width * 0.1107126,
        size.height * 0.9818200,
        size.width * 0.1552237,
        size.height * 0.9916600,
        size.width * 0.2016388,
        size.height * 0.9916667);
    path_0.cubicTo(
        size.width * 0.2480550,
        size.height * 0.9916733,
        size.width * 0.2925750,
        size.height * 0.9818467,
        size.width * 0.3254037,
        size.height * 0.9643467);
    path_0.lineTo(size.width * 0.8604275, size.height * 0.6790000);
    path_0.cubicTo(
        size.width * 0.9368700,
        size.height * 0.6381160,
        size.width * 0.9797975,
        size.height * 0.5827360,
        size.width * 0.9797975,
        size.height * 0.5250000);
    path_0.cubicTo(
        size.width * 0.9797975,
        size.height * 0.4672640,
        size.width * 0.9368700,
        size.height * 0.4118840,
        size.width * 0.8604275,
        size.height * 0.3710027);
    path_0.lineTo(size.width * 0.3254037, size.height * 0.08565667);
    path_0.cubicTo(
        size.width * 0.2925750,
        size.height * 0.06815600,
        size.width * 0.2480550,
        size.height * 0.05832747,
        size.width * 0.2016388,
        size.height * 0.05833333);
    path_0.cubicTo(
        size.width * 0.1552237,
        size.height * 0.05833920,
        size.width * 0.1107126,
        size.height * 0.06817867,
        size.width * 0.07789925,
        size.height * 0.08568733);
    path_0.cubicTo(
        size.width * 0.04508600,
        size.height * 0.1031960,
        size.width * 0.02665775,
        size.height * 0.1269400,
        size.width * 0.02666863,
        size.height * 0.1516947);
    path_0.cubicTo(
        size.width * 0.02667962,
        size.height * 0.1764500,
        size.width * 0.04512875,
        size.height * 0.2001893,
        size.width * 0.07795763,
        size.height * 0.2176900);
    path_0.lineTo(size.width * 0.6129825, size.height * 0.5029740);
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
