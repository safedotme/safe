import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_settings_block/mutable_settings_block.widget.dart';
import 'package:safe/widgets/mutable_switch/mutable_switch.widget.dart';

class UserPreferencesBlock extends StatefulWidget {
  @override
  State<UserPreferencesBlock> createState() => _UserPreferencesBlockState();
}

class _UserPreferencesBlockState extends State<UserPreferencesBlock> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableSettingsBlock(
        header: "Preferences", // TODO: Extract
        items: [
          SettingsBlockItem(
            text: "Change Phone Number",
          ),
          SettingsBlockItem(
            text: "Livestream Quality",
          ),
          SettingsBlockItem(
            text: "Enable Face ID",
            action: MutableSwitch(),
          ),
        ],
      ),
    );
  }
}
