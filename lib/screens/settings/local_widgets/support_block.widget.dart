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
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      listenToPosition();
    });

    core.state.preferences.scrollController.addListener(() {
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
