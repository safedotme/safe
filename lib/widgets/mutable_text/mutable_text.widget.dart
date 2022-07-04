import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';

/// A customizable text widget with design style implementation
class MutableText extends StatefulWidget {
  final String data;
  final bool selectable;
  final TypeStyle style;
  final LetterSpacingType? letterSpacing;
  final double? size;
  final MutableColor? color;
  final TypeWeight? weight;
  final TextAlign align;
  final TextDecoration? decoration;

  /// [overflow] property doesn't apply if [selectable] is set to true
  final TextOverflow? overflow;

  MutableText(
    this.data, {
    this.style = TypeStyle.h5,
    this.decoration,
    this.overflow,
    this.letterSpacing,
    this.selectable = false,
    this.align = TextAlign.left,
    this.color = MutableColor.neutral1,
    this.size,
    this.weight,
  });

  @override
  State<MutableText> createState() => _MutableTextState();
}

class _MutableTextState extends State<MutableText> {
  late TextStyle style;

  @override
  Widget build(BuildContext context) {
    style = TextStyle(
      fontSize: widget.size ?? kTypeStyleSize[widget.style]!.toDouble(),
      color: kColorMap[widget.color],
      fontFamily: kFontFamilyGen(
        weight: widget.weight ?? kTypeStyleMap[widget.style]["weight"],
      ),
      decoration: widget.decoration,
      fontWeight: FontWeight.normal,
      letterSpacing: (widget.size ?? kTypeStyleSize[widget.style]!.toDouble()) *
          (kLetterSpacingMap[widget.letterSpacing ??
                  kTypeStyleMap[widget.style]["spacing"]]!
              .toDouble()),
    );

    return widget.selectable
        ? SelectableText(
            widget.data,
            textAlign: widget.align,
            style: style,
          )
        : Text(
            widget.data,
            textAlign: widget.align,
            style: style,
            overflow: widget.overflow,
          );
  }
}
