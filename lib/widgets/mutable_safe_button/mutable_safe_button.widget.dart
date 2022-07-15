import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MutableSafeButton extends StatefulWidget {
  @override
  State<MutableSafeButton> createState() => _MutableSafeButtonState();
}

class _MutableSafeButtonState extends State<MutableSafeButton> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kSafeButtonSize,
      width: kSafeButtonSize,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: kPrimaryGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          // COLORS DROP SHADOWS
          BoxShadow(
            offset: Offset(4, 4),
            blurRadius: 30,
            color: kColorMap[MutableColor.primaryPurple]!.withOpacity(0.1),
          ),
          BoxShadow(
            offset: Offset(4, -4),
            blurRadius: 30,
            color: kColorMap[MutableColor.primaryRed]!.withOpacity(0.1),
          ),
          BoxShadow(
            offset: Offset(-4, -4),
            blurRadius: 30,
            color: kColorMap[MutableColor.primaryYellow]!.withOpacity(0.1),
          ),

          // NEUTRAL INNER SHADOWS
          BoxShadow(
            offset: Offset(4, -4),
            blurRadius: 20,
            color: Colors.black.withOpacity(0.6),
            inset: true,
          ),
          BoxShadow(
            offset: Offset(-3, 3),
            blurRadius: 30,
            spreadRadius: 1,
            color: Colors.white.withOpacity(0.4),
            inset: true,
          ),
          BoxShadow(
            offset: Offset(-2, 2),
            blurRadius: 1,
            spreadRadius: 0,
            color: Colors.white.withOpacity(0.6),
            inset: true,
          ),
        ],
      ),
    );
  }
}
