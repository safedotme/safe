import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_settings_block/mutable_settings_block.widget.dart';

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
    return MutableSettingsBlock(
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
    );
  }
}
