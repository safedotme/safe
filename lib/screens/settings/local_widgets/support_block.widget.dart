import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_settings_block/mutable_settings_block.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportBlock extends StatefulWidget {
  @override
  State<SupportBlock> createState() => _SupportBlockState();
}

class _SupportBlockState extends State<SupportBlock> {
  late Core core;
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listenToPosition();
    });

    core.state.preferences.scrollController.addListener(() {
      if (!core.state.preferences.scrollController.hasClients) return;
      listenToPosition();
    });
  }

  void listenToPosition() {
    if (key.currentContext == null) return;

    final box = key.currentContext!.findRenderObject() as RenderBox?;

    if (box == null) return;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double pos = box.localToGlobal(Offset.zero).dy;
      core.state.preferences.setContextMenuPos(pos);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: key,
      clipBehavior: Clip.none,
      children: [
        MutableSettingsBlock(
          header: core.utils.language
                  .langMap[core.state.preferences.language]!["settings"]
              ["support"]["header"],
          items: [
            SettingsBlockItem(
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["settings"]
                  ["support"]["about"]["header"],
              onTap: () {
                core.state.preferences.aboutContextMenuController.toggle();
              },
            ),
            SettingsBlockItem(
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["settings"]
                  ["support"]["help"],
              onTap: () {
                launchUrl(kHelpCenter);
              },
            ),
            SettingsBlockItem(
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["settings"]
                  ["support"]["deletion_policy"],
              onTap: () {
                launchUrl(kDeleteIncident);
              },
            ),
            SettingsBlockItem(
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["settings"]
                  ["support"]["feedback"],
              onTap: () {
                launchUrl(kGiveFeedback);
              },
            ),
          ],
        ),
      ],
    );
  }
}
