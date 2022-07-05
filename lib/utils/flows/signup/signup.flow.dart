import 'package:flutter/material.dart';
import 'package:safe/screens/auth/name_input.screen.dart';
import 'package:safe/screens/auth/phone_input.screen.dart';

class SignupFlow {
  final List<Widget> widgets = [
    NameInputScreen(),
    PhoneInputScreen(),
  ];
}
