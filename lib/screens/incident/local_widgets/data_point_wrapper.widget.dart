import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class DataPointWrapper extends StatelessWidget {
  final Widget child;

  DataPointWrapper({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kColorMap[MutableColor.neutral9],
        borderRadius: BorderRadius.circular(kMainPopupBorderRadius),
        border: Border.all(
          width: kBorderWidth,
          color: kColorMap[MutableColor.neutral7]!,
        ),
      ),
      child: child,
    );
  }
}
