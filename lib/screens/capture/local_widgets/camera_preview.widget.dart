import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class CameraPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: kBorderWidth,
          color: kColorMap[MutableColor.neutral7]!,
        ),
        color: kColorMap[MutableColor.neutral8],
        borderRadius: BorderRadius.circular(kCaptureControlBorderRadius),
      ),
    );
  }
}
