import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableSafeButton extends StatefulWidget {
  @override
  State<MutableSafeButton> createState() => _MutableSafeButtonState();
}

class _MutableSafeButtonState extends State<MutableSafeButton>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation scaleAnimation;
  late Animation effectAnimation;
  late Core core;
  double kButtonShadowOpacityIncrease = 0.1;
  double kButtonShadowBlurIncrease = 20;

  void animate() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1300),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 1.05).animate(
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
  }

  @override
  void initState() {
    super.initState();
    animate();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  double genOpacity() =>
      0.1 + (effectAnimation.value * kButtonShadowOpacityIncrease);

  double genBlur() =>
      30.0 + (effectAnimation.value * kButtonShadowBlurIncrease);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scaleAnimation.value,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: kSafeButtonSize,
          width: kSafeButtonSize,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: kPrimaryGradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
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

              // NEUTRAL INNER SHADOWS
              BoxShadow(
                offset: Offset(4, -4),
                blurRadius: 20,
                color: Colors.black.withOpacity(0.6),
                inset: true,
              ),
              BoxShadow(
                offset: Offset(-3, 3),
                blurRadius: 30,
                spreadRadius: 1,
                color: Colors.white.withOpacity(0.4),
                inset: true,
              ),
              BoxShadow(
                offset: Offset(-2, 2),
                blurRadius: 1,
                spreadRadius: 0,
                color: Colors.white.withOpacity(0.6),
                inset: true,
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              "assets/images/safe_logo_button.png",
              height: 110,
            ),
          ),
        ),
      ),
    );
  }
}
