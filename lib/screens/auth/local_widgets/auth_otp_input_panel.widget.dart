import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_otp_input_panel/mutable_otp_input_panel.widget.dart';

class AuthOtpInputPanel extends StatefulWidget {
  @override
  State<AuthOtpInputPanel> createState() => _AuthOtpInputPanelState();
}

class _AuthOtpInputPanelState extends State<AuthOtpInputPanel> {
  late Core core;
  FocusNode node = FocusNode();

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  Future<void> resendCode() async {
    Map response = await core.services.auth.sendOTP(
      resedToken: core.state.auth.resendToken,
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
  }

  void handleError(String exception) {
    // Initialize error message values
    Map error = core.services.auth.handleError(core, exception);
    core.state.auth.setBannerState(MessageType.error);
    core.state.auth.setBannerMessage(error["desc"]);
    core.state.auth.setBannerTitle(error["header"]);

    // Display error message
    core.state.auth.bannerController.show();
  }

  Future<void> handleSubmit(
    String verificationId,
    String otp,
  ) async {
    core.state.auth.overlayController.show();
    Map<String, dynamic> response = await core.services.auth.verifyOTP(
      otp,
      verificationId,
    );

    if (core.services.auth.currentUser != null) {
      // Update in cloud firestore

      //Update in auth
      if (core.state.auth.name.isNotEmpty) {
        core.services.auth.currentUser!.updateDisplayName(
          core.state.auth.name,
        );
      }
      return;
    }

    // Add error handling (banner, close panel, navigate)
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableOtpInputPanel(
        controller: core.state.auth.otpInputPanelController,
        countryDialCode: core.state.auth.countryDialCode,
        phone: core.state.auth.phoneNumber,
        node: node,
        onTimeout: () {
          resendCode();
        },
        countryCode: core.state.auth.countryCode,
        onSubmit: (otp) {
          handleSubmit(
            core.state.auth.verificationId,
            otp,
          );
        },
      ),
    );
  }
}
