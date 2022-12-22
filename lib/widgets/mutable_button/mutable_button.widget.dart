import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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

  Future<void> animate() async {
    await controller.forward();
    await controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.animateBeforeVoidCallback) {
          await animate();
        }

        if (widget.onTap != null) {
          widget.onTap!();
        }

        if (!widget.animateBeforeVoidCallback) {
          animate();
        }
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
