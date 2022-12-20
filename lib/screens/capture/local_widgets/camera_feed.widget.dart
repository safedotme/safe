import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';

class CameraFeed extends StatefulWidget {
  @override
  State<CameraFeed> createState() => _CameraFeedState();
}

class _CameraFeedState extends State<CameraFeed> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
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
          // MutableShimmer(
          //   active: true,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //         width: kBorderWidth,
          //         color: kColorMap[MutableColor.neutral7]!,
          //       ),
          //       color: kColorMap[MutableColor.neutral8],
          //       borderRadius: BorderRadius.circular(
          //         kCaptureControlBorderRadius,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
