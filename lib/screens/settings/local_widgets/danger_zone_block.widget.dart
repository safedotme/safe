import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/settings/local_widgets/delete_account_alert_dialog.widget.dart';
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
      header: core.utils.language
              .langMap[core.state.preferences.language]!["settings"]["danger"]
          ["header"],
      items: [
        SettingsBlockItem(
          text: core.utils.language
                  .langMap[core.state.preferences.language]!["settings"]
              ["danger"]["sign_out"]["header"],
          textColor: MutableColor.secondaryRed,
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (_) => CupertinoActionSheet(
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      core.utils.language.langMap[
                              core.state.preferences.language]!["settings"]
                          ["danger"]["sign_out"]["modal"]["header"],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(core.utils.language.langMap[
                            core.state.preferences.language]!["settings"]
                        ["danger"]["sign_out"]["modal"]["desc"]),
                    SizedBox(height: 10),
                  ],
                ),
                actions: [
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    onPressed: () async {
                      Navigator.pop(context);
                      core.state.preferences.setOverlayText(
                        core.utils.language.langMap[
                                core.state.preferences.language]!["settings"]
                            ["danger"]["sign_out"]["overlay"],
                      );
                      await core.state.preferences.overlayController.show();
                      await core.state.incidentLog.controller.close();
                      core.state.preferences.overlayController.hide();
                      core.services.auth.signOut();
                    },
                    child: Text(
                      core.utils.language.langMap[
                              core.state.preferences.language]!["settings"]
                          ["danger"]["sign_out"]["modal"]["button"],
                    ),
                  )
                ],
                cancelButton: CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    core.utils.language.langMap[
                            core.state.preferences.language]!["settings"]
                        ["danger"]["sign_out"]["modal"]["cancel"],
                  ),
                ),
              ),
            );
          },
        ),
        SettingsBlockItem(
          text: core.utils.language
                  .langMap[core.state.preferences.language]!["settings"]
              ["danger"]["delete_acc"]["header"],
          onTap: () {
            showCupertinoDialog(
              context: context,
              barrierDismissible: true,
              builder: (_) => DeleteAccountAlertDialog(),
            );
          },
          textColor: MutableColor.secondaryRed,
        ),
      ],
    );
  }
}
