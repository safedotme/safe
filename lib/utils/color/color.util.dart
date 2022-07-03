import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

class ColorUtils {
  Color translucify(MutableColor color, Transparency tspcy) =>
      kColorMap[color]!.withOpacity(
        kTransparencyMap[tspcy]!,
      );
}
