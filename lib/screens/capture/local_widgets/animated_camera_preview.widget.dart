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

class _AnimatedCameraPreviewState extends State<AnimatedCameraPreview>
    with TickerProviderStateMixin {
  late Core core;
  late AnimationController controller;
  late Animation<double> animation;
  double scaleState = 1;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
    initAnimation();
  }

  double genBottomPosition(double panelPosition) {
    double def = kBottomScreenMargin;

    if (panelPosition != 0) {
      return def - ((core.state.capture.panelHeight - 100) * panelPosition);
    }

    return def;
  }

  void initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: kScaleDownButtonTime,
    );

    animation = Tween<double>(
      begin: 1,
      end: kScaleDownButtonPercentage,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    controller.addListener(() {
      setState(() {
        scaleState = animation.value;
      });
    });
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
          child: Transform.scale(
            scale: scaleState,
            child: GestureDetector(
              onLongPressStart: (details) async {
                HapticFeedback.mediumImpact();
                await controller.forward();
                await Future.delayed(Duration(milliseconds: 200));
                controller.reverse();
              },
              onLongPressEnd: (details) {},
              child: CameraFeed(),
            ),
          ),
        ),
      ),
    );
  }
}
