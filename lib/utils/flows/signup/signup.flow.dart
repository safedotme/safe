import 'package:flutter/material.dart';
import 'package:safe/screens/auth/local_widgets/signup_country_code_selector.widget.dart';
import 'package:safe/screens/auth/local_widgets/signup_message_banner.widget.dart';
import 'package:safe/screens/auth/local_widgets/signup_otp_input_panel.widget.dart';
import 'package:safe/screens/auth/name_input.screen.dart';
import 'package:safe/screens/auth/permissions.screen.dart';
import 'package:safe/screens/auth/phone_verification.screen.dart';

class SignupFlow {
  final List<Widget> widgets = [
    NameInputScreen(),
    PermissionsScreen(),
    PhoneVerificationScreen(),

    // Positioned at the bottom of the list to always overlay screens
    SignupCountryCodeSelector(),
    SignupOtpInputPanel(),
    SignupMessageBanner(),
  ];
}

class MutableOverlay extends StatefulWidget {
  @override
  State<MutableOverlay> createState() => _MutableOverlayState();
}

class _MutableOverlayState extends State<MutableOverlay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
