import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/services/agora/agora.service.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';

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
      duration: Duration(seconds: 3),
    );

    animation = CurveTween(curve: Curves.easeInSine).animate(controller);

    controller.addListener(() {
      setState(() {
        opacity = 1 - animation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: 125,
      child: Stack(
        children: [
          Container(
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
          Opacity(
            opacity: opacity,
            child: MutableShimmer(
              active: opacity != 0,
              animateToColor: kBoxLoaderShimmerColor,
              child: Container(
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
            ),
          ),
        ],
      ),
    );
  }
}
