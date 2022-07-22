import 'package:flutter/material.dart';
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
                        text: "Flip Camera",
                        icon: MutableIcons.key,
                        onTap: () {
                          print("flip camera");
                        },
                      ),
                      SizedBox(height: 10),
                      ControlButton(
                        text: "Notify 911",
                        icon: MutableIcons.key,
                        onTap: () {
                          print("navigate to 911 popup");
                        },
                      ),
                      SizedBox(height: 10),
                      ControlButton(
                        text: "Stop Recording",
                        icon: MutableIcons.key,
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
