import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class MutableSubmitTextFieldButton extends StatelessWidget {
  final void Function()? onSubmit;

  MutableSubmitTextFieldButton(this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: () {
        onSubmit?.call();
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
        child: MutableIcon(
          MutableIcons.next,
          size: Size(24, 24),
          color: kColorMap[MutableColor.neutral3]!,
        ),
      ),
    );
  }
}
