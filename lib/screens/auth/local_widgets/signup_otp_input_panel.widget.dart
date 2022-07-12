import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_otp_input_panel/mutable_otp_input_panel.widget.dart';

class SignupOtpInputPanel extends StatefulWidget {
  @override
  State<SignupOtpInputPanel> createState() => _SignupOtpInputPanelState();
}

class _SignupOtpInputPanelState extends State<SignupOtpInputPanel> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableOtpInputPanel(
        controller: core.state.signup.otpInputPanelController,
        countryDialCode: core.state.signup.countryDialCode,
        phone: core.state.signup.phoneNumber,
        countryCode: core.state.signup.countryCode,
        onSubmit: (otp) {
          print(otp);
        },
      ),
    );
  }
}
