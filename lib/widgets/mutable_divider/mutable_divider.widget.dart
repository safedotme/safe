import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableDivider extends StatelessWidget {
  final MutableColor color;

  MutableDivider({this.color = MutableColor.neutral6});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.5,
      width: double.infinity,
      color: kColorMap[color],
    );
  }
}
