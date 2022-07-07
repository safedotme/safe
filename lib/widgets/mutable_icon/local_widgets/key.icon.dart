import 'package:flutter/material.dart';

class KeyIcon extends CustomPainter {
  final Color color;
  KeyIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5001781, size.height * 0.06250000);
    path_0.cubicTo(
        size.width * 0.3720844,
        size.height * 0.06250000,
        size.width * 0.2703094,
        size.height * 0.1646244,
        size.width * 0.2703094,
        size.height * 0.2920169);
    path_0.cubicTo(
        size.width * 0.2703094,
        size.height * 0.3864219,
        size.width * 0.3257594,
        size.height * 0.4699437,
        size.width * 0.4134937,
        size.height * 0.5050406);
    path_0.lineTo(size.width * 0.4134937, size.height * 0.8451031);
    path_0.cubicTo(
        size.width * 0.4134937,
        size.height * 0.8552812,
        size.width * 0.4166531,
        size.height * 0.8644063,
        size.width * 0.4243750,
        size.height * 0.8721250);
    path_0.lineTo(size.width * 0.4854375, size.height * 0.9310844);
    path_0.cubicTo(
        size.width * 0.4931594,
        size.height * 0.9388062,
        size.width * 0.5078969,
        size.height * 0.9405594,
        size.width * 0.5177250,
        size.height * 0.9307344);
    path_0.lineTo(size.width * 0.6282719, size.height * 0.8201875);
    path_0.cubicTo(
        size.width * 0.6384500,
        size.height * 0.8100094,
        size.width * 0.6380969,
        size.height * 0.7952687,
        size.width * 0.6282719,
        size.height * 0.7854437);
    path_0.lineTo(size.width * 0.5647500, size.height * 0.7226250);
    path_0.lineTo(size.width * 0.6538906, size.height * 0.6334844);
    path_0.cubicTo(
        size.width * 0.6630156,
        size.height * 0.6240094,
        size.width * 0.6633656,
        size.height * 0.6092688,
        size.width * 0.6531875,
        size.height * 0.5990937);
    path_0.lineTo(size.width * 0.5665062, size.height * 0.5120594);
    path_0.cubicTo(
        size.width * 0.6714375,
        size.height * 0.4674875,
        size.width * 0.7296938,
        size.height * 0.3871219,
        size.width * 0.7296938,
        size.height * 0.2920169);
    path_0.cubicTo(
        size.width * 0.7296938,
        size.height * 0.1649753,
        size.width * 0.6275688,
        size.height * 0.06250000,
        size.width * 0.5001781,
        size.height * 0.06250000);
    path_0.close();
    path_0.moveTo(size.width * 0.5001781, size.height * 0.2758734);
    path_0.cubicTo(
        size.width * 0.4661344,
        size.height * 0.2758734,
        size.width * 0.4384125,
        size.height * 0.2481491,
        size.width * 0.4384125,
        size.height * 0.2141075);
    path_0.cubicTo(
        size.width * 0.4384125,
        size.height * 0.1797150,
        size.width * 0.4657844,
        size.height * 0.1523416,
        size.width * 0.5001781,
        size.height * 0.1523416);
    path_0.cubicTo(
        size.width * 0.5342187,
        size.height * 0.1523416,
        size.width * 0.5619437,
        size.height * 0.1800659,
        size.width * 0.5619437,
        size.height * 0.2141075);
    path_0.cubicTo(
        size.width * 0.5619437,
        size.height * 0.2481491,
        size.width * 0.5342187,
        size.height * 0.2758734,
        size.width * 0.5001781,
        size.height * 0.2758734);
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
