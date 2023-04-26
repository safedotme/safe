//Copy this CustomPainter code to the Bottom of the File
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class PlayLargeIcon extends CustomPainter {
  final Color color;

  PlayLargeIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.7950000, size.height * 0.3254909);
    path_0.cubicTo(
        size.width * 0.9032950,
        size.height * 0.3823305,
        size.width * 0.9574400,
        size.height * 0.4107500,
        size.width * 0.9756150,
        size.height * 0.4478536);
    path_0.cubicTo(
        size.width * 0.9914650,
        size.height * 0.4802182,
        size.width * 0.9914650,
        size.height * 0.5171727,
        size.width * 0.9756150,
        size.height * 0.5495364);
    path_0.cubicTo(
        size.width * 0.9574400,
        size.height * 0.5866409,
        size.width * 0.9032950,
        size.height * 0.6150591,
        size.width * 0.7950000,
        size.height * 0.6719000);
    path_0.lineTo(size.width * 0.3300000, size.height * 0.9159636);
    path_0.cubicTo(
        size.width * 0.2217060,
        size.height * 0.9728000,
        size.width * 0.1675590,
        size.height * 1.001223,
        size.width * 0.1231275,
        size.height * 0.9969773);
    path_0.cubicTo(
        size.width * 0.08437200,
        size.height * 0.9932727,
        size.width * 0.04916540,
        size.height * 0.9747955,
        size.width * 0.02626015,
        size.height * 0.9461364);
    path_0.cubicTo(0, size.height * 0.9132773, 0, size.height * 0.8564364, 0,
        size.height * 0.7427591);
    path_0.lineTo(0, size.height * 0.2546336);
    path_0.cubicTo(0, size.height * 0.1409550, 0, size.height * 0.08411545,
        size.width * 0.02626015, size.height * 0.05125727);
    path_0.cubicTo(
        size.width * 0.04916540,
        size.height * 0.02259677,
        size.width * 0.08437200,
        size.height * 0.004118032,
        size.width * 0.1231275,
        size.height * 0.0004149977);
    path_0.cubicTo(
        size.width * 0.1675590,
        size.height * -0.003830423,
        size.width * 0.2217060,
        size.height * 0.02458936,
        size.width * 0.3300000,
        size.height * 0.08142909);
    path_0.lineTo(size.width * 0.7950000, size.height * 0.3254909);
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
