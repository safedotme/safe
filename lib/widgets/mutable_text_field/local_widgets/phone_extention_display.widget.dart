import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';

class PhoneExtentionDisplay extends StatelessWidget {
  final void Function() onTap;
  final String code;

  PhoneExtentionDisplay(this.code, {required this.onTap});
  @override
  Widget build(BuildContext context) {
    return MutableButton(
      scale: 0.9,
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: kColorMap[MutableColor.neutral8]!,
          border: Border.all(
            color: kColorMap[MutableColor.neutral7]!,
            width: kBorderWidth,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            "($code)",
            style: kTextInputStyle.copyWith(
              color: kColorMap[MutableColor.neutral2],
            ),
          ),
        ),
      ),
    );
  }
}
