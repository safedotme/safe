import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class CameraFeedSkeleton extends StatelessWidget {
  final bool darkened;
  final bool show;

  CameraFeedSkeleton({
    this.darkened = false,
    this.show = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: !show
          ? 0
          : darkened
              ? 0.4
              : 1,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: kBorderWidth,
            color: kColorMap[MutableColor.neutral7]!,
          ),
          color: kColorMap[MutableColor.neutral8],
          borderRadius: BorderRadius.circular(
            kCaptureControlBorderRadius,
          ),
        ),
      ),
    );
  }
}
