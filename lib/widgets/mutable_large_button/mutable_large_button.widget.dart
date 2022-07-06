import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_gradient_border/mutable_gradient_border.widget.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:shimmer/shimmer.dart';

enum ButtonState {
  inactive,
  active,
}

class MutableLargeButton extends StatelessWidget {
  final void Function()? onTap;
  final ButtonState state;
  final String text;
  final bool shimmer;

  MutableLargeButton({
    this.onTap,
    this.state = ButtonState.active,
    this.text = "",
    this.shimmer = false,
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
      child: MutableShimmer(
        active: shimmer,
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
            gradient: state == ButtonState.active
                ? LinearGradient(
                    colors: kPrimaryGradientColors
                        .map((e) =>
                            e.withOpacity(kTransparencyMap[Transparency.v20]!))
                        .toList(),
                    begin: kPrimaryGradientAlignmentBegin,
                    end: kPrimaryGradientAlignmentEnd,
                  )
                : null,
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
      ),
    );
  }
}
