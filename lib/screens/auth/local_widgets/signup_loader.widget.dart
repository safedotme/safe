import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_overlay/mutable_overlay.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class SignupLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MutableOverlay(
      child: Center(child: MutableText("Hello world")),
    );
  }
}
