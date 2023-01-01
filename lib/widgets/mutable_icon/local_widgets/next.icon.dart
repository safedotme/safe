//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

class NextIcon extends CustomPainter {
  final Color color;

  NextIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4997591, size.height * 0.9995182);
    path_0.cubicTo(size.width * 0.7738045, size.height * 0.9995182, size.width,
        size.height * 0.7733182, size.width, size.height * 0.4997591);
    path_0.cubicTo(size.width, size.height * 0.2261964, size.width * 0.7733227,
        0, size.width * 0.4992773, 0);
    path_0.cubicTo(size.width * 0.2257127, 0, 0, size.height * 0.2261964, 0,
        size.height * 0.4997591);
    path_0.cubicTo(
        0,
        size.height * 0.7733182,
        size.width * 0.2261964,
        size.height * 0.9995182,
        size.width * 0.4997591,
        size.height * 0.9995182);
    path_0.close();
    path_0.moveTo(size.width * 0.4997591, size.height * 0.8999500);
    path_0.cubicTo(
        size.width * 0.2779123,
        size.height * 0.8999500,
        size.width * 0.1005318,
        size.height * 0.7216045,
        size.width * 0.1005318,
        size.height * 0.4997591);
    path_0.cubicTo(
        size.width * 0.1005318,
        size.height * 0.2779118,
        size.width * 0.2779123,
        size.height * 0.1000482,
        size.width * 0.4992773,
        size.height * 0.1000482);
    path_0.cubicTo(
        size.width * 0.7211227,
        size.height * 0.1000482,
        size.width * 0.8994682,
        size.height * 0.2779118,
        size.width * 0.8999500,
        size.height * 0.4997591);
    path_0.cubicTo(
        size.width * 0.9004364,
        size.height * 0.7216045,
        size.width * 0.7216045,
        size.height * 0.8999500,
        size.width * 0.4997591,
        size.height * 0.8999500);
    path_0.close();
    path_0.moveTo(size.width * 0.7491545, size.height * 0.4997591);
    path_0.cubicTo(
        size.width * 0.7491545,
        size.height * 0.4867091,
        size.width * 0.7443227,
        size.height * 0.4760773,
        size.width * 0.7332045,
        size.height * 0.4654409);
    path_0.lineTo(size.width * 0.5688727, size.height * 0.3035282);
    path_0.cubicTo(
        size.width * 0.5611409,
        size.height * 0.2957950,
        size.width * 0.5514727,
        size.height * 0.2919286,
        size.width * 0.5398727,
        size.height * 0.2919286);
    path_0.cubicTo(
        size.width * 0.5171591,
        size.height * 0.2919286,
        size.width * 0.5007273,
        size.height * 0.3088450,
        size.width * 0.5007273,
        size.height * 0.3315609);
    path_0.cubicTo(
        size.width * 0.5007273,
        size.height * 0.3436441,
        size.width * 0.5060409,
        size.height * 0.3537941,
        size.width * 0.5132909,
        size.height * 0.3610441);
    path_0.lineTo(size.width * 0.5717727, size.height * 0.4171095);
    path_0.lineTo(size.width * 0.6259045, size.height * 0.4610909);
    path_0.lineTo(size.width * 0.5273091, size.height * 0.4562591);
    path_0.lineTo(size.width * 0.2914450, size.height * 0.4562591);
    path_0.cubicTo(
        size.width * 0.2667955,
        size.height * 0.4562591,
        size.width * 0.2493959,
        size.height * 0.4746273,
        size.width * 0.2493959,
        size.height * 0.4997591);
    path_0.cubicTo(
        size.width * 0.2493959,
        size.height * 0.5244091,
        size.width * 0.2667955,
        size.height * 0.5432591,
        size.width * 0.2914450,
        size.height * 0.5432591);
    path_0.lineTo(size.width * 0.5273091, size.height * 0.5432591);
    path_0.lineTo(size.width * 0.6263909, size.height * 0.5389091);
    path_0.lineTo(size.width * 0.5722591, size.height * 0.5824091);
    path_0.lineTo(size.width * 0.5132909, size.height * 0.6384727);
    path_0.cubicTo(
        size.width * 0.5050727,
        size.height * 0.6457227,
        size.width * 0.5007273,
        size.height * 0.6558727,
        size.width * 0.5007273,
        size.height * 0.6679545);
    path_0.cubicTo(
        size.width * 0.5007273,
        size.height * 0.6906727,
        size.width * 0.5171591,
        size.height * 0.7080727,
        size.width * 0.5398727,
        size.height * 0.7080727);
    path_0.cubicTo(
        size.width * 0.5514727,
        size.height * 0.7080727,
        size.width * 0.5611409,
        size.height * 0.7037227,
        size.width * 0.5688727,
        size.height * 0.6959864);
    path_0.lineTo(size.width * 0.7332045, size.height * 0.5345591);
    path_0.cubicTo(
        size.width * 0.7438364,
        size.height * 0.5239227,
        size.width * 0.7491545,
        size.height * 0.5132909,
        size.width * 0.7491545,
        size.height * 0.4997591);
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
