import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_pin_code_textfield/mutable_pin_code_textfield.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableOtpInputPanel extends StatefulWidget {
  final PanelController controller;
  final void Function(String otp) onSubmit;
  final String phone;
  final FocusNode? node;
  final String countryDialCode;
  final String countryCode;

  MutableOtpInputPanel({
    required this.controller,
    this.node,
    required this.phone,
    required this.countryDialCode,
    required this.countryCode,
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
  late FocusNode node;
  GlobalKey key = GlobalKey();

  // State values
  bool dismissDetector = false;
  String time = kSMSTimeout.inSeconds.toString();

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    controller = widget.controller;
    node = widget.node ?? FocusNode();

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

  Future<void> handleTimer() async {}

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
        onFreezeInteraction: dismissDetector
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
        maxHeight:
            value == 0 ? kOTPInputPopupHeight : (kOTPInputPopupHeight + value),
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
                    core.utils.language.langMap[core.state.preferences
                        .language]!["otp_input_panel"]["header"],
                    align: TextAlign.center,
                    style: kPanelPopupHeaderStyle,
                    weight: kPanelPopupHeaderWeight,
                  ),
                  SizedBox(height: 6),
                  Observer(
                    builder: (context) => MutableText(
                      core
                          .utils
                          .language
                          .langMap[core.state.preferences.language]![
                              "otp_input_panel"]["desc"]
                          .toString()
                          .replaceAll(
                            "{phone}",
                            "${widget.countryDialCode} ${core.state.signup.formattedPhone}",
                          ),
                      align: TextAlign.center,
                      style: kPanelPopupSubheaderStyle,
                      weight: kPanelPopupSubheaderWeight,
                      color: kPanelPopupSubheaderColor,
                    ),
                  ),
                  Spacer(flex: 2),
                  Center(
                    child: MutablePinCodeTextField(
                      focusNode: node,
                      onChanged: (_) {},
                      onComplete: (otp) {
                        widget.onSubmit(otp);
                      },
                    ),
                  ),
                  MutableButton(
                    child: MutableText(
                      core
                          .utils
                          .language
                          .langMap[core.state.preferences.language]![
                              "otp_input_panel"]["next_code"]
                          .toString()
                          .replaceAll("{time}", time),
                      align: TextAlign.center,
                      color: MutableColor.neutral4,
                      style: TypeStyle.body,
                    ),
                  ),
                  Spacer(flex: 3),
                  MutableText(
                    core.utils.language.langMap[core.state.preferences
                        .language]!["otp_input_panel"]["secured_by_stamp"],
                    align: TextAlign.center,
                    style: TypeStyle.h5,
                    weight: TypeWeight.regular,
                    color: MutableColor.neutral5,
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
