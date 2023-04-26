import 'dart:math' as math;
import 'package:flutter/material.dart';

class CameraPreviewProgressIndicator extends StatefulWidget {
  @override
  State<CameraPreviewProgressIndicator> createState() =>
      _CameraPreviewProgressIndicatorState();
}

class _CameraPreviewProgressIndicatorState
    extends State<CameraPreviewProgressIndicator>
    with TickerProviderStateMixin {
  double rotations = 0;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 900),
    );

    controller.addListener(() {
      setState(() {
        rotations = controller.value;
      });
    });

    controller.repeat();
  }

  @override
  void dispose() {
    if (controller.isAnimating) {
      controller.stop();
    }

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi * rotations * 2,
      child: Image.asset(
        "assets/images/cam_prev_loader.png",
        height: 33,
      ),
    );
  }
}
