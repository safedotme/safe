import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class StatusCircle extends StatefulWidget {
  final bool isAllowed;
  StatusCircle(this.isAllowed);

  @override
  State<StatusCircle> createState() => _StatusCircleState();
}

class _StatusCircleState extends State<StatusCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        border: !widget.isAllowed
            ? Border.all(
                width: 1.5,
                color: kColorMap[MutableColor.neutral4]!,
              )
            : null,
        gradient: widget.isAllowed
            ? LinearGradient(
                colors: kPrimaryGradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        shape: BoxShape.circle,
      ),
    );
  }
}
