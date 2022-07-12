import 'package:flutter/material.dart';
import 'package:safe/screens/auth/local_widgets/signup_country_code_selector.widget.dart';
import 'package:safe/screens/auth/local_widgets/signup_message_banner.widget.dart';
import 'package:safe/screens/auth/name_input.screen.dart';
import 'package:safe/screens/auth/permissions.screen.dart';
import 'package:safe/screens/auth/phone_verification.screen.dart';

class SignupFlow {
  final List<Widget> widgets = [
    NameInputScreen(),
    PermissionsScreen(),
    PhoneVerificationScreen(),

    // Positioned at the bottom to always overlay screens
    SignupCountryCodeSelector(),
    SignupMessageBanner(),
  ];
}
