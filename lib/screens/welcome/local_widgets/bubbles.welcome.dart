import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class Bubble extends StatefulWidget {
  final int index;

  Bubble(this.index);
  @override
  State<Bubble> createState() => _BubbleState();
}

class _BubbleState extends State<Bubble> with TickerProviderStateMixin {
  late double size;
  late AnimationController controller;
  late Animation animation;
  late MediaQueryData queryData;
  double scale = 1;

  Future<void> animate() async {
    // Time it takes for each bubble to enter
    int baseline = 1200;

    // Percentage increase of each bubble
    double breathIncrement = 0.15;

    // Adds delay between each bubble to give pulsating effect
    await Future.delayed(Duration(
      milliseconds: 150 * widget.index,
    ));

    // Animate into scene
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: baseline),
    );

    animation = Tween<double>(begin: 0.0, end: 1 + breathIncrement).animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    controller.addListener(() {
      setState(() {
        scale = animation.value;
      });
    });

    await controller.forward();

    // Animate pulsations
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    animation = Tween<double>(begin: 1 + breathIncrement, end: 1).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    controller.addListener(() {
      setState(() {
        scale = animation.value;
      });
    });

    controller.repeat(reverse: true);
  }

  // Generates size
  void genSize() {
    double baseline = 540;
    double increment = 176;

    size = baseline + (increment * widget.index);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Generates base size for bubbles
    genSize();

    // Animate bubble
    animate();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Positioned(
      bottom: -size * (53 / 100),
      right: (queryData.size.width / 2) - (size / 2),
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: 0.35 / (widget.index + 1),
          child: Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: kPrimaryGradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                // Red
                BoxShadow(
                  offset: Offset(-4, -4),
                  blurRadius: 20,
                  color: kColorMap[MutableColor.primaryRed]!.withOpacity(0.1),
                ),

                // Purple
                BoxShadow(
                  offset: Offset(-4, -4),
                  blurRadius: 20,
                  color:
                      kColorMap[MutableColor.primaryPurple]!.withOpacity(0.1),
                ),

                // Yellow
                BoxShadow(
                  offset: Offset(-4, -4),
                  blurRadius: 20,
                  color:
                      kColorMap[MutableColor.primaryYellow]!.withOpacity(0.1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
