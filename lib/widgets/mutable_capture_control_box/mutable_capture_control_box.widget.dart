import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_capture_control_box/local_widgets/control_button.widget.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';

class MutableCaptureControlBox extends StatefulWidget {
  @override
  State<MutableCaptureControlBox> createState() =>
      _MutableCaptureControlBoxState();
}

class _MutableCaptureControlBoxState extends State<MutableCaptureControlBox> {
  late MediaQueryData queryData;
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    return Container(
      padding: EdgeInsets.fromLTRB(
        kSideScreenMargin,
        10,
        kSideScreenMargin,
        kBottomScreenMargin,
      ),
      height: queryData.size.height / 4,
      decoration: BoxDecoration(
        color: kColorMap[MutableColor.neutral9],
        borderRadius: BorderRadius.circular(kMainPopupBorderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MutableHandle(),
          SizedBox(height: 15),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(color: Colors.red),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      ControlButton(
                        text: core.utils.language.langMap[
                                core.state.preferences.language]!["capture"]
                            ["controls"]["flip_camera"]["header"],
                        icon: MutableIcons.camera,
                        iconSize: Size(20, 16),
                        onTap: () {
                          print("flip camera");
                        },
                      ),
                      SizedBox(height: 10),
                      ControlButton(
                        text: core.utils.language.langMap[core.state.preferences
                            .language]!["capture"]["controls"]["911"]["header"],
                        icon: MutableIcons.shield,
                        iconSize: Size(15, 17),
                        onTap: () {
                          print("navigate to 911 popup");
                        },
                      ),
                      SizedBox(height: 10),
                      ControlButton(
                        text: core.utils.language.langMap[
                                core.state.preferences.language]!["capture"]
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
          )
        ],
      ),
    );
  }
}
