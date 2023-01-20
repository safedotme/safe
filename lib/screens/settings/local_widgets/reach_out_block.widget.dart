import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_settings_block/mutable_settings_block.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ReachOutBlock extends StatefulWidget {
  @override
  State<ReachOutBlock> createState() => _ReachOutBlockState();
}

class _ReachOutBlockState extends State<ReachOutBlock> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableSettingsBlock(
      header: core.utils.language
              .langMap[core.state.preferences.language]!["settings"]
          ["reach_out"]["header"],
      items: [
        SettingsBlockItem(
          text: core.utils.language
                  .langMap[core.state.preferences.language]!["settings"]
              ["reach_out"]["rate"],
          onTap: () {
            launchUrl(kRateAppUrl);
          },
        ),
        SettingsBlockItem(
          text: core.utils.language
                  .langMap[core.state.preferences.language]!["settings"]
              ["reach_out"]["twitter"],
          onTap: () {
            launchUrl(kMarkMusicTwitter);
          },
        ),
        SettingsBlockItem(
          text: core.utils.language
                  .langMap[core.state.preferences.language]!["settings"]
              ["reach_out"]["github"],
          onTap: () {
            launchUrl(kGitHubUrl);
          },
        ),
        SettingsBlockItem(
          text: core.utils.language
                  .langMap[core.state.preferences.language]!["settings"]
              ["reach_out"]["email"],
          onTap: () {
            launchUrl(kEmailUrl);
          },
        ),
      ],
    );
  }
}
