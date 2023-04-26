// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class StopRecordingIcon extends CustomPainter {
  final Color color;

  StopRecordingIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4997582, size.height);
    path_0.cubicTo(size.width * 0.7738059, size.height, size.width,
        size.height * 0.7736941, size.width, size.height * 0.5000000);
    path_0.cubicTo(size.width, size.height * 0.2263059, size.width * 0.7733176,
        0, size.width * 0.4992753, 0);
    path_0.cubicTo(size.width * 0.2257129, 0, 0, size.height * 0.2263059, 0,
        size.height * 0.5000000);
    path_0.cubicTo(0, size.height * 0.7736941, size.width * 0.2261965,
        size.height, size.width * 0.4997582, size.height);
    path_0.close();
    path_0.moveTo(size.width * 0.4997582, size.height * 0.9003882);
    path_0.cubicTo(
        size.width * 0.2779118,
        size.height * 0.9003882,
        size.width * 0.1005318,
        size.height * 0.7219529,
        size.width * 0.1005318,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.1005318,
        size.height * 0.2780465,
        size.width * 0.2779118,
        size.height * 0.1000965,
        size.width * 0.4992753,
        size.height * 0.1000965);
    path_0.cubicTo(
        size.width * 0.7211235,
        size.height * 0.1000965,
        size.width * 0.8994706,
        size.height * 0.2780465,
        size.width * 0.8999529,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9004353,
        size.height * 0.7219529,
        size.width * 0.7216059,
        size.height * 0.9003882,
        size.width * 0.4997582,
        size.height * 0.9003882);
    path_0.close();
    path_0.moveTo(size.width * 0.3238276, size.height * 0.6276588);
    path_0.cubicTo(
        size.width * 0.3238276,
        size.height * 0.6576412,
        size.width * 0.3431612,
        size.height * 0.6760176,
        size.width * 0.3740935,
        size.height * 0.6760176);
    path_0.lineTo(size.width * 0.6249412, size.height * 0.6760176);
    path_0.cubicTo(
        size.width * 0.6558706,
        size.height * 0.6760176,
        size.width * 0.6752059,
        size.height * 0.6576412,
        size.width * 0.6752059,
        size.height * 0.6276588);
    path_0.lineTo(size.width * 0.6752059, size.height * 0.3728241);
    path_0.cubicTo(
        size.width * 0.6752059,
        size.height * 0.3428435,
        size.width * 0.6558706,
        size.height * 0.3244682,
        size.width * 0.6249412,
        size.height * 0.3244682);
    path_0.lineTo(size.width * 0.3740935, size.height * 0.3244682);
    path_0.cubicTo(
        size.width * 0.3431612,
        size.height * 0.3244682,
        size.width * 0.3238276,
        size.height * 0.3428435,
        size.width * 0.3238276,
        size.height * 0.3728241);
    path_0.lineTo(size.width * 0.3238276, size.height * 0.6276588);
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
