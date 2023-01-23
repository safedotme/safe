import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
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
  final void Function() onTimeout;

  MutableOtpInputPanel({
    required this.controller,
    this.node,
    required this.phone,
    required this.countryDialCode,
    required this.onTimeout,
    required this.countryCode,
    required this.onSubmit,
  });

  @override
  State<MutableOtpInputPanel> createState() => _MutableOtpInputPanelState();
}

class _MutableOtpInputPanelState extends State<MutableOtpInputPanel> {
  late Core core;
  late PanelController controller;
  late ValueNotifier<double> notifier;
  late MediaQueryData queryData;
  late FocusNode node;
  Timer? timer;
  TextEditingController fieldController = TextEditingController();
  GlobalKey key = GlobalKey();
  int attempts = kSMSRetryAttempts;
  bool canResend = false;

  // State values
  bool dismissDetector = false;
  int time = kSMSTimeout.inSeconds;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    controller = widget.controller;
    node = widget.node ?? FocusNode();

    // Enables user to drag or tap to dismiss keyboard when enabled
    node.addListener(() {
      if (mounted) {
        setState(() {
          dismissDetector = node.hasFocus;
        });
      }
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

  void resetTimer() {
    setState(() {
      fieldController.text = "";
      canResend = false;
      time = kSMSTimeout.inSeconds;
    });

    if (timer != null) {
      timer!.cancel();
    }
  }

  Future<void> handleAttempt() async {
    // Resets timer to 30 seconds
    resetTimer();
    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        // Checks if time has run out
        if (time == 0) {
          if (mounted) {
            setState(() {
              canResend = true;
            });
          }
          timer.cancel();
          return;
        }

        // If not, takes from timer
        if (mounted) {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  Widget applyMask(Widget child) => canResend
      ? ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: kPrimaryGradientColors,
            begin: Alignment(-2, -2),
            end: Alignment(2, 2),
          ).createShader(bounds),
          child: child,
        )
      : SizedBox(child: child);

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
          resetTimer();
          node.unfocus();
        },
        onOpened: () {
          handleAttempt();
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
                            "${widget.countryDialCode} ${core.state.auth.formattedPhone}",
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
                      controller: fieldController,
                      focusNode: node,
                      onChanged: (_) {},
                      onComplete: (otp) {
                        widget.onSubmit(otp);
                      },
                    ),
                  ),
                  MutableButton(
                    onTap: () {
                      if (canResend) {
                        if (attempts != 0) {
                          handleAttempt();
                          widget.onTimeout();
                          attempts--;
                          return;
                        }

                        core.state.auth.actionController.trigger(
                          core.utils.language.langMap[core.state.preferences
                              .language]!["otp_input_panel"]["attempts_error"],
                          MessageType.error,
                        );
                        return;
                      }
                    },
                    child: applyMask(
                      MutableText(
                        canResend
                            ? core.utils.language.langMap[core.state.preferences
                                .language]!["otp_input_panel"]["resend_code"]
                            : core
                                .utils
                                .language
                                .langMap[core.state.preferences.language]![
                                    "otp_input_panel"]["next_code"]
                                .toString()
                                .replaceAll("{time}", time.toString()),
                        align: TextAlign.center,
                        style: TypeStyle.body,
                        color: canResend
                            ? MutableColor.neutral1
                            : MutableColor.neutral4,
                      ),
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
