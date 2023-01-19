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

  SettingsBlockItem({
    required this.text,
    this.onTap,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: onTap,
      child: Container(
        height: 48,
        color: Colors.transparent,
        child: Row(
          children: [
            MutableText(
              text,
              size: 18,
            ),
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
