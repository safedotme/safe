import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_gradient_border/mutable_gradient_border.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

enum ButtonState {
  inactive,
  active,
}

class MutableLargeButton extends StatelessWidget {
  final void Function()? onTap;
  final ButtonState state;
  final String text;

  MutableLargeButton({
    this.onTap,
    this.state = ButtonState.active,
    this.text = "",
  });

  Widget genBorder({required Widget child}) {
    if (state == ButtonState.active) {
      return MutableGradientBorder(
        borderRadius: kLargeButtonBorderRadius,
        child: child,
      );
    } else {
      return child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: onTap,
      child: Container(
        height: kLargeButtonHeight,
        decoration: BoxDecoration(
          color: state == ButtonState.inactive
              ? kColorMap[MutableColor.neutral7]!
              : null,
          border: state == ButtonState.inactive
              ? Border.all(
                  color: kColorMap[MutableColor.neutral5]!,
                  width: kBorderWidth,
                )
              : null,
          borderRadius: BorderRadius.circular(kLargeButtonBorderRadius),
          gradient: LinearGradient(
            colors: kPrimaryGradientColors
                .map((e) => e.withOpacity(kTransparencyMap[Transparency.v20]!))
                .toList(),
            begin: kPrimaryGradientAlignmentBegin,
            end: kPrimaryGradientAlignmentEnd,
          ),
        ),
        child: genBorder(
          child: Center(
            child: MutableText(
              text,
              style: TypeStyle.h4,
              weight: TypeWeight.bold,
              color: state == ButtonState.inactive
                  ? MutableColor.neutral3
                  : MutableColor.neutral1,
            ),
          ),
        ),
      ),
    );
  }
}
