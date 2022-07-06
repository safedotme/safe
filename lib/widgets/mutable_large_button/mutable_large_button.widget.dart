import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: kColorMap[MutableColor.neutral7]!,
          border: Border.all(
            color: kColorMap[MutableColor.neutral5]!,
            width: kBorderWidth,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: MutableText(
            text,
            style: TypeStyle.h4,
            weight: TypeWeight.bold,
            color: MutableColor.neutral3,
          ),
        ),
      ),
    );
  }
}
