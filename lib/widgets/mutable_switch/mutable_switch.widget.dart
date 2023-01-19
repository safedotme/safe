import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe/widgets/mutable_switch/local_widgets/switch_painter.widget.dart';

class MutableSwitch extends StatefulWidget {
  final bool defaultState;
  final void Function(bool v)? onChange;

  MutableSwitch({
    this.defaultState = false,
    this.onChange,
  });
  @override
  State<MutableSwitch> createState() => _MutableSwitchState();
}

class _MutableSwitchState extends State<MutableSwitch>
    with TickerProviderStateMixin {
  late AnimationController controller;
  Animation? animation;
  late double state = widget.defaultState ? 1 : 0;

  void animate() async {
    animation = Tween(
      begin: state,
      end: not(state),
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.decelerate),
    );

    await controller.forward(from: 0);
  }

  double not(double x) => (x - 1).abs();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 150,
      ),
    );

    controller.addListener(() {
      if (animation == null) return;
      setState(() {
        state = animation!.value;
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (controller.isAnimating) return;

        HapticFeedback.lightImpact();
        animate();
        widget.onChange?.call(state == 0 ? true : false);
      },
      child: CustomPaint(
        painter: SwitchPainter(state),
        child: SizedBox(
          height: 31,
          width: 51,
        ),
      ),
    );
  }
}
