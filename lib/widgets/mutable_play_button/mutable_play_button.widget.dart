import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';

class MutablePlayButton extends StatefulWidget {
  final Function()? onTap;

  MutablePlayButton({this.onTap});

  @override
  State<MutablePlayButton> createState() => _MutablePlayButtonState();
}

class _MutablePlayButtonState extends State<MutablePlayButton> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: widget.onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: core.utils.color.applyGradientShadow(30, opacity: 0.8),
          gradient: LinearGradient(
            colors: kPrimaryGradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Image.asset(
            "assets/images/play.png",
            height: 22,
            width: 18,
          ),
        ),
      ),
    );
  }
}
