import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';

class PhoneExtentionDisplay extends StatelessWidget {
  final void Function() onTap;

  PhoneExtentionDisplay({required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: kWidgetSpacing),
      child: MutableButton(
        onTap: onTap,
        child: Text(
          "(+506)",
          style: kTextInputStyle.copyWith(
            color: kColorMap[MutableColor.neutral2],
          ),
        ),
      ),
    );
  }
}
