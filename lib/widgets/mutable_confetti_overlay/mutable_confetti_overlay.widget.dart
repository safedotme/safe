import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'dart:math' as math;

import 'package:safe/utils/constants/constants.util.dart';

class MutableConfettiOverlay extends StatefulWidget {
  @override
  State<MutableConfettiOverlay> createState() => _MutableConfettiOverlayState();
}

class _MutableConfettiOverlayState extends State<MutableConfettiOverlay> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final queryData = MediaQuery.of(context);
    return Positioned(
      left: queryData.size.width / 2,
      top: -50,
      child: ConfettiWidget(
        canvas: Size(375, 812),
        blastDirectionality: BlastDirectionality.explosive,
        blastDirection: math.pi * 0.5,
        emissionFrequency: 0.15,
        numberOfParticles: 10,
        confettiController: core.state.preferences.confettiController,
        colors: kPrimaryGradientColors.sublist(
          1,
          kPrimaryGradientColors.length - 1,
        ),
      ),
    );
  }
}
