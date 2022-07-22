import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/capture/local_widgets/capture_control_box.widget.dart';
import 'package:safe/screens/capture/local_widgets/capture_text_shimmer.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_tranistion.widget.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      //isOpen: true,
      onOpen: () {
        if (canRepaint) {
          core.state.capture.hintTextController.animate();
          canRepaint = false;
        }
      },
      onClose: () {
        canRepaint = true;
      },
      controller: core.state.capture.controller,
      body: Container(
        color: kColorMap[MutableColor.neutral10],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: CaptureTextShimmer(
                  controller: core.state.capture.hintTextController,
                ),
              ),
            ),
            CaptureControlBox(),
          ],
        ),
      ),
    );
  }
}
