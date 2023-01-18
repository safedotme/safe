import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentNavigationButton extends StatelessWidget {
  final void Function() onTap;
  final String text;

  IncidentNavigationButton({
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14),
        height: kLargeButtonHeight,
        decoration: ShapeDecoration(
          color: kColorMap[MutableColor.neutral9],
          shape: SmoothRectangleBorder(
            side: BorderSide(
              width: kBorderWidth,
              color: kColorMap[MutableColor.neutral7]!,
            ),
            borderRadius: SmoothBorderRadius(
              cornerRadius: 14,
              cornerSmoothing: kCornerSmoothing,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MutableText(
              text,
              style: TypeStyle.h5,
              weight: TypeWeight.semiBold,
            ),
            MutableIcon(
              MutableIcons.caretRight,
              size: Size(8, 14),
              color: kColorMap[MutableColor.neutral2]!,
            ),
          ],
        ),
      ),
    );
  }
}
