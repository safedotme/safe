import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

/// A customizable text widget with design style implementation
class MutableText extends StatefulWidget {
  final String data;
  final bool selectable;
  final TypeStyle? style;
  final LetterSpacingType? letterSpacing;
  final double? size;
  final MutableColor? color;
  final TypeWeight? weight;
  final TextAlign align;
  final double? height;
  final int? maxLines;
  final TextDecoration? decoration;

  /// [overflow] property doesn't apply if [selectable] is set to true
  final TextOverflow? overflow;

  MutableText(
    this.data, {
    this.style,
    this.decoration,
    this.overflow,
    this.letterSpacing,
    this.maxLines,
    this.selectable = false,
    this.align = TextAlign.left,
    this.color,
    this.size,
    this.height,
    this.weight,
  });

  static TextStyle generateTextStyle({
    double? height,
    double? size,
    TypeStyle? style,
    MutableColor? color,
    TypeWeight? weight,
    TextDecoration? decoration,
    LetterSpacingType? letterSpacing,
  }) {
    style ??= TypeStyle.h5;
    return TextStyle(
      height: height,
      fontSize: size ?? kTypeStyleSize[style]!.toDouble(),
      color: kColorMap[color ?? MutableColor.neutral1],
      fontFamily: kFontFamilyGen(
        weight: weight ?? kTypeStyleMap[style]["weight"],
      ),
      decoration: decoration,
      fontWeight: FontWeight.normal,
      letterSpacing: (size ?? kTypeStyleSize[style]!.toDouble()) *
          (kLetterSpacingMap[letterSpacing ?? kTypeStyleMap[style]["spacing"]]!
              .toDouble()),
    );
  }

  @override
  State<MutableText> createState() => _MutableTextState();
}

class _MutableTextState extends State<MutableText> {
  late TextStyle style;

  @override
  Widget build(BuildContext context) {
    style = MutableText.generateTextStyle(
      height: widget.height,
      size: widget.size,
      style: widget.style,
      color: widget.color,
      weight: widget.weight,
      decoration: widget.decoration,
      letterSpacing: widget.letterSpacing,
    );

    return widget.selectable
        ? SelectableText(
            widget.data,
            textAlign: widget.align,
            style: style,
            maxLines: widget.maxLines,
          )
        : Text(
            widget.data,
            textAlign: widget.align,
            style: style,
            overflow: widget.overflow,
            maxLines: widget.maxLines,
          );
  }
}
