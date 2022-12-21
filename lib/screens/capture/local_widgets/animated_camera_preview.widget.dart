import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/capture/local_widgets/camera_feed.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';

class AnimatedCameraPreview extends StatefulWidget {
  @override
  State<AnimatedCameraPreview> createState() => _AnimatedCameraPreviewState();
}

class _AnimatedCameraPreviewState extends State<AnimatedCameraPreview> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  double genBottomPosition(double panelPosition) {
    double def = kBottomScreenMargin;

    if (panelPosition != 0) {
      return def - ((core.state.capture.panelHeight - 100) * panelPosition);
    }

    return def;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Positioned(
        bottom: genBottomPosition(
          ((core.state.capture.offset - 1) * -1).abs(),
        ),
        left: kSideScreenMargin,
        child: Opacity(
          opacity: (core.state.capture.offset).abs(),
          child: GestureDetector(
            onLongPressStart: (details) {
              HapticFeedback.lightImpact();
            },
            onLongPressEnd: (details) {
              print("end");
            },
            child: CameraFeed(),
          ),
        ),
      ),
    );
  }
}
