import 'package:flutter/material.dart';

class MutableButton extends StatefulWidget {
  final void Function()? onTap;
  final Widget child;
  final Duration? duration;
  final void Function()? onSlide;

  MutableButton({
    this.onTap,
    required this.child,
    this.onSlide,
    this.duration,
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
      duration: Duration(milliseconds: 125),
    );

    Animation animation = Tween(begin: 1, end: 0.97).animate(
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

  void animate() async {
    await controller.forward();
    await controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
        animate();
      },
      onVerticalDragStart: (_) {
        if (widget.onSlide != null) {
          widget.onSlide!();
        }
      },
      child: Transform.scale(
        scale: currentState,
        child: widget.child,
      ),
    );
  }
}
