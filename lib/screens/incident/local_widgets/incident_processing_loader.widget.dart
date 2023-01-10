import 'dart:async';

import 'package:curved_progress_bar/curved_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_overlay_button/mutable_overlay_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentProcessingLoader extends StatefulWidget {
  final Incident incident;

  IncidentProcessingLoader(this.incident);
  @override
  State<IncidentProcessingLoader> createState() =>
      _IncidentProcessingLoaderState();
}

class _IncidentProcessingLoaderState extends State<IncidentProcessingLoader> {
  late Core core;
  late Timer timer;
  double val = 0;
  double duration = 1;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
    initTimer();
  }

  void initTimer() {
    if (widget.incident.stopTime == null) {
      return;
    }

    duration =
        (DateTime.now().difference(widget.incident.stopTime!).inSeconds / 600);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int secondDifference =
          DateTime.now().difference(widget.incident.stopTime!).inSeconds;
      int waitTime = 600;

      if (secondDifference > waitTime) {
        timer.cancel();
      }

      setState(() {
        val = secondDifference / waitTime;
      });
    });
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        kSideScreenMargin,
        queryData.padding.top + 10,
        kSideScreenMargin,
        kBottomScreenMargin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: MutableOverlayButton(
              icon: MutableIcon(
                MutableIcons.cancel,
                size: Size(12, 12),
                color: kColorMap[MutableColor.neutral2]!,
              ),
              isDarkened: true,
              onTap: () {
                HapticFeedback.lightImpact();
                core.state.incident.controller.close();
              },
            ),
          ),
          SizedBox(height: queryData.size.height * 0.12),
          SizedBox(
            height: 54,
            width: 54,
            child: CurvedCircularProgressIndicator(
              value: val < 0.05 ? 0.05 : val,
              strokeWidth: 8,
              animationDuration: Duration(seconds: (3 * duration).round()),
              color: kColorMap[MutableColor.neutral1],
              backgroundColor: kColorMap[MutableColor.neutral5],
            ),
          ),
          SizedBox(height: 25),
          MutableText(
            "Processing Incident", // TODO: Extract
            weight: TypeWeight.heavy,
            size: 22,
          ),
          SizedBox(height: 16),
          MutableButton(
            onTap: () {
              HapticFeedback.lightImpact();
              // TODO: Logsnag
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: MutableText(
                "This usually takes between 10 to 15 minutes.\nBeen a while? Let us know by tapping here and we'll get back to you with an update through SMS.",
                color: MutableColor.neutral2,
                weight: TypeWeight.medium,
                size: 14,
                align: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
