import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_emoji_box/mutable_emoji_box.widget.dart';
import 'package:safe/widgets/mutable_home_message.widget.dart/mutable_home_banner.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TutorialBanner extends StatefulWidget {
  @override
  State<TutorialBanner> createState() => _TutorialBannerState();
}

class _TutorialBannerState extends State<TutorialBanner> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MutableHomeBanner(
        state: PanelState.CLOSED,
        controller: core.state.preferences.tutorialBannerController,
        header: core.utils.language
                .langMap[core.state.preferences.language]!["home"]
            ["acc_created"]["header"],
        height: 125,
        onTap: () {
          core.utils.tutorial.handleCaptureTutorial(core);
        },
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MutableEmojiBox(
                  color: kColorMap[MutableColor.secondaryYellow]!
                      .withOpacity(0.10),
                  emoji: "party",
                ),
                SizedBox(width: kHomeBannerHorizontalSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MutableText(
                        core.utils.language.langMap[core.state.preferences
                            .language]!["home"]["acc_created"]["subheader"],
                        size: 15,
                        weight: TypeWeight.bold,
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          MutableText(
                            core.utils.language.langMap[core.state.preferences
                                .language]!["home"]["acc_created"]["desc"][0],
                            size: 13,
                            color: MutableColor.neutral2,
                          ),
                          MutableText(
                            core.utils.language.langMap[core.state.preferences
                                .language]!["home"]["acc_created"]["desc"][1],
                            size: 13,
                            color: MutableColor.neutral1,
                            decoration: TextDecoration.underline,
                            weight: TypeWeight.bold,
                          ),
                          MutableText(
                            core.utils.language.langMap[core.state.preferences
                                .language]!["home"]["acc_created"]["desc"][2],
                            size: 13,
                            color: MutableColor.neutral2,
                          ),
                        ],
                      ),
                      MutableText(
                        core.utils.language.langMap[core.state.preferences
                            .language]!["home"]["acc_created"]["desc"][3],
                        size: 13,
                        color: MutableColor.neutral2,
                      ),
                    ],
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
