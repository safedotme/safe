import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_settings_block/mutable_settings_block.widget.dart';

class DangerZoneBlock extends StatefulWidget {
  @override
  State<DangerZoneBlock> createState() => _DangerZoneBlockState();
}

class _DangerZoneBlockState extends State<DangerZoneBlock> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return MutableSettingsBlock(
      header: "Danger Zone", // TODO: Extract
      items: [
        SettingsBlockItem(
          text: "Sign Out",
          textColor: MutableColor.secondaryRed,
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (_) => CupertinoActionSheet(
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Sign Out",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text("Are you sure you want to sign out?"),
                    SizedBox(height: 10),
                  ],
                ),
                actions: [
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () async {
                      Navigator.pop(context);
                      core.state.preferences.setOverlayText(
                        "Signing out",
                      ); // TODO: Extract
                      await core.state.preferences.overlayController.show();
                      await core.state.incidentLog.controller.close();
                      core.state.preferences.overlayController.hide();
                      core.services.auth.signOut();
                    },
                    child: Text("Sign Out"),
                  )
                ],
                cancelButton: CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ),
            );
          },
        ),
        SettingsBlockItem(
          text: "Delete Account",
          textColor: MutableColor.secondaryRed,
        ),
      ],
    );
  }
}
