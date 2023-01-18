import 'package:flutter/material.dart';

class AnimatedHeart extends StatefulWidget {
  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with TickerProviderStateMixin {
  double state = 1;
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    animate();
  }

  void animate() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );

    animation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));

    controller.repeat(reverse: true);

    controller.addListener(() {
      setState(() {
        state = animation.value;
      });
    });
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
    return Transform.scale(
      scale: 0.8 + (0.2 * state),
      child: Image.asset(
        "assets/images/heart.png",
        height: 30,
        width: 30,
      ),
    );
  }
}
