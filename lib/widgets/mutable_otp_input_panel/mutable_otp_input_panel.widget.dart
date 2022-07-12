import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableOtpInputPanel extends StatefulWidget {
  final PanelController controller;
  final void Function(String otp) onSubmit;

  MutableOtpInputPanel({
    required this.controller,
    required this.onSubmit,
  });

  @override
  State<MutableOtpInputPanel> createState() => _MutableOtpInputPanelState();
}

class _MutableOtpInputPanelState extends State<MutableOtpInputPanel>
    with TickerProviderStateMixin {
  late Core core;
  late PanelController controller;
  late ValueNotifier<double> notifier;
  late MediaQueryData queryData;
  bool dismissDetector = false;
  FocusNode node = FocusNode();
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    controller = widget.controller;

    // Enables user to drag or tap to dismiss keyboard when enabled
    node.addListener(() {
      setState(() {
        dismissDetector = node.hasFocus;
      });
    });
  }

  // Gets height of ListView so it stays the same when keyboard is displayed (so keyboard doesn't overlay results)
  double? fetchBodyHeight() {
    if (key.currentContext != null) {
      final RenderBox box = key.currentContext!.findRenderObject() as RenderBox;

      return box.size.height;
    }

    return null;
  }

  @override
  void dispose() {
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    notifier = ValueNotifier(queryData.viewInsets.bottom);

    return ValueListenableBuilder<double>(
      valueListenable: notifier,
      builder: (context, value, _) => MutablePopup(
        controller: controller,
        defaultState: PanelState.CLOSED,
        draggable: true,
        minHeight: 0,
        onInteraction: dismissDetector
            ? () {
                node.unfocus();
              }
            : null,
        onClosed: () {
          node.unfocus();
        },
        onOpened: () {
          node.requestFocus();
        },
        maxHeight: value == 0
            ? kCountryCodeSelectorHeight // Refactor to new height
            : (kCountryCodeSelectorHeight + value),
        body: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: value == 0 ? double.infinity : fetchBodyHeight(),
            child: Padding(
              key: key,
              padding: EdgeInsets.fromLTRB(
                0,
                kHandleTopMargin,
                0,
                kBottomScreenMargin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: MutableHandle()),
                  SizedBox(height: kPanelHandleToHeader),
                  MutableText(
                    "Enter OTP",
                    align: TextAlign.center,
                    style:
                        kCountryCodeHeaderStyle, // Change name (used here and in emergency contacts)
                    weight:
                        kCountryCodeHeaderWeight, // Change name (used here and in emergency contacts)
                  ),
                  SizedBox(height: 6),
                  MutableText(
                    "Please enter the code sent to \n+506 7109 9519",
                    align: TextAlign.center,
                    style: TypeStyle.h5,
                    weight: TypeWeight.medium,
                    color: MutableColor.neutral2,
                  ),
                  Spacer(flex: 2),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: PinCodeTextField(
                      // Extract to mutable widget
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.none,
                      keyboardAppearance: kKeyboardAppearance,
                      textStyle: TextStyle(
                        color: kColorMap[MutableColor.neutral1],
                        fontFamily: kFontFamilyGen(weight: TypeWeight.heavy),
                        fontSize: 20,
                      ),
                      pinTheme: PinTheme(
                        fieldWidth: (345 / 6) - ((6 / 2) * 4), // CHANGE
                        // ACTIVE
                        activeColor: kColorMap[MutableColor.neutral7],
                        activeFillColor: kColorMap[MutableColor.neutral8],
                        // SELECTED
                        selectedColor: kColorMap[MutableColor.neutral6],
                        selectedFillColor: kColorMap[MutableColor.neutral7],
                        //INACTIVE
                        inactiveColor: kColorMap[MutableColor.neutral7],
                        inactiveFillColor: kColorMap[MutableColor.neutral8],
                        borderWidth: kBorderWidth,
                        borderRadius: BorderRadius.circular(12),
                        shape: PinCodeFieldShape.box,
                      ),
                      enableActiveFill: true,
                      showCursor: false,
                      focusNode: node,
                      appContext: context,
                      length: 6,
                      onChanged: (_) {},
                    ),
                  ),
                  MutableButton(
                    child: MutableText(
                      "Next code available in 3s",
                      align: TextAlign.center,
                      color: MutableColor.neutral4,
                      style: TypeStyle.body,
                    ),
                  ),
                  Spacer(flex: 3),
                  MutableText(
                    "Secured by Google",
                    align: TextAlign.center,
                    style: TypeStyle.h5,
                    weight: TypeWeight.regular,
                    color: MutableColor.neutral4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
