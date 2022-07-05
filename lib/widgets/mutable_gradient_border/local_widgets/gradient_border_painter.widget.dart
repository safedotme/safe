import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class GradientBorderPainter extends CustomPainter {
  final double width;
  final double borderRadius;

  GradientBorderPainter({
    required this.width,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(
      Offset(size.width, size.height),
      Offset(0, 0),
    );

    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: kPrimaryGradientColors,
        begin: Alignment(-1.5, 1.5),
        end: Alignment(1, -1),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
