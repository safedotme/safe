import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/capture/local_widgets/camera_preview.widget.dart';
import 'package:safe/screens/capture/local_widgets/control_button.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CaptureControlBox extends StatefulWidget {
  @override
  State<CaptureControlBox> createState() => _CaptureControlBoxState();
}

class _CaptureControlBoxState extends State<CaptureControlBox> {
  late Core core;
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  void getSize() {
    Future.delayed(Duration.zero).then((value) {
      if (key.currentContext == null) {
        return;
      }

      var box = key.currentContext!.findRenderObject() as RenderBox;

      core.state.capture.setPanelHeight(box.size.height);
    });
  }

  @override
  Widget build(BuildContext context) {
    getSize();
    return Observer(
      builder: (_) => MutablePopup(
        backdropTapClose: false,
        defaultState: PanelState.OPEN,
        style: MutablePopupStyle(
          backgroundColor: kColorMap[MutableColor.neutral9],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kMainPopupBorderRadius),
            topRight: Radius.circular(kMainPopupBorderRadius),
          ),
        ),
        enableBorder: false,
        onSlide: (offset) {
          core.state.capture.setOffset(offset);
        },
        maxHeight: core.state.capture.panelHeight,
        minHeight: 100,
        body: Center(
          child: Padding(
            key: key,
            padding: EdgeInsets.fromLTRB(
              kSideScreenMargin,
              10,
              kSideScreenMargin,
              kBottomScreenMargin,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MutableHandle(),
                SizedBox(height: 15),
                Opacity(
                  opacity: core.state.capture.offset,
                  child: SizedBox(
                    height: kControlBoxBodyHeight,
                    child: Row(
                      children: [
                        CameraPreviewControl(),
                        SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              ControlButton(
                                text: core.utils.language.langMap[core
                                        .state.preferences.language]!["capture"]
                                    ["controls"]["flip_camera"]["header"],
                                icon: MutableIcons.camera,
                                iconSize: Size(20, 16),
                                onTap: () {
                                  print("flip camera");
                                },
                              ),
                              SizedBox(height: 10),
                              ControlButton(
                                text: core.utils.language.langMap[core
                                        .state.preferences.language]!["capture"]
                                    ["controls"]["911"]["header"],
                                icon: MutableIcons.shield,
                                iconSize: Size(15, 17),
                                onTap: () {
                                  print("navigate to 911 popup");
                                },
                              ),
                              SizedBox(height: 10),
                              ControlButton(
                                text: core.utils.language.langMap[core
                                        .state.preferences.language]!["capture"]
                                    ["controls"]["stop"]["header"],
                                icon: MutableIcons.stopRecording,
                                iconSize: Size(17, 17),
                                onTap: () {
                                  print("stop incident");
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
