import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum PopupType {
  pannel,
  input,
  preview,
}

class MutablePopupStyle {
  final Color? backdropColor; // n10
  final Color? backgroundColor; // n9
  final bool backdropEnabled; // TRUE
  final double? backdropOpacity; // 0.8

  MutablePopupStyle({
    this.backdropColor,
    this.backgroundColor,
    this.backdropEnabled = true,
    this.backdropOpacity,
  });
}

class MutablePopup extends StatefulWidget {
  final PopupType type;
  final void Function()? onOpened;
  final void Function()? onClosed;
  final void Function(double state)? onSlide;
  final PanelController? controller;
  final PanelState defaultState;
  final bool backdropTapClose;
  final bool draggable;
  final Widget body;
  final MutablePopupStyle? style;

  MutablePopup({
    required this.type,
    this.onOpened,
    this.onClosed,
    this.onSlide,
    this.controller,
    this.defaultState = PanelState.CLOSED,
    this.backdropTapClose = true,
    required this.body,
    this.style,
    this.draggable = true,
  });

  @override
  State<MutablePopup> createState() => _MutablePopupState();
}

class _MutablePopupState extends State<MutablePopup> {
  @override
  Widget build(BuildContext context) {
    return;
  }
}
