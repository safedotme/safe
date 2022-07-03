import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/big_mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

enum PopupType {
  big,
  medium,
  small,
}

class MutablePopup extends StatelessWidget {
  final PopupType type;
  final Widget? body;
  final bool dismissable;
  final double? height;

  /// Are only used in the PopupType.big component
  final double? minPoint;

  /// Are only used in the PopupType.big component
  final double? maxPoint;

  /// This will override the default styling of the component
  final MutablePopupStyle? style;

  MutablePopup({
    this.type = PopupType.big,
    this.body,
    this.dismissable = true,
    this.height,
    this.minPoint,
    this.maxPoint,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return BigMutablePopup();
  }
}
