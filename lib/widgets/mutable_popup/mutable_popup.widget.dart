import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/non_pannel_body.widget.dart';
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
  final Widget Function(ScrollController controller)? scrollBuilder;
  final void Function(double state)? onSlide;
  final void Function()? onFreezeInteraction;
  final PanelController? controller;
  final PanelState defaultState;
  final bool backdropTapClose;
  final bool draggable;
  final double minHeight;
  final bool enableBorder;
  final double bottomInsets;
  final double maxHeight;

  final MutablePopupStyle? style;
  final Widget? body;

  /// [width] will not be applied with panel popup types
  final double? width;
  final double? height;

  MutablePopup({
    this.type = PopupType.pannel,
    this.enableBorder = true,
    this.onOpened,
    this.bottomInsets = 0,
    this.scrollBuilder,
    this.minHeight = 500,
    this.maxHeight = 770,
    this.onFreezeInteraction,
    this.width,
    this.onClosed,
    this.height,
    this.onSlide,
    this.controller,
    this.defaultState = PanelState.CLOSED,
    this.backdropTapClose = true,
    this.body,
    this.style,
    this.draggable = true,
  });

  @override
  State<MutablePopup> createState() => _MutablePopupState();
}

class _MutablePopupState extends State<MutablePopup> {
  late MediaQueryData queryData;
  late PanelController controller;

  // Determine height and width for non-panel popups
  late Size size;
  void setSize() {
    size = Size(
      widget.width ??
          (widget.type == PopupType.input
              ? kInputPopupWidth
              : queryData.size.width - (kSideMarginPreviewPopup * 2)),
      widget.height ??
          (widget.type == PopupType.input
              ? widget.height == null
                  ? kDefaultInputPopupHeight
                  : widget.height!
              : 323),
    );
  }

  // Generates default styles
  late MutablePopupStyle style;

  @override
  void initState() {
    super.initState();

    if (widget.controller != null) {
      controller = widget.controller!;
    } else {
      controller = PanelController();
    }
  }

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
      // Adds custom border for panel popups
      panel: GestureDetector(
        onVerticalDragStart: widget.onFreezeInteraction != null
            ? (_) {
                widget.onFreezeInteraction!();
              }
            : null,
        onTap: widget.onFreezeInteraction != null
            ? () {
                widget.onFreezeInteraction!();
              }
            : null,
        child: GestureDetector(
          onTap: () {
            if (!widget.backdropTapClose) return;
            controller.close();
          },
          child: Container(
            color: Colors.transparent,
            child: CustomPaint(
              // Will paint special border for Pannel popup
              painter: widget.enableBorder
                  ? widget.type == PopupType.pannel
                      ? PanelPopupPainter(
                          borderColor: style.borderColor,
                        )
                      : null
                  : null,
              child: GestureDetector(
                onTap: () {
                  print("here");
                },
                child: Container(
                  color: widget.type == PopupType.input
                      ? null
                      : Colors.transparent,
                  child: widget.type == PopupType.pannel
                      ? widget.body
                      : NonPannelBody(
                          size: size,
                          style: style,
                          body: widget.body,
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
      onPanelOpened: widget.onOpened,
      onPanelClosed: widget.onClosed,
      onPanelSlide: widget.onSlide,
      controller: controller,
      defaultPanelState: widget.defaultState,
      backdropTapClosesPanel: widget.backdropTapClose,
      isDraggable: widget.draggable,

      // Hides non-panel popups
      minHeight: widget.type == PopupType.pannel ? widget.minHeight : 0,

      // Generates heigt to center non-panel popups
      maxHeight: widget.type == PopupType.pannel
          ? widget.maxHeight
          : widget.type == PopupType.input
              ? ((queryData.size.height - widget.bottomInsets) / 2) +
                  (size.height / 2) +
                  widget.bottomInsets
              : size.height + kBottomMarginPreviewPopup,

      // Removes default shadows
      boxShadow: [],
      color: widget.type == PopupType.pannel
          ? style.backgroundColor!
          : Colors.transparent,
      backdropColor: style.backdropColor!,
      backdropEnabled: style.backdropEnabled,
      backdropOpacity: style.backdropOpacity!,
      panelBuilder: widget.scrollBuilder,
      // Removes popup border for non-panel popups
      borderRadius: widget.type == PopupType.pannel ? style.borderRadius : null,
      border: widget.type == PopupType.pannel ? style.border : null,
    );
  }
}
