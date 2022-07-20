import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableScreenTransition extends StatefulWidget {
  final Widget body;

  MutableScreenTransition({required this.body});

  @override
  State<MutableScreenTransition> createState() =>
      _MutableScreenTransitionState();
}

class _MutableScreenTransitionState extends State<MutableScreenTransition> {
  late Core core;
  // State Values
  double state = 0;
  double? initialState;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  void onUpdate(DragUpdateDetails details) {
    // check if animating
    double pos = details.globalPosition.dy;

    initialState ??= pos;

    double animation = core.utils.animation.percentBetweenPoints(
      // Change upper and lower bound to change scroll direction
      lowerBound: initialState!,
      upperBound: initialState! + kScreenTransitionBound,
      state: pos,
    );

    setState(() {
      state = animation;
    });
  }

  void onStart(DragStartDetails details) {}

  void onEnd(DragEndDetails details) {
    initialState = null;
  }

  double difference(double d) => (d - 1) * -1;

  double genScale(double s) => 0.95 + (0.05 * difference(s));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: onStart,
      onVerticalDragEnd: onEnd,
      onVerticalDragUpdate: onUpdate,
      child: Transform.scale(
        scale: genScale(state),
        child: Opacity(
          opacity: 1,
          child: widget.body,
        ),
      ),
    );
  }
}
