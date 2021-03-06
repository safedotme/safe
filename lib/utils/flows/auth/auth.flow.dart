import 'package:flutter/material.dart';
import 'package:safe/screens/auth/local_widgets/auth_country_code_selector.widget.dart';
import 'package:safe/screens/auth/local_widgets/auth_loader.widget.dart';
import 'package:safe/screens/auth/local_widgets/auth_message_banner.widget.dart';
import 'package:safe/screens/auth/local_widgets/auth_otp_input_panel.widget.dart';
import 'package:safe/screens/auth/name_input.screen.dart';
import 'package:safe/screens/auth/permissions.screen.dart';
import 'package:safe/screens/auth/phone_verification.screen.dart';

class AuthFlow {
  final List<Widget> widgets = [
    // Refactor for login
    NameInputScreen(),
    PermissionsScreen(),
    PhoneVerificationScreen(),

    // Positioned at the bottom of the list to always overlay screens
    AuthCountryCodeSelector(),
    AuthOtpInputPanel(),
    AuthMessageBanner(),
    AuthLoader(),
  ];
}
