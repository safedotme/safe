import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class CountryCode extends StatelessWidget {
  final Map<String, String> country;
  final void Function()? onTap;

  CountryCode(this.country, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        color: Colors.transparent,
        child: Row(
          children: [
            MutableText(
              country["name"] ?? "Unable to load",
              style: TypeStyle.body,
            ),
            SizedBox(width: 4),
            MutableText(
              country["code"] ?? "",
              style: TypeStyle.body,
              color: MutableColor.neutral2,
            ),
          ],
        ),
      ),
    );
  }
}
