import 'package:safe/utils/constants/constants.util.dart';
import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class DisabledSafeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSafeButtonSize,
      width: kSafeButtonSize,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: kDisabledGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          // NEUTRAL INNER SHADOWS
          BoxShadow(
            offset: Offset(4, -4),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.2),
            inset: true,
          ),
          BoxShadow(
            offset: Offset(-3, 3),
            blurRadius: 30,
            spreadRadius: 1,
            color: Colors.white.withOpacity(0.1),
            inset: true,
          ),
          BoxShadow(
            offset: Offset(-2, 2),
            blurRadius: 1,
            spreadRadius: 0,
            color: Colors.white.withOpacity(0.2),
            inset: true,
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          "assets/images/safe_disabled_logo_button.png",
          height: kSafeButtonSize * 0.65,
        ),
      ),
    );
  }
}
