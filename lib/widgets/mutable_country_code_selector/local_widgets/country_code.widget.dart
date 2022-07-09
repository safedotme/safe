import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class CountryCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MutableText(
          "United States",
          style: TypeStyle.body,
        ),
        SizedBox(width: 2),
        MutableText(
          "(+1)",
          style: TypeStyle.body,
          color: MutableColor.neutral2,
        ),
      ],
    );
  }
}
