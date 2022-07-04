import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MutableScaffold(
      overlays: [
        Container(
          color: Colors.green,
          height: 100,
          width: 100,
        )
      ],
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
