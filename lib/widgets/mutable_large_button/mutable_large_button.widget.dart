import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_gradient_border/mutable_gradient_border.widget.dart';
import 'package:safe/widgets/mutable_gradient_shimmer/mutable_gradient_shimmer.widget.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

enum ButtonState {
  inactive,
  active,
}

class MutableLargeButton extends StatelessWidget {
  final void Function()? onTap;
  final bool isActive;
  final String text;
  final bool shimmer;
  final bool animateBeforeVoidCallback;
  final double height;
  final double borderRadius;
  final double? textSize;

  MutableLargeButton({
    this.onTap,
    this.height = kLargeButtonHeight,
    this.borderRadius = kLargeButtonBorderRadius,
    this.textSize,
    this.isActive = true,
    this.text = "",
    this.animateBeforeVoidCallback = false,
    this.shimmer = false,
  });

  Widget genBorder({required Widget child}) {
    if (isActive) {
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
      animateBeforeVoidCallback: animateBeforeVoidCallback,
      child: MutableGradientShimmer(
        animate: isActive,
        builder: (key) => Container(
          key: key,
          height: height,
          decoration: BoxDecoration(
            color: !isActive ? kColorMap[MutableColor.neutral7]! : null,
            border: !isActive
                ? Border.all(
                    color: kColorMap[MutableColor.neutral5]!,
                    width: kBorderWidth,
                  )
                : null,
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: isActive
                ? LinearGradient(
                    colors: kPrimaryGradientColors
                        .map((e) => e.withOpacity(0.15))
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
                size: textSize,
                style: TypeStyle.h4,
                weight: TypeWeight.bold,
                color:
                    !isActive ? MutableColor.neutral3 : MutableColor.neutral1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
