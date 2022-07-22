import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';

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

  Future<void> initCamera() async {
    var cameras = await core.services.cam.cameras;
    core.state.capture.setCameras(cameras);

    var camera = core.services.cam.getCamera(
      direction: CameraLensDirection.back,
      cameras: cameras,
    );

    if (camera == null) {
      // ADD ERROR HANDLING
      return;
    }

    var controller = CameraController(
      camera,
      ResolutionPreset.high, // Check if user has custom settings
      enableAudio: true,
    );

    core.state.capture.setCamera(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MutableShimmer(
      animateToColor: kBoxLoaderShimmerColor,
      active: true,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: kBorderWidth,
            color: kColorMap[MutableColor.neutral7]!,
          ),
          color: kColorMap[MutableColor.neutral8],
          borderRadius: BorderRadius.circular(kCaptureControlBorderRadius),
        ),
        child: core.state.capture.camera != null
            ? CameraPreview(core.state.capture.camera!)
            : SizedBox(),
      ),
    );
  }
}
