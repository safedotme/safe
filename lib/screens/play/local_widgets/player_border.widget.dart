import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class PlayerBorder extends StatelessWidget {
  final bool isTop;

  PlayerBorder(this.isTop);

  List<Color> genColors() {
    var colors = [
      kColorMap[MutableColor.neutral10]!.withOpacity(0.8),
      kColorMap[MutableColor.neutral10]!.withOpacity(0),
    ];

    return isTop ? colors : colors.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: genColors(),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
