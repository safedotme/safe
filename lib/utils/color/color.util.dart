import 'package:flutter/material.dart' hide BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
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
    double opacity = 1,
  }) {
    double blurRad = (20 / 64) * size;
    double neutralOffset = (2 / 64) * size;
    double colorOffset = (4 / 64) * size;
    double lineRad = (1 / 64) * size;

    List<BoxShadow> colors = isColorful
        ? List.generate(
            3,
            (i) => BoxShadow(
              color: kPrimaryGradientColors[2 * i].withOpacity(0.1),
              blurRadius: blurRad,
              offset: Offset(
                (i.isEven ? -1 : 1) * colorOffset,
                colorOffset * (i > 1 ? -1 : 1),
              ),
            ),
          )
        : [];

    return [
      ...colors,
      BoxShadow(
        offset: Offset(neutralOffset, -neutralOffset),
        color: Colors.black.withOpacity(0.6 * opacity),
        blurRadius: blurRad,
        inset: true,
      ),
      BoxShadow(
        offset: Offset(neutralOffset, neutralOffset),
        blurRadius: blurRad,
        color: Colors.white.withOpacity(0.4 * opacity),
        inset: true,
      ),
      BoxShadow(
        offset: Offset(0, neutralOffset),
        color: Colors.white.withOpacity(0.7 * opacity),
        blurRadius: lineRad,
        inset: true,
      ),
    ];
  }
}
