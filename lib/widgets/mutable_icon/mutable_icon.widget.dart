import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';

class MutableIcon extends StatelessWidget {
  final MutableIcons icon;
  final MutableColor color;
  final Size? size;

  MutableIcon(
    this.icon, {
    this.color = MutableColor.neutral1,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);

    return CustomPaint(
      size: size ?? Size(20, 20),
      painter: core.utils.icons.icons[icon]!(Colors.white),
    );
  }
}
