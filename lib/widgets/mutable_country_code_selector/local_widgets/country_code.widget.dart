import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class CountryCode extends StatelessWidget {
  final Map<String, String> country;

  CountryCode(this.country);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MutableText(
          country["name"] ?? "Unable to load",
          style: TypeStyle.body,
        ),
        SizedBox(width: 2),
        MutableText(
          country["code"] ?? "",
          style: TypeStyle.body,
          color: MutableColor.neutral2,
        ),
      ],
    );
  }
}
