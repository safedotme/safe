import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';

class MutableNavSafeButton extends StatelessWidget {
  final void Function()? onTap;

  MutableNavSafeButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of(context, listen: false);
    return MutableButton(
      onTap: onTap,
      animateBeforeVoidCallback: true,
      child: Container(
        height: kNavButtonSize + (kBorderWidth * 2),
        width: kNavButtonSize + (kBorderWidth * 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage("assets/images/gradient.png"),
          ),
          border: Border.all(
            width: kBorderWidth,
            color: Colors.white.withOpacity(0.3),
          ),
          boxShadow: core.utils.color.applyGradientShadow(kNavButtonSize),
        ),
        child: Center(
          child: Image.asset(
            "assets/images/safe_logo_button.png",
            height: 26,
          ),
        ),
      ),
    );
  }
}
