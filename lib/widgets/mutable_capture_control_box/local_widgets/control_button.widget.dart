import 'package:flutter/material.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';

class ControlButton extends StatelessWidget {
  final void Function() onTap;
  final MutableIcons icon;
  final String text;

  ControlButton({
    required this.icon,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MutableButton(
        onTap: onTap,
        child: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}
