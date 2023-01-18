import 'package:flutter/material.dart';

class SettingsBlockItem extends StatelessWidget {
  final Widget? prefix;
  final String text;
  final void Function()? onTap;
  final Widget? action;

  SettingsBlockItem({
    this.prefix,
    required this.text,
    this.onTap,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.red,
    );
  }
}
