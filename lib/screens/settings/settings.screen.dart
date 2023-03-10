import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/screens/settings/local_widgets/about_context_menu.widget.dart';
import 'package:safe/screens/settings/local_widgets/danger_zone_block.widget.dart';
import 'package:safe/screens/settings/local_widgets/our_story_banner.widget.dart';
import 'package:safe/screens/settings/local_widgets/reach_out_block.widget.dart';
import 'package:safe/screens/settings/local_widgets/settings_nav_bar.widget.dart';
import 'package:safe/screens/settings/local_widgets/support_block.widget.dart';
import 'package:safe/screens/settings/local_widgets/user_preferences_block.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_loader/mutable_loader.widget.dart';
import 'package:safe/widgets/mutable_overlay/mutable_overlay.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    core.state.preferences.scrollController.addListener(() {
      if (core.state.preferences.aboutContextMenuController.isOpen) {
        core.state.preferences.aboutContextMenuController.close();
      }
    });
  }

  @override
  void dispose() {
    if (core.state.preferences.scrollController.hasClients) {
      core.state.preferences.scrollController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      controller: core.state.preferences.controller,
      isDismissable: false,
      body: Container(
        color: kColorMap[MutableColor.neutral10],
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: core.state.preferences.scrollController,
              padding: EdgeInsets.fromLTRB(
                kSideScreenMargin,
                108,
                kSideScreenMargin,
                72,
              ),
              child: Column(
                children: [
                  OurStoryBanner(),
                  SizedBox(height: kSettingsComponentSpacing),
                  UserPreferencesBlock(),
                  SizedBox(height: kSettingsComponentSpacing),
                  ReachOutBlock(),
                  SizedBox(height: kSettingsComponentSpacing),
                  SupportBlock(),
                  SizedBox(height: kSettingsComponentSpacing),
                  DangerZoneBlock(),
                  SizedBox(height: kSettingsComponentSpacing),
                  MutableText(
                    core
                        .utils
                        .language
                        .langMap[core.state.preferences.language]!["settings"]
                            ["version"]
                        .replaceAll(
                      "{VERSION}",
                      kAppVersion,
                    ),
                    size: 14,
                    color: MutableColor.neutral2,
                    align: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  MutableButton(
                    scale: 0.85,
                    onTap: () {
                      launchUrl(kMarkMusicTwitter);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: MutableText(
                        core.utils.language.langMap[core.state.preferences
                            .language]!["settings"]["message"],
                        size: 13,
                        color: MutableColor.neutral3,
                        align: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SettingsNavBar(),
            ),
            AboutContextMenu(),
            Observer(
              builder: (_) => MutableOverlay(
                controller: core.state.preferences.overlayController,
                child: Center(
                  child: MutableLoader(
                    text: core.state.preferences.overlayText,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
