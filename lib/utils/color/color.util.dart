import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class ColorUtils {
  Color translucify(MutableColor color, Transparency tspcy) =>
      kColorMap[color]!.withOpacity(
        kTransparencyMap[tspcy]!,
      );

  Color generateColor(Color base, Color animateTo, double state) {
    int rDiff = animateTo.red - base.red;
    int gDiff = animateTo.green - base.green;
    int bDiff = animateTo.blue - base.blue;
    double oDiff = animateTo.opacity - base.opacity;

    return Color.fromRGBO(
      base.red + (rDiff * state).round(),
      base.green + (gDiff * state).round(),
      base.blue + (bDiff * state).round(),
      base.opacity + (oDiff * state),
    );
  }

  List<BoxShadow> applyGradientShadow(
    double size, {
    bool isColorful = true,
    double? opacity,
  }) {
    double blurRad = (20 / 64) * size;
    double colorOffset = (4 / 64) * size;

    List<BoxShadow> colors = isColorful
        ? List.generate(
            3,
            (i) => BoxShadow(
              color: kPrimaryGradientColors[2 * i].withOpacity(opacity ?? 0.1),
              blurRadius: blurRad,
              offset: Offset(
                (i.isEven ? -1 : 1) * colorOffset,
                colorOffset * (i > 1 ? -1 : 1),
              ),
            ),
          )
        : [];

    return colors;
  }
}
