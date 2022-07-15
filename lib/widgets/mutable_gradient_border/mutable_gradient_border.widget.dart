import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_gradient_border/local_widgets/gradient_border_painter.widget.dart';

class MutableGradientBorder extends StatefulWidget {
  final double width;
  final double borderRadius;
  final Alignment? begin;
  final Alignment? end;
  final Widget child;

  MutableGradientBorder({
    this.width = 1.5,
    this.borderRadius = 0,
    this.begin,
    this.end,
    required this.child,
  });

  @override
  State<MutableGradientBorder> createState() => _MutableGradientBorderState();
}

class _MutableGradientBorderState extends State<MutableGradientBorder> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: GradientBorderPainter(
        width: widget.width,
        borderRadius: widget.borderRadius,
        begin: widget.begin,
        end: widget.end,
      ),
      child: widget.child,
    );
  }
}
