import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class LegalCheckmark extends StatefulWidget {
  final bool isAllowed;

  LegalCheckmark(this.isAllowed);

  @override
  State<LegalCheckmark> createState() => _LegalCheckmarkState();
}

class _LegalCheckmarkState extends State<LegalCheckmark> {
  late Core core;

  @override
  void initState() {
    core = Provider.of<Core>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      width: 22,
      decoration: BoxDecoration(
        border: !widget.isAllowed
            ? Border.all(
                width: kBorderWidth,
                color: kColorMap[MutableColor.neutral4]!,
              )
            : Border.all(
                width: kBorderWidth,
                color: Colors.white.withOpacity(0.3),
              ),
        boxShadow:
            widget.isAllowed ? core.utils.color.applyGradientShadow(20) : null,
        image: widget.isAllowed
            ? DecorationImage(
                image: AssetImage("assets/images/gradient.png"),
              )
            : null,
        borderRadius: BorderRadius.circular(6),
      ),
      child: widget.isAllowed
          ? Center(
              child: MutableIcon(
              MutableIcons.checkmark,
              size: Size(12, 12),
              color: kIconColorInGradientFill,
            ))
          : null,
    );
  }
}
