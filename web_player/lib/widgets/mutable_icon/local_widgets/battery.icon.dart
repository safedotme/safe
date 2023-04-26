// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class BatteryIcon extends CustomPainter {
  final Color color;

  BatteryIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1814412, size.height);
    path_0.lineTo(size.width * 0.6996529, size.height);
    path_0.cubicTo(
        size.width * 0.7598059,
        size.height,
        size.width * 0.8070647,
        size.height * 0.9857037,
        size.width * 0.8411059,
        size.height * 0.9120800);
    path_0.cubicTo(
        size.width * 0.8748176,
        size.height * 0.8384563,
        size.width * 0.8810941,
        size.height * 0.7376700,
        size.width * 0.8810941,
        size.height * 0.6075763);
    path_0.lineTo(size.width * 0.8810941, size.height * 0.3924238);
    path_0.cubicTo(
        size.width * 0.8810941,
        size.height * 0.2616150,
        size.width * 0.8748176,
        size.height * 0.1608287,
        size.width * 0.8411059,
        size.height * 0.08792000);
    path_0.cubicTo(size.width * 0.8067353, size.height * 0.01429587,
        size.width * 0.7598059, 0, size.width * 0.6996529, 0);
    path_0.lineTo(size.width * 0.1804494, 0);
    path_0.cubicTo(
        size.width * 0.1212912,
        0,
        size.width * 0.07403059,
        size.height * 0.01429587,
        size.width * 0.04032024,
        size.height * 0.08792000);
    path_0.cubicTo(size.width * 0.006279353, size.height * 0.1615438, 0,
        size.height * 0.2623300, 0, size.height * 0.3902788);
    path_0.lineTo(0, size.height * 0.6075763);
    path_0.cubicTo(
        0,
        size.height * 0.7376700,
        size.width * 0.006279353,
        size.height * 0.8391713,
        size.width * 0.03998976,
        size.height * 0.9120800);
    path_0.cubicTo(
        size.width * 0.07436118,
        size.height * 0.9857037,
        size.width * 0.1212912,
        size.height,
        size.width * 0.1814412,
        size.height);
    path_0.close();
    path_0.moveTo(size.width * 0.1721871, size.height * 0.8599000);
    path_0.cubicTo(
        size.width * 0.1381465,
        size.height * 0.8599000,
        size.width * 0.1060882,
        size.height * 0.8491775,
        size.width * 0.08758059,
        size.height * 0.8098637);
    path_0.cubicTo(
        size.width * 0.06907294,
        size.height * 0.7698350,
        size.width * 0.06477647,
        size.height * 0.7019300,
        size.width * 0.06477647,
        size.height * 0.6275913);
    path_0.lineTo(size.width * 0.06477647, size.height * 0.3738387);
    path_0.cubicTo(
        size.width * 0.06477647,
        size.height * 0.2987850,
        size.width * 0.06907294,
        size.height * 0.2301650,
        size.width * 0.08725059,
        size.height * 0.1901363);
    path_0.cubicTo(
        size.width * 0.1057582,
        size.height * 0.1501075,
        size.width * 0.1381465,
        size.height * 0.1401000,
        size.width * 0.1728482,
        size.height * 0.1401000);
    path_0.lineTo(size.width * 0.7089118, size.height * 0.1401000);
    path_0.cubicTo(
        size.width * 0.7432824,
        size.height * 0.1401000,
        size.width * 0.7753353,
        size.height * 0.1501075,
        size.width * 0.7935176,
        size.height * 0.1901363);
    path_0.cubicTo(
        size.width * 0.8120235,
        size.height * 0.2301650,
        size.width * 0.8163176,
        size.height * 0.2980700,
        size.width * 0.8163176,
        size.height * 0.3724088);
    path_0.lineTo(size.width * 0.8163176, size.height * 0.6275913);
    path_0.cubicTo(
        size.width * 0.8163176,
        size.height * 0.7019300,
        size.width * 0.8120235,
        size.height * 0.7698350,
        size.width * 0.7935176,
        size.height * 0.8098637);
    path_0.cubicTo(
        size.width * 0.7753353,
        size.height * 0.8498925,
        size.width * 0.7432824,
        size.height * 0.8599000,
        size.width * 0.7089118,
        size.height * 0.8599000);
    path_0.lineTo(size.width * 0.1721871, size.height * 0.8599000);
    path_0.close();
    path_0.moveTo(size.width * 0.1592982, size.height * 0.7698350);
    path_0.lineTo(size.width * 0.5548988, size.height * 0.7698350);
    path_0.cubicTo(
        size.width * 0.5753894,
        size.height * 0.7698350,
        size.width * 0.5876176,
        size.height * 0.7634025,
        size.width * 0.5962118,
        size.height * 0.7448175);
    path_0.cubicTo(
        size.width * 0.6044706,
        size.height * 0.7262325,
        size.width * 0.6077765,
        size.height * 0.6997850,
        size.width * 0.6077765,
        size.height * 0.6561825);
    path_0.lineTo(size.width * 0.6077765, size.height * 0.3438175);
    path_0.cubicTo(
        size.width * 0.6077765,
        size.height * 0.2995000,
        size.width * 0.6044706,
        size.height * 0.2730525,
        size.width * 0.5962118,
        size.height * 0.2551825);
    path_0.cubicTo(
        size.width * 0.5876176,
        size.height * 0.2365975,
        size.width * 0.5753894,
        size.height * 0.2301650,
        size.width * 0.5548988,
        size.height * 0.2301650);
    path_0.lineTo(size.width * 0.1599588, size.height * 0.2301650);
    path_0.cubicTo(
        size.width * 0.1388071,
        size.height * 0.2301650,
        size.width * 0.1265788,
        size.height * 0.2365975,
        size.width * 0.1179865,
        size.height * 0.2544675);
    path_0.cubicTo(
        size.width * 0.1097241,
        size.height * 0.2730525,
        size.width * 0.1064188,
        size.height * 0.3002150,
        size.width * 0.1064188,
        size.height * 0.3452462);
    path_0.lineTo(size.width * 0.1064188, size.height * 0.6561825);
    path_0.cubicTo(
        size.width * 0.1064188,
        size.height * 0.7005000,
        size.width * 0.1097241,
        size.height * 0.7262325,
        size.width * 0.1179865,
        size.height * 0.7448175);
    path_0.cubicTo(
        size.width * 0.1265788,
        size.height * 0.7634025,
        size.width * 0.1388071,
        size.height * 0.7698350,
        size.width * 0.1592982,
        size.height * 0.7698350);
    path_0.close();
    path_0.moveTo(size.width * 0.9293471, size.height * 0.6933525);
    path_0.cubicTo(
        size.width * 0.9567765,
        size.height * 0.6897787,
        size.width * 0.9934647,
        size.height * 0.6140100,
        size.width * 0.9934647,
        size.height * 0.4996425);
    path_0.cubicTo(
        size.width * 0.9934647,
        size.height * 0.3859900,
        size.width * 0.9567765,
        size.height * 0.3095062,
        size.width * 0.9293471,
        size.height * 0.3059325);
    path_0.lineTo(size.width * 0.9293471, size.height * 0.6933525);
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
