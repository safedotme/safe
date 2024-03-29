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

// -> TYPOGRAPHY SPECIFIC
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
  secondaryBlue,
  overlaySecondaryGreen,
  overlaySecondaryRed,
  overlaySecondaryYellow,

  excitedPrimary,
  excitedBackground,
  excitedBorder,
  excitedGrey,

  iosGrey,
  iosDarkGrey,
  mapBackground,
}

const Map<MutableColor, Color> kColorMap = {
  // -> NEUTRAL
  MutableColor.neutral1: Colors.white,
  MutableColor.neutral2: Color(0xffC7C7C7),
  MutableColor.neutral3: Color(0xff656565),
  MutableColor.neutral4: Color(0xff484848),
  MutableColor.neutral5: Color(0xff242424),
  MutableColor.neutral6: Color(0xff222222),
  MutableColor.neutral7: Color(0xff1B191B),
  MutableColor.neutral8: Color(0xff151317),
  MutableColor.neutral9: Color(0xff0F0D10),
  MutableColor.neutral10: Color(0xff070508),

  // -> OS SPECIFIC
  MutableColor.iosGrey: Color(0xff1E1920),
  MutableColor.iosDarkGrey: Color(0xff252525),

  // -> EXCITED STATE COLORS
  MutableColor.excitedPrimary: Color(0XFFE53872),
  MutableColor.excitedBackground: Color(0xff0C0A0A),
  MutableColor.excitedBorder: Color(0xff27141C),
  MutableColor.excitedGrey: Color(0xff7A6066),

  // -> MAP SPECIFIC
  MutableColor.mapBackground: Color(0xff1e1e1e),

  // -> PRIMARY
  MutableColor.primaryYellow: Color(0xffF8D849),
  MutableColor.primaryOrange: Color(0xffEE8131),
  MutableColor.primaryRed: Color(0xffEA336C),
  MutableColor.primaryMagenta: Color(0xffC127BF),
  MutableColor.primaryPurple: Color(0xff6E3CF1),

  // -> SECONDARY
  MutableColor.secondaryGreen: Color(0xff50C166),
  MutableColor.secondaryBlue: Color(0xff3275F6),
  MutableColor.secondaryRed: Color(0xffFC645D),
  MutableColor.secondaryYellow: Color(0xffFCD95D),
  MutableColor.overlaySecondaryGreen: Color(0xff0E1811),
  MutableColor.overlaySecondaryRed: Color(0xff200F11),
  MutableColor.overlaySecondaryYellow: Color(0xff201A11),
};

final List<Color> kPrimaryGradientColors = [
  kColorMap[MutableColor.primaryYellow]!,
  kColorMap[MutableColor.primaryOrange]!,
  kColorMap[MutableColor.primaryRed]!,
  kColorMap[MutableColor.primaryMagenta]!,
  kColorMap[MutableColor.primaryPurple]!,
];

final List<Color> kDisabledGradientColors = [
  Color(0xff1B191B),
  Color(0xff090809),
];

final Alignment kPrimaryGradientAlignmentBegin = Alignment(-2, -2);
final Alignment kPrimaryGradientAlignmentEnd = Alignment(2, 2);
final Color kIconColorInGradientFill =
    kColorMap[MutableColor.neutral1]!.withOpacity(0.75);
final Color kShimmerAnimationColor = Colors.white.withOpacity(0.3);

// -> OPACITY

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

final double kBackgroundOpacity = kTransparencyMap[Transparency.v80]!;
const double kGradientShimmerOpacity = 0.6;

// BORDER RADIUS
const double kPanelPopupBorderRadius = 35;
const double kInputPopupBorderRadius = 20;
const double kPreviewPopupBorderRadius = 18;

const double kCornerSmoothing = 0.6;

// POPUPS
const double kSideMarginPreviewPopup = 11;
const double kBottomMarginPreviewPopup = 34;
const double kDefaultTopMargin = 42;
const double kHandleTopMargin = 6;
const double kPanelHandleToHeader = 7;
const double kInputPopupWidth = 265;
const double kTopInputPopupMargin = 26;
const double kBottomInputPopupMargin = 18;
const double kDefaultInputPopupHeight = 243;
const MutableColor kInputPopupColor = MutableColor.neutral9;
const String kDefaultCountryCode = "+1";

// CONTACT
const double kContactTimelineWidth = 8;
const double kContactBottomMargin = 56;
const double kContactTopMargin = 8;

// NAVBAR
const double kNavBarBlur = 15;
const double kOverlayButtonSize = 40;
const double kIncidentNavBarOffset = 150;

// SCROLL
const Duration kScrollAnimationDuration = Duration(milliseconds: 200);
const Curve kScrollAnimationCurve = Curves.decelerate;

// MARGINS
const double kSideScreenMargin = 15;
const double kBottomScreenMargin = 40;
const double kHomeBannerHorizontalSpacing = 15;

// BORDERS
const double kBorderWidth = 1.5;

// LARGE BUTTON
const double kLargeButtonHeight = 50;
const double kLargeButtonBorderRadius = kLargeButtonHeight / 2;

// EXCITED STATE VALUES
const double kExcitedBorderWidth = 2.5;

// BUTTONS
const double kScaleDownButtonPercentage = 0.97;
const Duration kScaleDownButtonTime = Duration(milliseconds: 125);

// CONTEXT MENU
const double kContextMenuWidth = 254;
const double kContextMenuBorderRadius = 12;

// NAVIGATION BUTTON
const double kNavButtonSize = 40;

// TEXT FIELDS
const double kObjectKeyboardMargin = 20;
const double kKeyboardHeight = 336;
const double kWidgetSpacing = 5;
const Brightness kKeyboardAppearance = Brightness.dark;

// BANNER
const double kMutableBannerHeight = 115;
final Duration kMutableBannerDuration = Duration(milliseconds: 200);

// COUNTRY CODE SELECTOR
const double kCountryCodeSelectorHeight = 380;
const double kCountryCodeHeaderToBody = 16;
const double kCountryNameCodeSpacing = 4;

// OTP INPUT POPUP
const double kOTPInputPopupHeight = 300;

// PANEL POPUP
const TypeStyle kPanelPopupHeaderStyle = TypeStyle.h4;
const TypeWeight kPanelPopupHeaderWeight = TypeWeight.heavy;
const TypeStyle kPanelPopupSubheaderStyle = TypeStyle.h5;
const TypeWeight kPanelPopupSubheaderWeight = TypeWeight.medium;
const MutableColor kPanelPopupSubheaderColor = MutableColor.neutral2;

// AUTH
const Duration kSMSTimeout = Duration(seconds: 30);
const int kSMSRetryAttempts = 5;
const int kUserServerLoadRetries = 5;

enum AuthType {
  signup,
  login,
}

// INCIDENT SCREEN
const double kIncidentDataBoxPadding = 15;
const double kIncidentSubheaderToBody = 20;
const double kRecordedDataBoxSpacing = 14;

// HOME

// -> Home Banner
const double kHomeBannerIncidentPopupMargin = 20;
const double kHomeBannerBorderRadius = 12;

// -> SAFE BUTTON
const double kSafeButtonSize = 165;
const double kSafeButtonShadowOpacityScale = 0.1;
const double kSafeButtonShadowBlurScale = 20;
const double kSafeButtonTapScale = 0.04;
const Duration kSafeButtonPulsateDuration = Duration(milliseconds: 1300);
const double kSafeButtonPuslateScale = 1.05;
const Duration kFadeInDuration = Duration(seconds: 3);
const Curve kFadeInCurve = Curves.easeOutSine;

// -> LAYOUT
const double kIncidentLogMinPopupHeight = 0.18;
const double kHomeHeaderToButtonMargin = 60;
const double kMainPopupBorderRadius = 12;
const double kIncidentLogActiveTopPading = 44;
const double kNavigationTabCutoff = 0.6;
const ScrollPhysics? kIncidentLogScrollPhysics = null;
const double kIncidentLogNavButtonCutoff = 0.7;

// INCIDENT CARD
const MutableColor kIncidentCardBgColor = MutableColor.neutral9;
const double kIncidentCardBorderRadius = 6;
const double kIncidentBodyVerticalSpacing = 5;
const MutableColor kIncidentCardLoaderColor = MutableColor.neutral8;
const MutableColor kIncidentCardBorderColor = MutableColor.neutral7;
const double kIncidentCardImageHeight = 165;
const double kIncidentCardBodyPadding = 10;
const int kCachedImageLoadDuration = 300;
const double kIncidentLogCardSpacing = 25;
// EMERGENCY CONTACTS

// -> AVATAR
const double kEmergencyContactAvatarSize = 24;
const double kEmergencyContactAvatarSpacing = 3;
const double kEmergencyContactAvatarPopupSize = 65;

// CONFETTI
const Duration kConfettiDuration = Duration(seconds: 3);

// MAP
const EdgeInsets kMapPadding = EdgeInsets.only(bottom: 100, left: 15);

// TRANSITIONS
const double kScreenTransitionBounds = 400;
const Duration kScreenTransitionDuration = Duration(milliseconds: 200);
const Curve kTransitionCurve = Curves.decelerate;

// CAPTURE
const Color kCaptureTextShimmerDarkColor = Color(0xff3D3B3D);
const Color kCaptureTextShimmerLightColor = Color(0xffBFBFBF);
const double kCaptureControlBorderRadius = 8;
const double kCameraPreviewWidthPercentage = 0.3;
const double kControlBoxBodyHeight = 150;
const double kCaptureCameraButtonMargin = 15;
const double kCaptureLiveBadgeMargin = 8;

// -> LOCATION TIMEOUT
const Duration kCaptureStreamTimeout = Duration(seconds: 20);
const Duration kLocationStreamTimeout = Duration(seconds: 5);

// SHIMMER
final Color kBoxLoaderShimmerColor = kShimmerAnimationColor.withOpacity(0.05);

// PLAY SCREEN
final Duration kRotationDuration = Duration(milliseconds: 1000);
const double kLinearProgressIndicatorWidth = 5;
const double kMapPaddingCompensation = 0.005;
const double kMapZoom = 16;

// SETTINGS
const double kSettingsComponentSpacing = 45;
