import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/panel_popup_painter.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum PopupType {
  pannel,
  input,
  preview,
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
  final double minHeight;
  final double maxHeight;
  final Widget body;
  final MutablePopupStyle? style;

  MutablePopup({
    this.type = PopupType.pannel,
    this.onOpened,
    this.minHeight = 500,
    this.maxHeight = 770,
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
  // Generates default styles
  late MutablePopupStyle style;

  @override
  Widget build(BuildContext context) {
    // Called in build statement to maintain state change ability
    style = MutablePopupStyle.generateDefault(
      widget.style ?? MutablePopupStyle(),
      widget.type,
    );

    return SlidingUpPanel(
      panel: CustomPaint(
        // Will paint special border for Pannel popup
        painter: widget.type == PopupType.pannel
            ? PanelPopupPainter(
                borderColor: style.borderColor,
              )
            : null,
        child: widget.body,
      ),
      onPanelOpened: widget.onOpened,
      onPanelClosed: widget.onClosed,
      onPanelSlide: widget.onSlide,
      controller: widget.controller,
      defaultPanelState: widget.defaultState,
      backdropTapClosesPanel: widget.backdropTapClose,
      isDraggable: widget.draggable,
      minHeight: widget.minHeight,
      maxHeight: widget.maxHeight,
      boxShadow: [],
      color: style.backgroundColor!,
      backdropColor: style.backdropColor!,
      backdropEnabled: style.backdropEnabled,
      backdropOpacity: style.backdropOpacity!,
      borderRadius: style.borderRadius,
      border: style.border,
    );
  }
}
