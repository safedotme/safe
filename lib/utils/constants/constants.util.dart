// COLORS
import 'package:flutter/material.dart';

enum MutableColor {
  neutral1,
  neutral2,
  neutral3,
  neutral4,
  neutral5,
  neutral6,
  neutral7,
  neutral8,
  neutral9,
  neutral10,
  primaryYellow,
  primaryRed,
  primaryOrange,
  primaryPurple,
  primaryMagenta,
  secondaryGreen,
  secondaryRed,
}

const Map<MutableColor, Color> kColorMap = {
  // NEUTRAL
  MutableColor.neutral1: Colors.white,
  MutableColor.neutral2: Color(0xffB4B5B9),
  MutableColor.neutral3: Color(0xff656565),
  MutableColor.neutral4: Color(0xff484848),
  MutableColor.neutral5: Color(0xff242424),
  MutableColor.neutral6: Color(0xff222222),
  MutableColor.neutral7: Color(0xff1B191B),
  MutableColor.neutral8: Color(0xff151317),
  MutableColor.neutral9: Color(0xff0F0D10),
  MutableColor.neutral10: Color(0xff070508),

  //PRIMARY
  MutableColor.primaryYellow: Color(0xffF8D849),
  MutableColor.primaryOrange: Color(0xffEE8131),
  MutableColor.primaryRed: Color(0xffEA336C),
  MutableColor.primaryMagenta: Color(0xffC127BF),
  MutableColor.primaryPurple: Color(0xff6E3CF1),

  // SECONDARY
  MutableColor.secondaryGreen: Color(0xff50C166),
  MutableColor.secondaryRed: Color(0xffFC645D),
};

// OPACITY

enum Transparency {
  opaque,
  v80,
  v64,
  v56,
  v40,
  v24,
  v16,
  v8,
  v4,
}

const Map<Transparency, double> kTransparencyMap = {
  Transparency.opaque: 1,
  Transparency.v80: 0.8,
  Transparency.v64: 0.64,
  Transparency.v56: 0.56,
  Transparency.v40: 0.4,
  Transparency.v24: 0.24,
  Transparency.v16: 0.16,
  Transparency.v8: 0.08,
  Transparency.v4: 0.04,
};

// BORDER RADIUS

const double kPanelPopupBorderRadius = 35;
const double kInputPopupBorderRadius = 20;
const double kPreviewPopupBorderRadius = 18;
