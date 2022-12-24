import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/capture/capture.util.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/credit/credit.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_avatar/mutable_avatar.widget.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_nav_safe_button/mutable_nav_safe_button.widget.dart';

class IncidentLogNavBar extends StatefulWidget {
  @override
  State<IncidentLogNavBar> createState() => _IncidentLogNavBarState();
}

class _IncidentLogNavBarState extends State<IncidentLogNavBar> {
  late Core core;

  double kNavBarButtonHeight = 40;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  double genTopPadding(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0.8,
      upperBound: 1,
      state: state,
    );

    return 10 + (animation * kIncidentLogActiveTopPading);
  }

  double genButtonScale(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0,
      upperBound: kIncidentLogNavButtonCutoff,
      state: state,
    );

    return animation;
  }

  double genButtonOpacity(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: kIncidentLogNavButtonCutoff,
      upperBound: 1,
      state: state,
    );

    return animation;
  }

  double genHandleBarOpacity(double state) {
    double percentage = core.utils.animation.percentBetweenPoints(
      lowerBound: 65,
      upperBound: 160,
      state: state,
    );

    return (percentage - 1) * -1;
  }

  double genBorderOpacity(double state) {
    double max = 0.85;

    double percentage = core.utils.animation.percentBetweenPoints(
      lowerBound: 0,
      upperBound: 20,
      state: state,
    );

    return percentage;
  }

  double genNavBarColorOpacity(double state) {
    double percentage = core.utils.animation.percentBetweenPoints(
      lowerBound: kIncidentLogNavButtonCutoff,
      upperBound: 1,
      state: state,
    );

    return percentage * 0.85;
  }

  double genBlur(double state) {
    double percentage = core.utils.animation.percentBetweenPoints(
      lowerBound: kIncidentLogNavButtonCutoff,
      upperBound: 1,
      state: state,
    );

    return percentage * 15;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Observer(
        builder: (_) => BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: genBlur(core.state.incidentLog.offset),
            sigmaY: genBlur(core.state.incidentLog.offset),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              kSideScreenMargin,
              genTopPadding(core.state.incidentLog.offset),
              kSideScreenMargin,
              core.state.incidentLog.offset > kIncidentLogNavButtonCutoff
                  ? 10
                  : 0, // Problem here
            ),
            decoration: BoxDecoration(
              color: kColorMap[MutableColor.neutral10]!.withOpacity(
                genNavBarColorOpacity(core.state.incidentLog.offset),
              ),
              border: Border(
                bottom: BorderSide(
                  width: kBorderWidth,
                  color: kColorMap[MutableColor.neutral7]!.withOpacity(
                    genBorderOpacity(core.state.incidentLog.scrollOffset),
                  ),
                ),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Opacity(
                  opacity: genHandleBarOpacity(
                    core.state.incidentLog.scrollOffset,
                  ),
                  child: MutableHandle(),
                ),
                SizedBox(height: 5),
                Visibility(
                  visible: core.state.incidentLog.offset >
                      kIncidentLogNavButtonCutoff,
                  child: Opacity(
                    opacity: genButtonOpacity(core.state.incidentLog.offset),
                    child: Transform.scale(
                      scale: genButtonScale(core.state.incidentLog.offset),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          MutableButton(
                            onTap: () {
                              print("navigate to settings");
                            },
                            child: MutableIcon(
                              MutableIcons.gear,
                              size: Size(24, 24),
                              color: kColorMap[MutableColor.neutral2]!,
                            ),
                          ),
                          Spacer(),
                          Observer(
                            builder: (_) => MutableAvatar(
                              core.state.incidentLog.user,
                              onTap: () {
                                print("Open profile");
                              },
                            ),
                          ),
                          SizedBox(width: 15),
                          MutableNavSafeButton(
                            onTap: () async {
                              HapticFeedback.lightImpact();

                              // Checks if incident should be captured
                              bool shouldCapture =
                                  await core.utils.credit.shouldCapture(
                                TriggerIdentifier.primary,
                                core,
                              );

                              if (!shouldCapture) {
                                core.state.incidentLog.controller.close();

                                // Flashes Incident Limit Banner
                                if (core.state.capture.shouldFlashLimitBanner ==
                                    false) {
                                  core.state.capture.setFlashLimitBanner(true);
                                  await Future.delayed(Duration(seconds: 8));
                                  core.state.capture.setFlashLimitBanner(false);
                                }

                                // Add Haptic Feedback
                                return;
                              }

                              core.utils.capture.start();
                              await core.state.capture.controller.open();
                              core.state.incidentLog.controller.close();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
