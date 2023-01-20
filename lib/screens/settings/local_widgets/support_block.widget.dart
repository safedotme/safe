import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/settings/local_widgets/about_context_menu.widget.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_context_menu/local_widgets/context_menu_item.widget.dart';
import 'package:safe/widgets/mutable_context_menu/mutable_context_menu.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_settings_block/mutable_settings_block.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportBlock extends StatefulWidget {
  @override
  State<SupportBlock> createState() => _SupportBlockState();
}

class _SupportBlockState extends State<SupportBlock> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        MutableSettingsBlock(
          header: "Support", // TODO: Extract
          items: [
            SettingsBlockItem(
              text: "About",
              onTap: () {
                core.state.preferences.aboutContextMenuController.toggle();
              },
            ),
            SettingsBlockItem(
              text: "Help",
            ),
            SettingsBlockItem(
              text: "Give feedback",
            ),
          ],
        ),
      ],
    );
  }
}
