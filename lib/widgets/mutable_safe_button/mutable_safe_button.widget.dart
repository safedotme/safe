import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

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

  double genOpacity() =>
      0.1 + (effectAnimation.value * kSafeButtonShadowOpacityScale);

  double genBlur() =>
      30.0 + (effectAnimation.value * kSafeButtonShadowBlurScale);

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
                child: Container(
                  height: kSafeButtonSize,
                  width: kSafeButtonSize,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: core.state.capture.limErrState != null
                          ? kDisabledGradientColors
                          : kPrimaryGradientColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      ...(core.state.capture.limErrState != null
                          ? []
                          : [
                              // COLORS DROP SHADOWS
                              BoxShadow(
                                offset: Offset(4, 4),
                                blurRadius: genBlur(),
                                color: kColorMap[MutableColor.primaryPurple]!
                                    .withOpacity(genOpacity()),
                              ),
                              BoxShadow(
                                offset: Offset(4, -4),
                                blurRadius: genBlur(),
                                color: kColorMap[MutableColor.primaryRed]!
                                    .withOpacity(genOpacity()),
                              ),
                              BoxShadow(
                                offset: Offset(-4, -4),
                                blurRadius: genBlur(),
                                color: kColorMap[MutableColor.primaryYellow]!
                                    .withOpacity(genOpacity()),
                              ),
                            ]),

                      // NEUTRAL INNER SHADOWS
                      BoxShadow(
                        offset: Offset(4, -4),
                        blurRadius: 20,
                        color: Colors.black.withOpacity(
                            core.state.capture.limErrState != null ? 0.2 : 0.6),
                        inset: true,
                      ),
                      BoxShadow(
                        offset: Offset(-3, 3),
                        blurRadius: 30,
                        spreadRadius: 1,
                        color: Colors.white.withOpacity(
                            core.state.capture.limErrState != null ? 0.1 : 0.4),
                        inset: true,
                      ),
                      BoxShadow(
                        offset: Offset(-2, 2),
                        blurRadius: 1,
                        spreadRadius: 0,
                        color: Colors.white.withOpacity(
                            core.state.capture.limErrState != null ? 0.2 : 0.6),
                        inset: true,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/${core.state.capture.limErrState == null ? "safe_logo_button" : "safe_disabled_logo_button"}.png",
                      height: kSafeButtonSize * 0.65,
                    ),
                  ),
                ),
              ),
            ));
  }
}
