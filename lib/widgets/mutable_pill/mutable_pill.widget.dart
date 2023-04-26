import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class MutablePill extends StatefulWidget {
  final String text;
  final MutableIcons? icon;
  final bool isButton;
  final double shadowPronouncement;
  final MutableColor? color;
  final LetterSpacingType? letterSpacing;

  MutablePill({
    required this.text,
    this.icon,
    this.letterSpacing,
    this.shadowPronouncement = 22,
    this.isButton = false,
    this.color,
  });

  @override
  State<MutablePill> createState() => _MutablePillState();
}

class _MutablePillState extends State<MutablePill> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.isButton
          ? EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 5,
            )
          : EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 3,
            ),
      decoration: BoxDecoration(
        boxShadow: [
          ...core.utils.color.applyGradientShadow(
            widget.shadowPronouncement,
            isColorful: widget.color == null,
          ),
          ...[
            BoxShadow(
              color: widget.isButton
                  ? Colors.black.withOpacity(0.25)
                  : Colors.black.withOpacity(0.4),
              offset: Offset(0, 4),
              blurRadius: 4,
            )
          ]
        ],
        border: widget.color == null
            ? Border.all(
                width: 1,
                color: Colors.white.withOpacity(0.3),
              )
            : null,
        borderRadius: BorderRadius.circular(20),
        color: widget.color != null ? kColorMap[widget.color!] : null,
        image: widget.color == null
            ? DecorationImage(
                image: AssetImage("assets/images/gradient.png"),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          widget.icon == null
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: MutableIcon(
                    widget.icon!,
                    size: Size(15, 15),
                  ),
                ),
          MutableText(
            widget.text,
            style: widget.isButton ? TypeStyle.footnote : TypeStyle.body,
            weight: widget.isButton ? TypeWeight.heavy : TypeWeight.semiBold,
            letterSpacing: widget.letterSpacing,
          ),
        ],
      ),
    );
  }
}
