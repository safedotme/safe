import 'package:flutter/material.dart';
import 'package:safe/screens/capture/local_widgets/camera_preview_progress_indicator.widget.dart';
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
          image: DecorationImage(
            image: AssetImage("assets/images/stream_loader.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(
            kCaptureControlBorderRadius,
          ),
        ),
        child: Center(
          child: CameraPreviewProgressIndicator(),
        ),
      ),
    );
  }
}
