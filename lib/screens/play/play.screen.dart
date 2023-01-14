import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';

class PlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
