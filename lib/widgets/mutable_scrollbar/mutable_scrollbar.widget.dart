import 'package:flutter/material.dart';

class MutableScrollBar extends StatelessWidget {
  final Widget child;
  MutableScrollBar({required this.child});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: child,
    );
  }
}
