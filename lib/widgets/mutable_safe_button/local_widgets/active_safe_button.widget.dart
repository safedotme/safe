import 'package:safe/utils/constants/constants.util.dart';
import 'package:flutter/material.dart';

class ActiveSafeButton extends StatelessWidget {
  final double state;
  ActiveSafeButton(this.state);

  double genOpacity() => 0.1 + (state * kSafeButtonShadowOpacityScale);

  double genBlur() => 30.0 + (state * kSafeButtonShadowBlurScale);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSafeButtonSize,
      width: kSafeButtonSize,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/gradient.png"),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          width: 3,
          color: Colors.white.withOpacity(0.26),
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 4),
            color: kColorMap[MutableColor.primaryPurple]!.withOpacity(
              0.25 + 0.1 * state,
            ),
            blurRadius: 40 + 20 * state,
          ),
          BoxShadow(
            offset: Offset(4, -4),
            color: kColorMap[MutableColor.primaryRed]!.withOpacity(
              0.25 + 0.1 * state,
            ),
            blurRadius: 40 + 20 * state,
          ),
          BoxShadow(
            offset: Offset(-4, -4),
            color: kColorMap[MutableColor.primaryYellow]!.withOpacity(
              0.25 + 0.1 * state,
            ),
            blurRadius: 40 + 20 * state,
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          "assets/images/safe_logo_button.png",
          height: kSafeButtonSize * 0.65,
        ),
      ),
    );
  }
}
