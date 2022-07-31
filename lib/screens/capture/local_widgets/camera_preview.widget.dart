import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';

class CameraPreviewControl extends StatefulWidget {
  final CameraPreviewController? controller;

  CameraPreviewControl({this.controller});
  @override
  State<CameraPreviewControl> createState() => _CameraPreviewControlState();
}

class _CameraPreviewControlState extends State<CameraPreviewControl>
    with TickerProviderStateMixin {
  late MediaQueryData queryData;
  late Core core;
  late AnimationController controller;
  bool canFlip = true;

  // STATE
  double opacity = 1;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);

    if (widget.controller != null) {
      widget.controller!.setState(this);
    }

    // Initializes camera controller
    initAnimation();
    sync();
  }

  void sync() async {
    setState(() {
      opacity = 1;
    });
    await initCamera();
    await Future.delayed(
      Duration(milliseconds: 1000),
    );
    controller.forward(from: 0);
  }

  void initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    var animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    controller.addListener(() {
      setState(() {
        opacity = animation.value;
      });
    });
  }

  void flipCamera() async {
    if (core.state.capture.camera == null) {
      return;
    }

    if (!canFlip) {
      return;
    }

    canFlip = false;

    CameraDescription? cam = core.services.cam.flipCamera(
      oldDirection: core.state.capture.camera!.description.lensDirection,
      cameras: core.state.capture.cameras,
    );

    if (cam == null) {
      return;
    }

    var camController = CameraController(
      cam,
      core.state.preferences.cameraResolution,
      enableAudio: true,
    );

    setState(() {
      opacity = 1;
    });

    core.utils.engine.stop();
    core.state.capture.setIsCameraInitialized(false);
    core.state.capture.setCamera(camController);
    await core.state.capture.camera!.initialize();
    await core.state.capture.camera!.prepareForVideoRecording();
    core.utils.engine.flip();
    core.state.capture.setIsCameraInitialized(true);
    await controller.forward(from: 0);
    canFlip = true;
  }

  Future<void> initCamera() async {
    // Searches for cameras
    var cameras = await core.services.cam.cameras;
    core.state.capture.setCameras(cameras);

    var camera = core.services.cam.getCamera(
      direction: CameraLensDirection.back,
      cameras: cameras,
    );

    camera ??= core.services.cam.getCamera(
      direction: CameraLensDirection.front,
      cameras: cameras,
    );

    if (camera == null) {
      // ADD ERROR HANDLING FOR WHEN FRONT AND BACK CAMERAS ARE NOT FOUND
      print("No cameras were found");
      return;
    }

    // Creates controllers and updates them with MobX
    var camController = CameraController(
      camera,
      core.state.preferences.cameraResolution,
      enableAudio: true,
    );

    core.state.capture.setCamera(camController);

    await core.state.capture.camera!.initialize();
    await core.state.capture.camera!.prepareForVideoRecording();

    // Initializes the engine (will start the recording) UNCOMMENT LATER
    // core.utils.engine.initialize(
    //   c: core.state.capture.camera!,
    //   cre: core,
    // );

    core.state.capture.setIsCameraInitialized(true);
  }

  double genScale() {
    if (core.state.capture.camera == null) {
      return 1;
    }

    double parentRatio =
        (queryData.size.width * kCameraPreviewWidthPercentage) /
            kControlBoxBodyHeight;

    return core.state.capture.camera!.value.aspectRatio / parentRatio;
  }

  @override
  void dispose() {
    if (core.state.capture.camera != null) {
      core.state.capture.setIsCameraInitialized(false);
      core.state.capture.camera!.dispose();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Observer(
      builder: (_) => SizedBox(
        width: queryData.size.width * kCameraPreviewWidthPercentage,
        child: CupertinoContextMenu(
          actions: [Container()], // Add button
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: kBorderWidth,
                color: kColorMap[MutableColor.neutral7]!,
              ),
              borderRadius: BorderRadius.circular(kCaptureControlBorderRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                kCaptureControlBorderRadius - kBorderWidth,
              ),
              child: core.state.capture.isCameraInitialized
                  ? Transform.scale(
                      scale: genScale(),
                      child: Center(
                        child: CameraPreview(
                          core.state.capture.camera!,
                          child: MutableShimmer(
                            active: opacity > 0.05,
                            animateToColor: kBoxLoaderShimmerColor,
                            child: Opacity(
                              opacity: opacity,
                              child: Container(
                                color: kColorMap[MutableColor.neutral8],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : MutableShimmer(
                      active: true,
                      animateToColor: kBoxLoaderShimmerColor,
                      child: Opacity(
                        opacity: opacity,
                        child: Container(
                          color: kColorMap[MutableColor.neutral8],
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class CameraPreviewController {
  _CameraPreviewControlState? _state;

  // ignore: library_private_types_in_public_api
  void setState(_CameraPreviewControlState s) => _state = s;

  bool get isAttached => _state != null;

  void flipCamera() {
    assert(_state != null, "Controller has not been attached");
    _state!.flipCamera();
  }
}
