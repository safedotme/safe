import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
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

  Future<void> handleSubmit(
    String verificationId,
    String otp,
  ) async {
    // Add loader
    node.unfocus();
    Map<String, dynamic> response = await core.utils.auth.verifyOTP(
      otp,
      verificationId,
    );

    if (response["status"]) {
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
