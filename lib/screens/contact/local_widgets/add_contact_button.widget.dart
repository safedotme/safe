import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class AddContactButton extends StatefulWidget {
  @override
  State<AddContactButton> createState() => _AddContactButtonState();
}

class _AddContactButtonState extends State<AddContactButton> {
  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: () {
        HapticFeedback.lightImpact();
        print("hello world");
      },
      scale: 0.9,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 18,
              width: 18,
              color: Colors.red,
            ),
            SizedBox(width: 6),
            MutableText(
              "Add contact", // TODO: Extract
              align: TextAlign.left,
              weight: TypeWeight.semiBold,
            ),
          ],
        ),
      ),
    );
  }
}
