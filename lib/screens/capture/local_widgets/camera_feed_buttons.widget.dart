import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_overlay_button/mutable_overlay_button.widget.dart';

class CameraFeedButtons extends StatefulWidget {
  @override
  State<CameraFeedButtons> createState() => _CameraFeedButtonsState();
}

class _CameraFeedButtonsState extends State<CameraFeedButtons> {
  late Core core;
  final List<MutableIcon> icons = [
    MutableIcon(
      MutableIcons.cancel,
      size: Size(13, 13),
    ),
    MutableIcon(
      MutableIcons.cameraFlipFilled,
      size: Size(22, 17),
    ),
    MutableIcon(
      MutableIcons.flashlightFilled,
      size: Size(10, 20),
    )
  ];
  bool flashOn = false;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Observer(
          builder: (context) => Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: List.generate(3, (i) {
              return Padding(
                padding: EdgeInsets.only(left: 10),
                child: MutableOverlayButton(
                  icon: icons[i],
                  animateBeforeVoidCallback: true,
                  onTap: () async {
                    HapticFeedback.lightImpact();

                    // Ensures that preview is enlarged
                    if (core.state.capture.enlargementState != 1) return;

                    // ⬇️ Flashlight
                    if (i == 2 && core.state.capture.engine != null) {
                      await core.services.agora.toggleFlash(
                        core.state.capture.engine!,
                        core,
                      );
                    }

                    // ⬇️ Flip Camera
                    if (i == 1 && core.state.capture.engine != null) {
                      await core.services.agora.flipCam(
                        core.state.capture.engine!,
                        core,
                      );
                    }

                    // ⬇️ Escape
                    if (i == 0 &&
                        core.state.capture.unEnlargeCameraView != null) {
                      core.state.capture.unEnlargeCameraView!();
                    }
                  },
                  isDarkened: true,
                  isActive: i == 2 && core.state.capture.isFlashOn,
                ),
              );
            }).reversed.toList(),
          ),
        ),
      ),
    );
  }
}
