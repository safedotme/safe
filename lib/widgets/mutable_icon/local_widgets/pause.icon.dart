import 'package:flutter/material.dart';

class PauseIcon extends CustomPainter {
  final Color color;

  PauseIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1219069, size.height);
    path_0.lineTo(size.width * 0.2984394, size.height);
    path_0.cubicTo(
        size.width * 0.3698031,
        size.height,
        size.width * 0.4066125,
        size.height * 0.9705550,
        size.width * 0.4066125,
        size.height * 0.9134600);
    path_0.lineTo(size.width * 0.4066125, size.height * 0.08653850);
    path_0.cubicTo(
        size.width * 0.4066125,
        size.height * 0.02824520,
        size.width * 0.3698031,
        size.height * 0.0006009600,
        size.width * 0.2984394,
        0);
    path_0.lineTo(size.width * 0.1219069, 0);
    path_0.cubicTo(
        size.width * 0.05054256,
        0,
        size.width * 0.01373369,
        size.height * 0.02944710,
        size.width * 0.01373369,
        size.height * 0.08653850);
    path_0.lineTo(size.width * 0.01373369, size.height * 0.9134600);
    path_0.cubicTo(
        size.width * 0.01298250,
        size.height * 0.9705550,
        size.width * 0.04979137,
        size.height,
        size.width * 0.1219069,
        size.height);
    path_0.close();
    path_0.moveTo(size.width * 0.6928188, size.height);
    path_0.lineTo(size.width * 0.8686000, size.height);
    path_0.cubicTo(
        size.width * 0.9399688,
        size.height,
        size.width * 0.9767750,
        size.height * 0.9705550,
        size.width * 0.9767750,
        size.height * 0.9134600);
    path_0.lineTo(size.width * 0.9767750, size.height * 0.08653850);
    path_0.cubicTo(size.width * 0.9767750, size.height * 0.02824520,
        size.width * 0.9399688, 0, size.width * 0.8686000, 0);
    path_0.lineTo(size.width * 0.6928188, 0);
    path_0.cubicTo(
        size.width * 0.6207050,
        0,
        size.width * 0.5846469,
        size.height * 0.02944710,
        size.width * 0.5846469,
        size.height * 0.08653850);
    path_0.lineTo(size.width * 0.5846469, size.height * 0.9134600);
    path_0.cubicTo(
        size.width * 0.5846469,
        size.height * 0.9705550,
        size.width * 0.6207050,
        size.height,
        size.width * 0.6928188,
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
