import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class PanelPopupPainter extends CustomPainter {
  final Color? borderColor;

  PanelPopupPainter({this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(Offset(0, 0), Offset(size.width, size.height));
    Color color = borderColor ?? kColorMap[MutableColor.neutral7]!;

    Paint paint = Paint()
      // Adds disapearing border by transitioning color to 0 opacity
      ..shader = LinearGradient(
        colors: [
          color,
          color.withOpacity(0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        // Gives gradient exact stops to generate transition
        stops: [0, 40 / size.height],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Adds rounded corner
    RRect rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: Radius.circular(kPanelPopupBorderRadius),
      topRight: Radius.circular(kPanelPopupBorderRadius),
    );

    canvas.drawRRect(rrect, paint);
  }

  // Set to true for state purposes
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
