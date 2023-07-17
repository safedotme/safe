import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_divider/mutable_divider.widget.dart';
import 'package:safe/widgets/mutable_input_popup_action/mutable_input_popup_action.widget.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';

class WidgetShowcasePopup extends StatefulWidget {
  const WidgetShowcasePopup({super.key});

  @override
  State<WidgetShowcasePopup> createState() => _WidgetShowcasePopupState();
}

class _WidgetShowcasePopupState extends State<WidgetShowcasePopup> {
  late Core core;
  double panelState = 0;

  @override
  void initState() {
    core = Provider.of<Core>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: panelState != 0,
          child: Opacity(
            opacity: panelState,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.alphaBlend(
                      kColorMap[MutableColor.primaryRed]!.withOpacity(0),
                      kColorMap[MutableColor.neutral10]!.withOpacity(0.8),
                    ),
                    Color.alphaBlend(
                      kColorMap[MutableColor.primaryRed]!.withOpacity(0.2),
                      kColorMap[MutableColor.neutral10]!.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        MutablePopup(
          type: PopupType.input,
          isExcited: true,
          style: MutablePopupStyle(
            backdropColor: Colors.transparent,
            backdropOpacity: 0,
          ),
          onClosed: () {
            core.utils.tutorial.handleOnLeave(core);
          },
          onSlide: (state) {
            setState(() {
              panelState = state;
            });
          },
          height: 390,
          controller: core.state.incident.widgetShowcasePopupController,
          body: Padding(
            padding: EdgeInsets.fromLTRB(
              kSideScreenMargin,
              27,
              kSideScreenMargin,
              0,
            ),
            child: Column(
              children: [
                MutableShimmer(
                  animateToColor:
                      kColorMap[MutableColor.primaryRed]!.withOpacity(0.3),
                  speed: Speed.slow,
                  child: Image.asset(
                    "assets/images/widget_showcase.png",
                    height: 134,
                  ),
                ),
                SizedBox(height: 12),
                MutableText(
                  core.utils.language.langMap[core.state.preferences.language]![
                      "incident_log"]["widget_showcase"]["header"],
                  size: 20,
                  weight: TypeWeight.heavy,
                ),
                SizedBox(height: 5),
                MutableText(
                  core.utils.language.langMap[core.state.preferences.language]![
                      "incident_log"]["widget_showcase"]["desc"],
                  size: 14,
                  align: TextAlign.center,
                  color: MutableColor.neutral2,
                ),
                SizedBox(height: 30),
                MutableDivider(color: MutableColor.excitedBorder),
                MutableInputPopupAction(
                  text: core.utils.language.langMap[core.state.preferences
                      .language]!["incident_log"]["widget_showcase"]["confirm"],
                  active: true,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    core.state.incident.widgetShowcasePopupController.close();
                  },
                ),
                MutableDivider(color: MutableColor.excitedBorder),
                MutableInputPopupAction(
                  text: core.utils.language.langMap[
                          core.state.preferences.language]!["incident_log"]
                      ["widget_showcase"]["learn_more"],
                  secondaryColor: MutableColor.excitedGrey,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    launchUrl(kWidgetInfo);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
