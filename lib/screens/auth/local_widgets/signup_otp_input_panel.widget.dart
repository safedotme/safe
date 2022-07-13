import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_otp_input_panel/mutable_otp_input_panel.widget.dart';

class SignupOtpInputPanel extends StatefulWidget {
  @override
  State<SignupOtpInputPanel> createState() => _SignupOtpInputPanelState();
}

class _SignupOtpInputPanelState extends State<SignupOtpInputPanel> {
  late Core core;
  FocusNode node = FocusNode();

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  Future<void> resendCode() async {
    Map response = await core.utils.auth.sendOTP(
      resedToken: core.state.signup.resendToken,
      phone: core.state.signup.phoneNumber,
      dialCode: core.state.signup.countryDialCode,
      onCodeSend: (verificationId, resentToken) {
        print(
          "OPT code has been sent to ${core.state.signup.formattedPhone}. Verification ID: $verificationId",
        );

        core.state.signup.setVerificationId(verificationId);
        core.state.signup.setResendToken(resentToken);
      },
    );

    if (!response["status"]) {
      handleError(response["error"]);
      return;
    }
  }

  void handleError(String exception) {
    // Initialize error message values
    Map error = core.utils.auth.handleError(core, exception);
    core.state.signup.setBannerState(MessageType.error);
    core.state.signup.setBannerMessage(error["desc"]);
    core.state.signup.setBannerTitle(error["header"]);

    // Display error message
    core.state.signup.bannerController.show();
  }

  Future<void> handleSubmit(
    String verificationId,
    String otp,
  ) async {
    core.state.signup.overlayController.show();
    node.unfocus();
    Map<String, dynamic> response = await core.utils.auth.verifyOTP(
      otp,
      verificationId,
    );

    if (response["status"]) {
      core.state.signup.overlayController.hide();
      return;
    }

    // Add error handling (banner, close panel, navigate)
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableOtpInputPanel(
        controller: core.state.signup.otpInputPanelController,
        countryDialCode: core.state.signup.countryDialCode,
        phone: core.state.signup.phoneNumber,
        node: node,
        onTimeout: () {
          resendCode();
        },
        countryCode: core.state.signup.countryCode,
        onSubmit: (otp) {
          handleSubmit(
            core.state.signup.verificationId,
            otp,
          );
        },
      ),
    );
  }
}
