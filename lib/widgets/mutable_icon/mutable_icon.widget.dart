import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/icon/icon.util.dart';

class MutableIcon extends StatelessWidget {
  final Size? size;
  final Color color;
  final MutableIcons icon;

  MutableIcon(
    this.icon, {
    this.size,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of(context, listen: false);

    return CustomPaint(
      size: size ?? Size(20, 20),
      painter: core.utils.icons.iconsMap[icon]!(color),
    );
  }
}
