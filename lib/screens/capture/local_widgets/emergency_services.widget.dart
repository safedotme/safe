import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_large_button/mutable_large_button.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EmergencyServicesPopup extends StatefulWidget {
  @override
  State<EmergencyServicesPopup> createState() => _EmergencyServicesPopupState();
}

class _EmergencyServicesPopupState extends State<EmergencyServicesPopup> {
  late MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return MutablePopup(
      defaultState: PanelState.OPEN,
      minHeight: 0,
      maxHeight: queryData.size.height - (queryData.size.height * 0.05),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          kSideScreenMargin,
          kHandleTopMargin,
          kSideScreenMargin,
          0,
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  MutableHandle(),
                  SizedBox(height: 32),
                  MutableText(
                    "Notify 911",
                    style: TypeStyle.h3,
                    weight: TypeWeight.heavy,
                  ),
                  SizedBox(height: 35),
                  Container(
                    height: 82,
                    width: 82,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kColorMap[MutableColor.neutral8],
                      border: Border.all(
                        width: kBorderWidth,
                        color: kColorMap[MutableColor.neutral7]!,
                      ),
                    ),
                    child: Center(
                      child: Image.asset("assets/images/message.png"),
                    ),
                  ),
                  SizedBox(height: 35),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: MutableText(
                      "This information and a video livestream will be sent to emergency services",
                      style: TypeStyle.h5,
                      color: MutableColor.neutral2,
                      align: TextAlign.center,
                    ),
                  ),
                  Spacer(flex: 3),
                  Container(),
                  Spacer(flex: 2),
                  Container(),
                  Spacer(flex: 2),
                  Container(),
                  Spacer(flex: 3),
                  SizedBox(height: 90),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: kBottomScreenMargin),
                child: MutableLargeButton(
                  text: "Send Message",
                  isActive: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
