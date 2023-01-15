import 'package:flutter/material.dart';
import 'dart:math' as math;

class MutableVideoLoader extends StatefulWidget {
  @override
  State<MutableVideoLoader> createState() => _MutableVideoLoaderState();
}

class _MutableVideoLoaderState extends State<MutableVideoLoader>
    with TickerProviderStateMixin {
  double state = 0;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    animate();
  }

  void animate() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    var animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    );

    controller.addListener(() {
      setState(() {
        state = animation.value;
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
      angle: (math.pi * 2) * state,
      child: Image.asset("assets/images/circular_loader.png"),
    );
  }
}
