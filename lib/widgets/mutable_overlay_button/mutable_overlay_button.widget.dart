import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class MutableOverlayButton extends StatelessWidget {
  final MutableIcon icon;
  final void Function() onTap;
  final bool animateBeforeVoidCallback;
  final bool isDarkened;
  final bool isActive;

  MutableOverlayButton({
    required this.icon,
    required this.onTap,
    this.animateBeforeVoidCallback = false,
    this.isDarkened = false,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: onTap,
      animateBeforeVoidCallback: animateBeforeVoidCallback,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          color: (isActive
                  ? Colors.white
                  : kColorMap[isDarkened
                      ? MutableColor.neutral3
                      : MutableColor.neutral2]!)
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
