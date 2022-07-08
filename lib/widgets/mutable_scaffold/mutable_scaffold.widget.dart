import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableScaffold extends StatelessWidget {
  final bool resizeToAvoidBottomInsets;
  final EdgeInsets? margin;
  final Widget body;
  final List<Widget>? underlays;
  final List<Widget>? overlays;

  MutableScaffold({
    required this.body,
    this.resizeToAvoidBottomInsets = false,
    this.margin,
    this.overlays,
    this.underlays,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> populateStack() {
      List<Widget> widgets = [body];

      if (overlays != null) {
        widgets = widgets + overlays!;
      }

      if (underlays != null) {
        widgets = underlays! + widgets;
      }

      return widgets;
    }

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInsets,
      body: Stack(children: populateStack()),
      backgroundColor: kColorMap[MutableColor.neutral10],
    );
  }
}
