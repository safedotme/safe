import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

class MutablePill extends StatefulWidget {
  final String text;
  final MutableIcons? icon;
  final bool isButton;
  final double shadowPronouncement;
  final MutableColor? color;

  MutablePill({
    required this.text,
    this.icon,
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
        borderRadius: BorderRadius.circular(20),
        color: widget.color != null ? kColorMap[widget.color!] : null,
        gradient: widget.color != null
            ? null
            : LinearGradient(
                colors: kPrimaryGradientColors,
                begin: Alignment(-1.5, -1.2),
                end: Alignment(1, 3.5),
              ),
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
          ),
        ],
      ),
    );
  }
}
