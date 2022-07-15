import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.5,
      width: double.infinity,
      color: kColorMap[MutableColor.neutral6],
    );
  }
}
