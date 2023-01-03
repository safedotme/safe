import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class DataPointKey extends StatelessWidget {
  final MutableIcon icon;
  final String text;

  DataPointKey(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: 6),
        MutableText(
          text.toUpperCase(),
          size: 14,
          weight: TypeWeight.semiBold,
          color: MutableColor.neutral3,
        ),
      ],
    );
  }
}
