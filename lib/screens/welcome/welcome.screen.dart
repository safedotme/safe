import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MutableScaffold(
      body: MutablePopup(),
    );
  }
}
