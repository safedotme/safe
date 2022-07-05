import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';

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
      child: Container(
        height: 60,
        width: 228,
        color: Colors.red,
      ),
    );
  }
}

class MutableGradientBorder extends StatefulWidget {
  final double width;
  final Widget child;

  MutableGradientBorder({
    this.width = 1.5,
    required this.child,
  });

  @override
  State<MutableGradientBorder> createState() => _MutableGradientBorderState();
}

class _MutableGradientBorderState extends State<MutableGradientBorder> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: widget.child,
    );
  }
}
