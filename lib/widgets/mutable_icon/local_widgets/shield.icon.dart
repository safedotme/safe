import 'package:flutter/material.dart';

class ShieldIcon extends CustomPainter {
  final Color color;

  ShieldIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4719427, size.height);
    path_0.cubicTo(
        size.width * 0.4819960,
        size.height,
        size.width * 0.4970760,
        size.height * 0.9970529,
        size.width * 0.5115973,
        size.height * 0.9901706);
    path_0.cubicTo(
        size.width * 0.8327400,
        size.height * 0.8363647,
        size.width * 0.9444467,
        size.height * 0.7651118,
        size.width * 0.9444467,
        size.height * 0.5862406);
    path_0.lineTo(size.width * 0.9444467, size.height * 0.2152335);
    path_0.cubicTo(
        size.width * 0.9444467,
        size.height * 0.1562653,
        size.width * 0.9187533,
        size.height * 0.1351353,
        size.width * 0.8623400,
        size.height * 0.1140047);
    path_0.cubicTo(
        size.width * 0.8009067,
        size.height * 0.09090882,
        size.width * 0.5920233,
        size.height * 0.02702700,
        size.width * 0.5317040,
        size.height * 0.008845235);
    path_0.cubicTo(size.width * 0.5127147, size.height * 0.003439806,
        size.width * 0.4914907, 0, size.width * 0.4719427, 0);
    path_0.cubicTo(
        size.width * 0.4529533,
        0,
        size.width * 0.4311713,
        size.height * 0.004422606,
        size.width * 0.4127407,
        size.height * 0.008845235);
    path_0.cubicTo(
        size.width * 0.3524213,
        size.height * 0.02407865,
        size.width * 0.1435380,
        size.height * 0.09140059,
        size.width * 0.08210133,
        size.height * 0.1140047);
    path_0.cubicTo(size.width * 0.02569160, size.height * 0.1346435, 0,
        size.height * 0.1562653, 0, size.height * 0.2152335);
    path_0.lineTo(0, size.height * 0.5862406);
    path_0.cubicTo(
        0,
        size.height * 0.7651118,
        size.width * 0.1117027,
        size.height * 0.8353824,
        size.width * 0.4328473,
        size.height * 0.9901706);
    path_0.cubicTo(
        size.width * 0.4473687,
        size.height * 0.9970529,
        size.width * 0.4624480,
        size.height,
        size.width * 0.4719427,
        size.height);
    path_0.close();
    path_0.moveTo(size.width * 0.4719427, size.height * 0.8958235);
    path_0.cubicTo(
        size.width * 0.4641240,
        size.height * 0.8958235,
        size.width * 0.4563047,
        size.height * 0.8933647,
        size.width * 0.4401080,
        size.height * 0.8845235);
    path_0.cubicTo(
        size.width * 0.1854260,
        size.height * 0.7479118,
        size.width * 0.1061173,
        size.height * 0.7110588,
        size.width * 0.1061173,
        size.height * 0.5680588);
    path_0.lineTo(size.width * 0.1061173, size.height * 0.4879606);
    path_0.lineTo(size.width * 0.4814380, size.height * 0.4879606);
    path_0.lineTo(size.width * 0.4814380, size.height * 0.09434882);
    path_0.cubicTo(
        size.width * 0.4870227,
        size.height * 0.09533176,
        size.width * 0.4937247,
        size.height * 0.09680588,
        size.width * 0.5021027,
        size.height * 0.09926294);
    path_0.cubicTo(
        size.width * 0.5758260,
        size.height * 0.1248159,
        size.width * 0.7350000,
        size.height * 0.1744471,
        size.width * 0.8182200,
        size.height * 0.2004912);
    path_0.cubicTo(
        size.width * 0.8344200,
        size.height * 0.2058971,
        size.width * 0.8383267,
        size.height * 0.2132676,
        size.width * 0.8383267,
        size.height * 0.2309582);
    path_0.lineTo(size.width * 0.8383267, size.height * 0.4879606);
    path_0.lineTo(size.width * 0.4814380, size.height * 0.4879606);
    path_0.lineTo(size.width * 0.4814380, size.height * 0.8943471);
    path_0.cubicTo(
        size.width * 0.4780867,
        size.height * 0.8953294,
        size.width * 0.4752940,
        size.height * 0.8958235,
        size.width * 0.4719427,
        size.height * 0.8958235);
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
