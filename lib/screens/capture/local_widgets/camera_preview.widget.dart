import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class CameraPreviewControl extends StatefulWidget {
  @override
  State<CameraPreviewControl> createState() => _CameraPreviewControlState();
}

class _CameraPreviewControlState extends State<CameraPreviewControl> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);

    // Initializes camera controller
    initCamera();
  }

  Future<void> initCamera() async {}

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
