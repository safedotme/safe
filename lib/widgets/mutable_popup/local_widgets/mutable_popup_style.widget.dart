import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';

class MutablePopupStyle {
  final Color? backdropColor;
  final Color? backgroundColor;
  final bool backdropEnabled;
  final double? backdropOpacity;
  final Border? border;

  /// [borderColor] will be overriden by the [border] property
  final Color? borderColor;
  final BorderRadius? borderRadius;

  MutablePopupStyle({
    this.borderColor,
    this.backdropColor,
    this.backgroundColor,
    this.backdropEnabled = true,
    this.backdropOpacity,
    this.border,
    this.borderRadius,
  });

  factory MutablePopupStyle.generateDefault(
      MutablePopupStyle style, PopupType type) {
    // Defines custom border for each popup type
    Border? customBorder = type != PopupType.pannel
        ? Border.all(
            width: 1.5,
            color: style.borderColor ?? kColorMap[MutableColor.neutral7]!,
          )
        : null;

    // Defines custom border radius for each popup type
    double customBorderRadius = type == PopupType.pannel
        ? kPanelPopupBorderRadius
        : type == PopupType.input
            ? kInputPopupBorderRadius
            : kPreviewPopupBorderRadius;

    return MutablePopupStyle(
      backdropColor: style.backdropColor ?? kColorMap[MutableColor.neutral10]!,
      backgroundColor:
          style.backgroundColor ?? kColorMap[MutableColor.neutral9]!,
      backdropEnabled: style.backdropEnabled,
      backdropOpacity:
          style.backdropOpacity ?? kTransparencyMap[Transparency.v80],
      border: style.border ?? customBorder,
      borderColor: style.borderColor,
      borderRadius: style.borderRadius ??
          BorderRadius.only(
            topRight: Radius.circular(customBorderRadius),
            topLeft: Radius.circular(customBorderRadius),

            // Adds bottom border radius when visible to users
            bottomLeft: type == PopupType.input || type == PopupType.preview
                ? Radius.circular(customBorderRadius)
                : Radius.zero,
            bottomRight: type == PopupType.input || type == PopupType.preview
                ? Radius.circular(customBorderRadius)
                : Radius.zero,
          ),
    );
  }
}
