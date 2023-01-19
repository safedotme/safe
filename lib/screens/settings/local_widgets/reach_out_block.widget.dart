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
      header: "Reach Out", // TODO: Extract
      items: [
        SettingsBlockItem(
          text: "❤️\tRate the app",
          onTap: () {
            launchUrl(kRateAppUrl);
          },
        ),
        SettingsBlockItem(
          text: "🐦\tFollow on Twitter",
          onTap: () {
            launchUrl(kMarkMusicTwitter);
          },
        ),
        SettingsBlockItem(
          text: "💫\tStar on GitHub",
          onTap: () {
            launchUrl(kGitHubUrl);
          },
        ),
        SettingsBlockItem(
          text: "📧\tShoot us an email",
          onTap: () {
            launchUrl(kEmailUrl);
          },
        ),
      ],
    );
  }
}
