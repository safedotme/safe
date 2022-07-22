import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableCaptureControlBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: kCaptureControlBoxHeight,
      color: kColorMap[MutableColor.neutral9],
    );
  }
}
