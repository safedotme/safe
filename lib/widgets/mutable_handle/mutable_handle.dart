import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: kColorMap[MutableColor.neutral4]!,
      ),
    );
  }
}
