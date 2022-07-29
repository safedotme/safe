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
  final MutableIcons icon;

  MutablePill({required this.text, required this.icon});

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
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        boxShadow: core.utils.color.applyGradientShadow(22),
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: kPrimaryGradientColors,
          begin: Alignment(-1.5, -1.2),
          end: Alignment(1, 1),
        ),
      ),
      child: Row(
        children: [
          MutableIcon(
            widget.icon,
            size: Size(15, 15),
          ),
          SizedBox(width: 3),
          MutableText(
            widget.text,
            style: TypeStyle.body,
            weight: TypeWeight.semiBold,
          ),
        ],
      ),
    );
  }
}
