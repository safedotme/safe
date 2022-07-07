import 'package:flutter/material.dart' hide BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:safe/utils/constants/constants.util.dart';

class ColorUtils {
  Color translucify(MutableColor color, Transparency tspcy) =>
      kColorMap[color]!.withOpacity(
        kTransparencyMap[tspcy]!,
      );

  List<BoxShadow> applyGradientShadow(double size) {
    double blurRad = (20 / 64) * size;
    double neutralOffset = (2 / 64) * size;
    double colorOffset = (4 / 64) * size;
    double lineRad = (1 / 64) * size;

    return [
// Color Shadows
      ...List.generate(
        3,
        (i) => BoxShadow(
          color: kPrimaryGradientColors[2 * i].withOpacity(0.1),
          blurRadius: blurRad,
          offset: Offset(
            (i.isEven ? -1 : 1) * colorOffset,
            colorOffset * (i > 1 ? -1 : 1),
          ),
        ),
      ),
      BoxShadow(
        offset: Offset(neutralOffset, -neutralOffset),
        color: Colors.black.withOpacity(0.6),
        blurRadius: blurRad,
        inset: true,
      ),
      BoxShadow(
        offset: Offset(neutralOffset, neutralOffset),
        blurRadius: blurRad,
        color: Colors.white.withOpacity(0.4),
        inset: true,
      ),
      BoxShadow(
        offset: Offset(0, neutralOffset),
        color: Colors.white.withOpacity(0.7),
        blurRadius: lineRad,
        inset: true,
      ),
    ];
  }
}
