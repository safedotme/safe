import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';

class NonPannelBody extends StatelessWidget {
  final Size size;
  final MutablePopupStyle style;
  final Widget? body;

  NonPannelBody({
    required this.size,
    required this.style,
    this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
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
        child: body,
      ),
    );
  }
}
