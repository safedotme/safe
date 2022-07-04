import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableScaffold extends StatelessWidget {
  final bool resizeToAvoidBottomInsets;
  final EdgeInsets? margin;
  final Widget body;
  final List<Widget>? overlays;

  MutableScaffold({
    required this.body,
    this.resizeToAvoidBottomInsets = false,
    this.margin,
    this.overlays,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInsets,
      body: overlays != null ? Stack(children: [body, ...overlays!]) : body,
      backgroundColor: kColorMap[MutableColor.neutral10],
    );
  }
}
