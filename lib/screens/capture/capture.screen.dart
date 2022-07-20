import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_tranistion.widget.dart';

class Capture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
