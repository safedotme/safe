// TYPOGRAPHY

import 'package:flutter/material.dart';

enum TypeStyle {
  h1,
  h2,
  h3,
  h4,
  h5,
  body,
  footnote,
}

enum TypeWeight {
  thin,
  regular,
  medium,
  semiBold,
  bold,
  heavy,
  black,
}

Map<TypeWeight, String> weightMap = {
  TypeWeight.thin: "Thin",
  TypeWeight.regular: "Regular",
  TypeWeight.medium: "Medium",
  TypeWeight.semiBold: "Semibold",
  TypeWeight.bold: "Bold",
  TypeWeight.heavy: "Heavy",
  TypeWeight.black: "Black"
};

String kFontFamilyGen({required TypeWeight weight}) {
  return "Rounded${weightMap[weight]}";
}

const Map<TypeStyle, int> kTypeStyleSize = {
  TypeStyle.h1: 30,
  TypeStyle.h2: 24,
  TypeStyle.h3: 20,
  TypeStyle.h4: 18,
  TypeStyle.h5: 16,
  TypeStyle.body: 14,
  TypeStyle.footnote: 12,
};

enum LetterSpacingType {
  numeric,
  regular,
  heading,
}

const Map<LetterSpacingType, double> kLetterSpacingMap = {
  LetterSpacingType.heading: 0.02, // 2%
  LetterSpacingType.regular: 0.01, // 1.%
  LetterSpacingType.numeric: 0.04, // 4%
};

const Map<TypeStyle, dynamic> kTypeStyleMap = {
  TypeStyle.h1: {
    "weight": TypeWeight.heavy,
    "spacing": LetterSpacingType.heading,
  },
  TypeStyle.h2: {
    "weight": TypeWeight.heavy,
    "spacing": LetterSpacingType.heading,
  },
  TypeStyle.h3: {
    "weight": TypeWeight.bold,
    "spacing": LetterSpacingType.heading,
  },
  TypeStyle.h4: {
    "weight": TypeWeight.medium,
    "spacing": LetterSpacingType.heading,
  },
  TypeStyle.h5: {
    "weight": TypeWeight.medium,
    "spacing": LetterSpacingType.heading,
  },
  TypeStyle.body: {
    "weight": TypeWeight.medium,
    "spacing": LetterSpacingType.regular,
  },
  TypeStyle.footnote: {
    "weight": TypeWeight.medium,
    "spacing": LetterSpacingType.regular,
  },
};

// TYPOGRAPHY SPECIFIC
final TextStyle kTextInputStyle = TextStyle(
  color: kColorMap[MutableColor.neutral1],
  fontFamily: kFontFamilyGen(weight: TypeWeight.medium),
  fontSize: 16,
);

// COLORS

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
  secondaryYellow,
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
  MutableColor.secondaryYellow: Color(0xffFCD95D),
};

final List<Color> kPrimaryGradientColors = [
  kColorMap[MutableColor.primaryYellow]!,
  kColorMap[MutableColor.primaryOrange]!,
  kColorMap[MutableColor.primaryRed]!,
  kColorMap[MutableColor.primaryMagenta]!,
  kColorMap[MutableColor.primaryPurple]!,
];

final Alignment kPrimaryGradientAlignmentBegin = Alignment(-0.1, -2.5);
final Alignment kPrimaryGradientAlignmentEnd = Alignment(0.1, 3);
final Color kIconColorInGradientFill =
    kColorMap[MutableColor.neutral1]!.withOpacity(0.75);

// OPACITY

enum Transparency {
  opaque,
  v80,
  v64,
  v56,
  v40,
  v24,
  v20,
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
  Transparency.v20: 0.2,
  Transparency.v16: 0.16,
  Transparency.v8: 0.08,
  Transparency.v4: 0.04,
};

// BORDER RADIUS
const double kPanelPopupBorderRadius = 35;
const double kInputPopupBorderRadius = 20;
const double kPreviewPopupBorderRadius = 18;

const double kCornerSmoothing = 0.6;

// POPUPS
const double kSideMarginPreviewPopup = 11;
const double kBottomMarginPreviewPopup = 34;
const double kTopMargin = 42;
const double kHandleTopMargin = 6;
const double kPanelHandleToHeader = 7;

// MARGINS
const double kSideScreenMargin = 15;
const double kBottomScreenMargin = 40;

// BORDERS
const double kBorderWidth = 1.5;

// LARGE BUTTON
const double kLargeButtonHeight = 50;
const double kLargeButtonBorderRadius = kLargeButtonHeight / 2;

// TEXT FIELDS
const double kObjectKeyboardMargin = 20;
const double kKeyboardHeight = 336;
const double kWidgetSpacing = 5;

// BANNER
const double kMutableBannerHeight = 115;
final Duration kMutableBannerDuration = Duration(milliseconds: 200);
