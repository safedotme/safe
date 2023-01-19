import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/settings/local_widgets/our_story_banner.widget.dart';
import 'package:safe/screens/settings/local_widgets/settings_nav_bar.widget.dart';
import 'package:safe/screens/settings/local_widgets/user_preferences_block.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_overlay/mutable_overlay.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_settings_block/mutable_settings_block.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      isOpen: true, // TODO: Set to false
      controller: core.state.preferences.controller,
      isDismissable: false,
      body: Container(
        color: kColorMap[MutableColor.neutral10],
        child: Stack(
          children: [
            SingleChildScrollView(
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
                  MutableSettingsBlock(
                    header: "Reach Out", // TODO: Extract
                    items: [
                      SettingsBlockItem(
                        text: "❤️\tRate the app",
                      ),
                      SettingsBlockItem(
                        text: "🐦\tFollow on Twitter",
                      ),
                      SettingsBlockItem(
                        text: "💫\tStar on GitHub",
                      ),
                      SettingsBlockItem(
                        text: "📧\tShoot us an email",
                      ),
                    ],
                  ),
                  SizedBox(height: kSettingsComponentSpacing),
                  MutableSettingsBlock(
                    header: "Support", // TODO: Extract
                    items: [
                      SettingsBlockItem(
                        text: "About",
                      ),
                      SettingsBlockItem(
                        text: "Help",
                      ),
                      SettingsBlockItem(
                        text: "Give feedback",
                      ),
                    ],
                  ),
                  SizedBox(height: kSettingsComponentSpacing),
                  MutableSettingsBlock(
                    header: "Danger Zone", // TODO: Extract
                    items: [
                      SettingsBlockItem(
                        text: "Sign Out",
                        textColor: MutableColor.secondaryRed,
                      ),
                      SettingsBlockItem(
                        text: "Delete Account",
                        textColor: MutableColor.secondaryRed,
                      ),
                    ],
                  ),
                  SizedBox(height: kSettingsComponentSpacing),
                  MutableText(
                    "Version 1.0.1 - Production", // TODO: Extract
                    size: 14,
                    color: MutableColor.neutral2,
                    align: TextAlign.center,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SettingsNavBar(),
            ),
            MutableOverlay(
              controller: core.state.preferences.overlayController,
            ),
          ],
        ),
      ),
    );
  }
}
