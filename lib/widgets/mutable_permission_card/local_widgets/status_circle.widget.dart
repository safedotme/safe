import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class StatusCircle extends StatefulWidget {
  final bool isAllowed;
  StatusCircle(
    this.isAllowed,
  );

  @override
  State<StatusCircle> createState() => _StatusCircleState();
}

class _StatusCircleState extends State<StatusCircle> {
  @override
  Widget build(BuildContext context) {
    Core core = Provider.of(context, listen: false);

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
        boxShadow:
            widget.isAllowed ? core.utils.color.applyGradientShadow(20) : null,
        gradient: widget.isAllowed
            ? LinearGradient(
                colors: kPrimaryGradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        shape: BoxShape.circle,
      ),
      child: Center(
          child: MutableIcon(
        MutableIcons.checkmark,
        size: Size(12, 12),
        color: kIconColorInGradientFill,
      )),
    );
  }
}
