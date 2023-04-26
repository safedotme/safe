import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/capture/local_widgets/animated_camera_preview.widget.dart';
import 'package:safe/screens/capture/local_widgets/camera_feed_buttons.widget.dart';
import 'package:safe/screens/capture/local_widgets/camera_feed_skeleton.widget.dart';
import 'package:safe/services/agora/agora.service.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_live_badge/mutable_live_badge.widget.dart';

class CameraFeed extends StatefulWidget {
  @override
  State<CameraFeed> createState() => _CameraFeedState();
}

class _CameraFeedState extends State<CameraFeed> with TickerProviderStateMixin {
  late Core core;
  late AnimationController controller;
  late Animation<double> animation;
  double opacity = 1;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    initAnimation();

    core.state.capture.setHidePreview(() {
      animateIn();
    });

    core.state.capture.setShowPreview(() {
      setState(() {
        opacity = 1;
      });
    });
  }

  Future<void> animateIn() async {
    await Future.delayed(Duration(seconds: 1));
    await core.services.agora.flipCam(
      core.state.capture.engine!,
      core,
      type: CamType.front,
    );
    await core.services.agora.muteExernalStreams(core.state.capture.engine!);
    await Future.delayed(Duration(seconds: 1));
    controller.forward(from: 0);
  }

  void initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = CurveTween(curve: Curves.easeInSine).animate(controller);

    controller.addListener(() {
      setState(() {
        opacity = 1 - animation.value;
      });
    });
  }

  double diff(double a, double b) => (a - b).abs();

  double getWidth(MediaQueryData query, double state) {
    double def = query.size.width * kCameraPreviewWidthPercentage;

    return def +
        diff(1, AnimatedCameraPreview.generateScaleCoeffcient(query)) *
            def *
            state;
  }

  double getHeight(MediaQueryData query, double state) {
    double def = kControlBoxBodyHeight;

    return def +
        diff(1, AnimatedCameraPreview.generateScaleCoeffcient(query)) *
            def *
            state;
  }

  double animateLiveBadgeMargin(double state) {
    double pos = core.utils.animation.percentBetweenPoints(
      lowerBound: 0.8,
      upperBound: 1,
      state: state,
    );

    return kCaptureLiveBadgeMargin +
        (kCaptureCameraButtonMargin - kCaptureLiveBadgeMargin).abs() * pos;
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return SizedBox(
      width: getWidth(query, core.state.capture.enlargementState),
      height: getHeight(query, core.state.capture.enlargementState),
      child: Stack(
        children: [
          Container(
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
            child: core.state.capture.engine == null
                ? SizedBox()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(
                      kCaptureControlBorderRadius - kBorderWidth,
                    ),
                    child: AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: core.state.capture.engine!,
                        canvas: VideoCanvas(uid: 0),
                      ),
                    ),
                  ),
          ),
          // Opacity(
          //   opacity: opacity,
          //   child: MutableShimmer(
          //     active: opacity != 0,
          //     animateToColor: kBoxLoaderShimmerColor,
          //     child: CameraFeedSkeleton(),
          //   ),
          // ),
          Opacity(
            opacity: opacity,
            child: CameraFeedSkeleton(),
          ),
          Visibility(
            visible: core.state.capture.enlargementState > 0.9 &&
                core.state.capture.engine != null,
            child: Opacity(
              opacity: core.utils.animation.percentBetweenPoints(
                lowerBound: 0.9,
                upperBound: 1,
                state: core.state.capture.enlargementState,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    kCaptureControlBorderRadius,
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                    ],
                  ),
                ),
                child: CameraFeedButtons(),
              ),
            ),
          ),
          AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: core.state.capture.engine != null ? 1 : 0,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 50,
                width: 84,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    kCaptureControlBorderRadius,
                  ),
                  gradient: RadialGradient(colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ], radius: 1, center: Alignment(-0.5, -1)),
                ),
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(
                  animateLiveBadgeMargin(core.state.capture.enlargementState),
                  animateLiveBadgeMargin(core.state.capture.enlargementState),
                  0,
                  0,
                ),
                child: MutableLiveBadge(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
