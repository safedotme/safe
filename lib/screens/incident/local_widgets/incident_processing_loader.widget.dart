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
  final Incident? incident;

  IncidentProcessingLoader(this.incident);
  @override
  State<IncidentProcessingLoader> createState() =>
      _IncidentProcessingLoaderState();
}

class _IncidentProcessingLoaderState extends State<IncidentProcessingLoader>
    with TickerProviderStateMixin {
  late Core core;
  late Timer timer;
  AnimationController? controller;

  double val = 0;
  bool hasNotified = false;
  int minInSec = 600;
  int maxInSec = 900;
  Color color = Colors.white;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    if (widget.incident == null) return;
    genExpectedTime(widget.incident!);
    initTimer(widget.incident!);
  }

  void animate() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1250),
    );

    Animation animation = ColorTween(
      begin: Colors.white,
      end: Color(0xff00D87D),
    ).animate(
      CurvedAnimation(
        parent: controller!,
        curve: Curves.easeIn,
      ),
    );

    controller!.addListener(() {
      setState(() {
        color = animation.value;
      });
    });

    controller!.forward();
  }

  void initTimer(Incident incident) {
    if (incident.stopTime == null) {
      return;
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int secondDifference =
          DateTime.now().difference(incident.stopTime!).inSeconds;

      if (secondDifference >= maxInSec) {
        animate();
        timer.cancel();
      }

      setState(() {
        val = secondDifference / maxInSec;
      });
    });
  }

  void genExpectedTime(Incident incident) {
    if (incident.stopTime == null) {
      return;
    }

    Duration duration = incident.stopTime!.difference(
      incident.datetime,
    );

    if (duration.compareTo(Duration(minutes: 3)).isNegative) {
      minInSec = 120;
      maxInSec = 180;
      return;
    }

    minInSec = (duration.inSeconds * 0.3).round();
    maxInSec = (duration.inSeconds * 0.5).round();
  }

  String genBody(String base) {
    if (hasNotified) {
      return base.replaceAll("{PHONE}", "");
    }

    return base
        .replaceAll("{MIN}", (minInSec / 60).round().toString())
        .replaceAll("{MAX}", (maxInSec / 60).round().toString());
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }

    if (controller != null) {
      controller!.stop();
      controller!.dispose();
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
              animationDuration: Duration(seconds: (val * 3).round()),
              color: color,
              backgroundColor: kColorMap[MutableColor.neutral5],
            ),
          ),
          SizedBox(height: 25),
          MutableText(
            core.utils.language
                    .langMap[core.state.preferences.language]!["incident"]
                ["processing_loader"]["header"],
            weight: TypeWeight.heavy,
            size: 22,
          ),
          SizedBox(height: 16),
          MutableButton(
            onTap: () async {
              HapticFeedback.lightImpact();
              // TODO: Logsnag

              setState(() {
                hasNotified = true;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: MutableText(
                genBody(core.utils.language
                        .langMap[core.state.preferences.language]!["incident"]
                    ["processing_loader"]["description"][hasNotified]),
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
