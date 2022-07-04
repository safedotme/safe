import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
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
  final MutablePopupStyle? style;
  final Widget body;

  /// [width] will not be applied with panel popup types
  final double? width;

  /// [height] will not be applied with panel popup types
  final double? height;

  MutablePopup({
    this.type = PopupType.pannel,
    this.onOpened,
    this.minHeight = 500,
    this.maxHeight = 770,
    this.width,
    this.onClosed,
    this.height,
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
  late MediaQueryData queryData;

  // Used to determine height and width for non-panel popups
  late Size size;
  void setSize() {
    size = Size(
      widget.width ??
          (widget.type == PopupType.input ? 265 : queryData.size.width - 22),
      widget.height ?? (widget.type == PopupType.input ? 243 : 323),
    );
  }

  // Generates default styles
  late MutablePopupStyle style;

  @override
  Widget build(BuildContext context) {
    // Initialize query data
    queryData = MediaQuery.of(context);
    setSize();

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
        child: widget.type == PopupType.pannel
            ? widget.body
            : Align(
                alignment: Alignment.topCenter,
                child: Container(
                  // EXTRACT
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: style.backgroundColor,
                    border: style.border,
                    borderRadius: style.borderRadius,
                  ),
                  child: SizedBox(
                    height: 60,
                    child: widget.body,
                  ),
                ),
              ),
      ),
      onPanelOpened: widget.onOpened,
      onPanelClosed: widget.onClosed,
      onPanelSlide: widget.onSlide,
      controller: widget.controller,
      defaultPanelState: widget.defaultState,
      backdropTapClosesPanel: widget.backdropTapClose,
      isDraggable: widget.draggable,
      minHeight: widget.type == PopupType.pannel ? widget.minHeight : 0,
      maxHeight: widget.type == PopupType.pannel
          ? widget.minHeight
          : widget.type == PopupType.input
              ? (queryData.size.height / 2) + (size.height / 2)
              : size.height + 34,
      boxShadow: [],
      color: widget.type == PopupType.pannel
          ? style.backgroundColor!
          : Colors.transparent,
      backdropColor: style.backdropColor!,
      backdropEnabled: style.backdropEnabled,
      backdropOpacity: style.backdropOpacity!,
      borderRadius: widget.type == PopupType.pannel ? style.borderRadius : null,
      border: widget.type == PopupType.pannel ? style.border : null,
    );
  }
}