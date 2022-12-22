import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class MutableOverlayButton extends StatelessWidget {
  final MutableIcon icon;
  final void Function() onTap;
  final bool darkened;
  final bool isSmall;

  MutableOverlayButton({
    required this.icon,
    required this.onTap,
    this.darkened = false,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: onTap,
      child: Container(
        height: isSmall ? 35 : 40,
        width: isSmall ? 35 : 40,
        decoration: BoxDecoration(
          color: kColorMap[
                  darkened ? MutableColor.neutral3 : MutableColor.neutral2]!
              .withOpacity(0.55),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
