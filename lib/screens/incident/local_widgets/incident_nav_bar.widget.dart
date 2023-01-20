import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_overlay_button/mutable_overlay_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentNavBar extends StatefulWidget {
  final Incident incident;

  IncidentNavBar(this.incident);
  @override
  State<IncidentNavBar> createState() => _IncidentNavBarState();
}

class _IncidentNavBarState extends State<IncidentNavBar> {
  late Core core;
  double backdropOpacity = 0;
  double textOpacity = 0;
  double borderOpacity = 0;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    core.state.incident.scrollController.addListener(() {
      animate(core.state.incident.scrollController.offset);
    });
  }

  void animate(double offset) {
    // Animate Backdrop (Animate from 100 -> 200)
    double backdroPerc = core.utils.animation.percentBetweenPoints(
      lowerBound: 250,
      upperBound: 300,
      state: offset,
    );

    double textPerc = core.utils.animation.percentBetweenPoints(
      lowerBound: 275,
      upperBound: 325,
      state: offset,
    );

    double borderPerc = core.utils.animation.percentBetweenPoints(
      lowerBound: 275,
      upperBound: 300,
      state: offset,
    );

    if (mounted) {
      setState(() {
        backdropOpacity = backdroPerc;
        borderOpacity = borderPerc;
        textOpacity = textPerc;
      });
    }
  }

  String genAddress(Incident? i) {
    String base = "";

    if (i == null) return base;
    if (i.location == null) return base;
    if (i.location!.isEmpty) return base;
    if (i.location![0].address == null) return base;

    String address =
        core.utils.geocoder.removeTag(i.location![0].address!) ?? "";

    base = address.substring(0, address.indexOf(","));

    return base;
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: kNavBarBlur * backdropOpacity,
          sigmaY: kNavBarBlur * backdropOpacity,
        ),
        child: GestureDetector(
          onTap: () {
            core.state.incident.scrollController.animateTo(
              0,
              duration: kScrollAnimationDuration,
              curve: kScrollAnimationCurve,
            );
          },
          child: Container(
            padding: EdgeInsets.fromLTRB(
              kSideScreenMargin,
              0,
              kSideScreenMargin,
              12,
            ),
            height: 65 + queryData.padding.top,
            width: queryData.size.width + 1,
            decoration: BoxDecoration(
              color: kColorMap[MutableColor.neutral10]!
                  .withOpacity(0.85 * backdropOpacity),
              border: Border(
                bottom: BorderSide(
                  width: kBorderWidth,
                  color: kColorMap[MutableColor.neutral7]!
                      .withOpacity(1 * borderOpacity),
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: kOverlayButtonSize,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MutableOverlayButton(
                      animateBeforeVoidCallback: true,
                      icon: MutableIcon(
                        MutableIcons.cancel,
                        size: Size(12, 12),
                      ),
                      onTap: () {
                        core.state.incident.controller.close();
                      },
                    ),
                    Opacity(
                      opacity: 1 * textOpacity,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Column(
                          children: [
                            MutableText(
                              widget.incident.name,
                              weight: TypeWeight.bold,
                            ),
                            SizedBox(height: 4),
                            MutableText(
                              genAddress(widget.incident),
                              maxLines: 1,
                              size: 14,
                              color: MutableColor.neutral2,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: kOverlayButtonSize),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
