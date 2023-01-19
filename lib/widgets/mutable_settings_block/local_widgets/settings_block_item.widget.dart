import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class SettingsBlockItem extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Widget? action;
  final Widget? following;
  final MutableColor textColor;

  SettingsBlockItem({
    required this.text,
    this.following,
    this.onTap,
    this.action,
    this.textColor = MutableColor.neutral1,
  });

  Widget addOnTap({required Widget child}) {
    if (onTap == null) {
      return child;
    }

    return MutableButton(
      onTap: onTap,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return addOnTap(
      child: Container(
        height: 48,
        color: Colors.transparent,
        child: Row(
          children: [
            MutableText(
              text,
              color: textColor,
              size: 18,
            ),
            following != null ? following! : SizedBox(),
            Spacer(),
            action != null
                ? action!
                : MutableIcon(
                    MutableIcons.caretRight,
                    size: Size(8, 14),
                    color: kColorMap[MutableColor.neutral3]!,
                  ),
          ],
        ),
      ),
    );
  }
}
