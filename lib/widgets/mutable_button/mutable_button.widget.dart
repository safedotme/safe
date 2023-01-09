import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableButton extends StatefulWidget {
  final void Function()? onTap;
  final Widget child;
  final Duration? duration;
  final void Function()? onSlide;
  final bool animateBeforeVoidCallback;

  MutableButton({
    this.onTap,
    required this.child,
    this.onSlide,
    this.duration,
    this.animateBeforeVoidCallback = false,
  });

  @override
  State<MutableButton> createState() => _MutableButtonState();
}

class _MutableButtonState extends State<MutableButton>
    with TickerProviderStateMixin {
  double currentState = 1;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      // Duration to reach the midpoint
      duration: kScaleDownButtonTime,
    );

    Animation animation =
        Tween(begin: 1, end: kScaleDownButtonPercentage).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.decelerate,
      ),
    );

    controller.addListener(() {
      setState(() {
        currentState = animation.value.toDouble();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    if (controller.isAnimating) {
      controller.stop();
    }

    controller.dispose();
    super.dispose();
  }

  Future<void> animate() async {
    await controller.forward();
    await controller.reverse();
  }

  void handleTap(Function? f) => f?.call();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.animateBeforeVoidCallback) {
          controller.forward();

          handleTap(widget.onTap);
          return;
        }

        handleTap(widget.onTap);
        await animate();
      },
      onVerticalDragStart: widget.onSlide != null
          ? (detail) {
              widget.onSlide!();
              animate();
            }
          : null,
      child: Transform.scale(
        scale: currentState,
        child: widget.child,
      ),
    );
  }
}
