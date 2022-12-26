import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/capture/local_widgets/animated_camera_preview.widget.dart';
import 'package:safe/screens/capture/local_widgets/capture_control_box.widget.dart';
import 'package:safe/screens/capture/local_widgets/capture_text_shimmer.widget.dart';
import 'package:safe/screens/capture/local_widgets/enlargement_blur_background.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_loader/mutable_loader.widget.dart';
import 'package:safe/widgets/mutable_overlay/mutable_overlay.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';

class Capture extends StatefulWidget {
  @override
  State<Capture> createState() => _CaptureState();
}

class _CaptureState extends State<Capture> {
  late Core core;
  bool canRepaint = true;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    core.utils.capture.initialize(core);
  }

  void animateHint() async {
    int length = core.utils.language
        .langMap[core.state.preferences.language]!["capture"]["hint"].length;

    core.state.capture.setHintTextIndex(0);

    for (int i = 0; i < length; i++) {
      await core.state.capture.hintTextController.animate();
      if (!(i + 1 == length)) {
        core.state.capture.setHintTextIndex(i + 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      onOpen: () async {
        if (canRepaint) {
          canRepaint = false;
          animateHint();
        }
      },
      onClose: () {
        core.state.capture.setHintTextIndex(0);
        canRepaint = true;
      },
      isDismissable: false,
      controller: core.state.capture.controller,
      body: Container(
        color: kColorMap[MutableColor.neutral10],
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: core.state.capture.panelHeight,
                ),
                child: CaptureTextShimmer(
                  controller: core.state.capture.hintTextController,
                ),
              ),
            ),
            CaptureControlBox(),
            EnglargementBlurBackground(),
            AnimatedCameraPreview(),
            MutableOverlay(
              controller: core.state.capture.overlayController,
              child: Center(
                child: MutableLoader(
                  text: core.utils.language
                          .langMap[core.state.preferences.language]!["capture"]
                      ["loader"],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
