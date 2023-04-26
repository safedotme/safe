import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_safe_button/local_widgets/active_safe_button.widget.dart';
import 'package:safe/widgets/mutable_safe_button/local_widgets/disabled_safe_button.widget.dart';

class MutableSafeButton extends StatefulWidget {
  final void Function() onTap;

  MutableSafeButton({required this.onTap});

  @override
  State<MutableSafeButton> createState() => _MutableSafeButtonState();
}

class _MutableSafeButtonState extends State<MutableSafeButton>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController tapController;
  late Animation scaleAnimation;
  late Animation effectAnimation;
  late Animation scaleTapAnimation;
  late Core core;

  void initAnimations() {
    // Pulsation animation
    controller = AnimationController(
      vsync: this,
      duration: kSafeButtonPulsateDuration,
    );

    scaleAnimation =
        Tween<double>(begin: 1, end: kSafeButtonPuslateScale).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    effectAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.repeat(reverse: true);

    // Tap Animation
    tapController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    scaleTapAnimation = Tween(begin: 0, end: kSafeButtonTapScale).animate(
      CurvedAnimation(parent: tapController, curve: Curves.decelerate),
    );

    tapController.addListener(() {
      setState(() {});
    });
  }

  Future<void> animateTap() async {
    HapticFeedback.heavyImpact();
    widget.onTap();
    await tapController.forward();
    await tapController.reverse();
  }

  @override
  void initState() {
    super.initState();
    initAnimations();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  void dispose() {
    controller.dispose();
    tapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Transform.scale(
        scale: scaleTapAnimation.value +
            (core.state.capture.limErrState == null
                ? scaleAnimation.value
                : 1.0),
        child: GestureDetector(
          onTap: () async {
            controller.stop();
            await animateTap();
            controller.repeat(reverse: true);
          },
          child: core.state.capture.limErrState == null
              ? ActiveSafeButton(effectAnimation.value)
              : DisabledSafeButton(),
        ),
      ),
    );
  }
}
