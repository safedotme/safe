//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/material.dart';

class ProfileIcon extends CustomPainter {
  final Color color;
  ProfileIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5004563, size.height * 0.4883156);
    path_0.cubicTo(
        size.width * 0.5984219,
        size.height * 0.4883156,
        size.width * 0.6815594,
        size.height * 0.4011344,
        size.width * 0.6815594,
        size.height * 0.2883366);
    path_0.cubicTo(
        size.width * 0.6815594,
        size.height * 0.1782356,
        size.width * 0.5979719,
        size.height * 0.09375000,
        size.width * 0.5004563,
        size.height * 0.09375000);
    path_0.cubicTo(
        size.width * 0.4024875,
        size.height * 0.09375000,
        size.width * 0.3184500,
        size.height * 0.1795837,
        size.width * 0.3189000,
        size.height * 0.2892353);
    path_0.cubicTo(
        size.width * 0.3189000,
        size.height * 0.4011344,
        size.width * 0.4020375,
        size.height * 0.4883156,
        size.width * 0.5004563,
        size.height * 0.4883156);
    path_0.close();
    path_0.moveTo(size.width * 0.2200347, size.height * 0.9062500);
    path_0.lineTo(size.width * 0.7799781, size.height * 0.9062500);
    path_0.cubicTo(
        size.width * 0.8541250,
        size.height * 0.9062500,
        size.width * 0.8797406,
        size.height * 0.8837812,
        size.width * 0.8797406,
        size.height * 0.8424375);
    path_0.cubicTo(
        size.width * 0.8797406,
        size.height * 0.7269437,
        size.width * 0.7332406,
        size.height * 0.5678594,
        size.width * 0.5000062,
        size.height * 0.5678594);
    path_0.cubicTo(
        size.width * 0.2672209,
        size.height * 0.5678594,
        size.width * 0.1202697,
        size.height * 0.7269437,
        size.width * 0.1202697,
        size.height * 0.8424375);
    path_0.cubicTo(
        size.width * 0.1202697,
        size.height * 0.8837812,
        size.width * 0.1458850,
        size.height * 0.9062500,
        size.width * 0.2200347,
        size.height * 0.9062500);
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
