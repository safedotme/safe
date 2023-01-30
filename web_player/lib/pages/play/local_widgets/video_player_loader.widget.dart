import 'package:flutter/material.dart';
import 'dart:math' as math;

class VideoPlayerLoader extends StatefulWidget {
  @override
  State<VideoPlayerLoader> createState() => _VideoPlayerLoaderState();
}

class _VideoPlayerLoaderState extends State<VideoPlayerLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double state = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
    );

    controller.addListener(() {
      setState(() {
        state = controller.value;
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
      angle: math.pi * 2 * state,
      child: Image.asset(
        "assets/images/circular_loader.png",
        height: 35,
        width: 35,
      ),
    );
  }
}
