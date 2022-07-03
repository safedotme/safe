import 'package:flutter/material.dart';

class MutableScaffold extends StatelessWidget {
  final bool resizeToAvoidBottomInsets;
  final EdgeInsets? margin;
  final Widget body;
  // TODO: Implement notifications and other popups

  MutableScaffold({
    required this.body,
    this.resizeToAvoidBottomInsets = false,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
