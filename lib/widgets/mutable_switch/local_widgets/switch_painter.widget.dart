import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class SwitchPainter extends CustomPainter {
  final double pos;

  SwitchPainter(this.pos);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    final thumb = Rect.fromCircle(
      center: Offset(17 + (18 * pos), size.height / 2),
      radius: (size.height - 4) / 2,
    );

    // TRACK (ie. background color)
    paint.color = kColorMap[MutableColor.neutral5]!;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect,
        Radius.circular(20),
      ),
      paint,
    );

    // GRADIENT
    paint.shader = LinearGradient(
      colors: kPrimaryGradientColors
          .map(
            (color) => color.withOpacity(pos),
          )
          .toList(),
      begin: Alignment(-1.4, -1.4),
      end: Alignment(1.4, 1.4),
    ).createShader(rect);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        rect,
        Radius.circular(20),
      ),
      paint,
    );

    // THUMB
    paint.shader = LinearGradient(
      colors: [Colors.white, Colors.white],
    ).createShader(rect);

    canvas.drawShadow(
      Path()..addOval(thumb),
      Colors.black,
      2,
      false,
    );

    canvas.drawOval(
      thumb,
      paint,
    );
  }

  @override
  bool shouldRepaint(SwitchPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SwitchPainter oldDelegate) => false;
}
