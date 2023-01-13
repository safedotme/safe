import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_input_panel/mutable_input_panel.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_submit_textfield_button/mutable_submit_textfield_button.widget.dart';
import 'package:safe/widgets/mutable_text_field/local_widgets/phone_extention_display.widget.dart';
import 'package:safe/widgets/mutable_text_field/mutable_text_field.widget.dart';

class PhoneVerificationScreen extends StatefulWidget {
  @override
  State<PhoneVerificationScreen> createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen>
    with TickerProviderStateMixin {
  late Core core;
  late MediaQueryData queryData;
  late AnimationController controller;
  late TextEditingController fieldController;
  bool validated = false;
  FocusNode node = FocusNode();
  bool dismissDetector = false;

  // Animates popup down with banner when banners are displayed
  double? topMargin;
  void initializeAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: kMutableBannerDuration,
    );

    // Initialize tween
    Animation tween =
        Tween<double>(begin: topMargin, end: kMutableBannerHeight + 20)
            // 20 is the margin between the banner and the popup
            .animate(
      CurvedAnimation(parent: controller, curve: Curves.ease),
    );

    controller.addListener(() {
      setState(() {
        topMargin = tween.value;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);

    // Sync forward & reverse functionality with banner
    core.state.auth.setOnBannerForward(() {
      controller.forward();
    });
    core.state.auth.setOnBannerReverse(() {
      controller.reverse();
    });

    // Initialize text editing controller for auto phone format
    fieldController = TextEditingController();
    core.state.auth.setOnPick(format);

    // Enables user to drag or tap to dismiss keyboard when enabled
    node.addListener(() {
      setState(() {
        dismissDetector = node.hasFocus;
      });
    });
  }

  // Generates different hint text based on country
  String handleHint(String code) {
    return core.utils.phone.generateHint(code);
  }

  void submit() async {
    core.state.auth.countryCodeController.close();
    node.unfocus();

    validated = await core.utils.phone.validate(
      core.state.auth.phoneNumber,
      core.state.auth.countryCode,
    );

    // Sends OTP and opens OTP popup
    if (validated) {
      Map response = await core.services.auth.sendOTP(
        phone: core.state.auth.phoneNumber,
        dialCode: core.state.auth.countryDialCode,
        onCodeSend: (verificationId, resentToken) {
          print(
            "OPT code has been sent to ${core.state.auth.formattedPhone}. Verification ID: $verificationId",
          );

          core.state.auth.setVerificationId(verificationId);
          core.state.auth.setResendToken(resentToken);
        },
      );

      if (!response["status"]) {
        handleError(response["error"]);
        return;
      }

      node.unfocus();
      core.state.auth.otpInputPanelController.open();
      return;
    }

    handleError(
      fieldController.text.isEmpty ? "no-phone-number" : "invalid-phone-number",
    );
  }

  // Displays invalid phone number
  void handleError(String exception) {
    // Initialize error message values
    Map error = core.services.auth.handleError(core, exception);
    core.state.auth.setBannerState(MessageType.error);
    core.state.auth.setBannerMessage(error["desc"]);
    core.state.auth.setBannerTitle(error["header"]);

    // Display error message
    core.state.auth.bannerController.show();
  }

  // Formats a phone while is being typed
  void format(String? phone) async {
    if (phone == null) {
      return;
    }

    // Removes all symbols from fieldController value
    String pure = core.utils.text.removeSymbols(phone);

    fieldController.text = await core.utils.phone.format(
      pure,
      core.state.auth.countryCode,
    );

    // Sets cursor position to end
    fieldController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: fieldController.text.length,
      ),
    );

    core.state.auth.setPhoneNumber(pure);
    core.state.auth.setFormattedPhone(fieldController.text);
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);

    if (topMargin == null) {
      topMargin = queryData.padding.top;
      initializeAnimation();
    }

    return MutablePopup(
      minHeight: 0,
      maxHeight: queryData.size.height - topMargin!,
      controller: core.state.auth.phoneVerificationController,
      onFreezeInteraction: dismissDetector
          ? () {
              node.unfocus();
            }
          : null,
      onClosed: () {
        core.state.auth.countryCodeController.close();
        node.unfocus();
        core.state.auth.bannerController.dismiss();
        if (core.state.auth.authType == AuthType.signup) {
          core.state.auth.nameInputController.open();
        }
      },
      body: MutableInputPanel(
        // Phone Input Text Field
        body: Observer(
          builder: (_) => MutableTextField(
            onSubmit: (_) {
              submit();
            },
            controller: fieldController,
            type: TextInputType.phone,
            focusNode: node,
            onChange: format,
            hintText: handleHint(core.state.auth.countryCode),
            leadingRight: MutableSubmitTextFieldButton(submit),
            leadingLeft: Observer(
              builder: (_) => PhoneExtentionDisplay(
                core.state.auth.countryDialCode,
                onTap: () {
                  node.unfocus();
                  core.state.auth.countryCodeController.open();
                },
              ),
            ),
          ),
        ),
        resizeToAvoidBottomInsets: true,
        // Display related properties
        title: core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["phone_verification"]["title"], // "Enter Phone Number"
        description: core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["phone_verification"]["desc"], // "We'll send you..."
        icon: MutableIcons.phone,
        // Size is custom due to SVG specifications
        iconSize: Size(26, 26),
        onTap: submit,
        isActive: true,
        buttonText: core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["phone_verification"]["buttonText"], // "Send Link"
      ),
    );
  }
}
