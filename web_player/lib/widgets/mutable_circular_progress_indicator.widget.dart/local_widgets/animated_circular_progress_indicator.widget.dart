import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_circular_progress_indicator.widget.dart/mutable_circular_progress_indicator.widget.dart';

class AnimatedCircularProgressIndicator extends StatefulWidget {
  @override
  State<AnimatedCircularProgressIndicator> createState() =>
      _AnimatedCircularProgressIndicatorState();
}

class _AnimatedCircularProgressIndicatorState
    extends State<AnimatedCircularProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    animate();
    super.initState();
  }

  void animate() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    controller.addListener(() {
      setState(() {});
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
    return SizedBox(
      height: kMessageBannerIconSize - 10,
      width: kMessageBannerIconSize - 10,
      child: CustomPaint(
        painter: MutableCircularProgressIndicator(
          frontColor: Colors.white,
          backColor: kColorMap[MutableColor.neutral7]!,
          strokeWidth: 9,
          value: animation.value,
        ),
      ),
    );
  }
}
