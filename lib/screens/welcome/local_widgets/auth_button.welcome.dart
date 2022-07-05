import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_gradient_border/mutable_gradient_border.widget.dart';

enum AuthButtonType {
  signup,
  login,
}

class AuthButton extends StatelessWidget {
  final AuthButtonType type;

  AuthButton(this.type);
  @override
  Widget build(BuildContext context) {
    return MutableButton(
      child: MutableGradientBorder(
        child: Container(
          height: 60,
          width: 228,
          color: Colors.red,
        ),
      ),
    );
  }
}
