import 'package:flutter/material.dart';

class PlusIcon extends CustomPainter {
  final Color color;

  PlusIcon(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9166667, size.height * 0.4250000);
    path_0.lineTo(size.width * 0.5833333, size.height * 0.4250000);
    path_0.lineTo(size.width * 0.5833333, size.height * 0.1250000);
    path_0.cubicTo(
        size.width * 0.5833333,
        size.height * 0.1051090,
        size.width * 0.5745533,
        size.height * 0.08603220,
        size.width * 0.5589256,
        size.height * 0.07196700);
    path_0.cubicTo(
        size.width * 0.5432978,
        size.height * 0.05790180,
        size.width * 0.5221011,
        size.height * 0.05000000,
        size.width * 0.5000000,
        size.height * 0.05000000);
    path_0.cubicTo(
        size.width * 0.4778989,
        size.height * 0.05000000,
        size.width * 0.4567022,
        size.height * 0.05790180,
        size.width * 0.4410744,
        size.height * 0.07196700);
    path_0.cubicTo(
        size.width * 0.4254467,
        size.height * 0.08603220,
        size.width * 0.4166667,
        size.height * 0.1051090,
        size.width * 0.4166667,
        size.height * 0.1250000);
    path_0.lineTo(size.width * 0.4166667, size.height * 0.4250000);
    path_0.lineTo(size.width * 0.08333333, size.height * 0.4250000);
    path_0.cubicTo(
        size.width * 0.06123200,
        size.height * 0.4250000,
        size.width * 0.04003578,
        size.height * 0.4329020,
        size.width * 0.02440778,
        size.height * 0.4469670);
    path_0.cubicTo(size.width * 0.008779756, size.height * 0.4610320, 0,
        size.height * 0.4801090, 0, size.height * 0.5000000);
    path_0.cubicTo(
        0,
        size.height * 0.5198910,
        size.width * 0.008779756,
        size.height * 0.5389680,
        size.width * 0.02440778,
        size.height * 0.5530330);
    path_0.cubicTo(
        size.width * 0.04003578,
        size.height * 0.5670980,
        size.width * 0.06123200,
        size.height * 0.5750000,
        size.width * 0.08333333,
        size.height * 0.5750000);
    path_0.lineTo(size.width * 0.4166667, size.height * 0.5750000);
    path_0.lineTo(size.width * 0.4166667, size.height * 0.8750000);
    path_0.cubicTo(
        size.width * 0.4166667,
        size.height * 0.8948910,
        size.width * 0.4254467,
        size.height * 0.9139680,
        size.width * 0.4410744,
        size.height * 0.9280330);
    path_0.cubicTo(
        size.width * 0.4567022,
        size.height * 0.9420980,
        size.width * 0.4778989,
        size.height * 0.9500000,
        size.width * 0.5000000,
        size.height * 0.9500000);
    path_0.cubicTo(
        size.width * 0.5221011,
        size.height * 0.9500000,
        size.width * 0.5432978,
        size.height * 0.9420980,
        size.width * 0.5589256,
        size.height * 0.9280330);
    path_0.cubicTo(
        size.width * 0.5745533,
        size.height * 0.9139680,
        size.width * 0.5833333,
        size.height * 0.8948910,
        size.width * 0.5833333,
        size.height * 0.8750000);
    path_0.lineTo(size.width * 0.5833333, size.height * 0.5750000);
    path_0.lineTo(size.width * 0.9166667, size.height * 0.5750000);
    path_0.cubicTo(
        size.width * 0.9387678,
        size.height * 0.5750000,
        size.width * 0.9599644,
        size.height * 0.5670980,
        size.width * 0.9755922,
        size.height * 0.5530330);
    path_0.cubicTo(size.width * 0.9912200, size.height * 0.5389680, size.width,
        size.height * 0.5198910, size.width, size.height * 0.5000000);
    path_0.cubicTo(
        size.width,
        size.height * 0.4801090,
        size.width * 0.9912200,
        size.height * 0.4610320,
        size.width * 0.9755922,
        size.height * 0.4469670);
    path_0.cubicTo(
        size.width * 0.9599644,
        size.height * 0.4329020,
        size.width * 0.9387678,
        size.height * 0.4250000,
        size.width * 0.9166667,
        size.height * 0.4250000);
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
