import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_settings_block/mutable_settings_block.widget.dart';
import 'package:safe/widgets/mutable_switch/mutable_switch.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class UserPreferencesBlock extends StatefulWidget {
  @override
  State<UserPreferencesBlock> createState() => _UserPreferencesBlockState();
}

class _UserPreferencesBlockState extends State<UserPreferencesBlock> {
  late Core core;
  String? quality;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    fetchQuality();
  }

  void logError(String msg) {
    core.state.preferences.actionController.trigger(
      msg,
      MessageType.error,
    );
  }

  Future<bool> handleFaceIDTap(bool v) async {
    if (!v) {
      core.state.preferences.setFaceIDEnabled(false);
      return true;
    }

    final isAvailable = await core.services.localAuth.isAvailable();

    if (!isAvailable) {
      logError("Face ID is unavailable");
      return false;
    }

    final active = await core.services.localAuth.authenticate(
      "Authenticate to enable service", // TODO: Extract
    );

    if (!active) {
      logError("Face ID failed. Try again"); // TODO: Extract
      core.state.preferences.setFaceIDEnabled(false);
      return false;
    }

    core.state.preferences.setFaceIDEnabled(true);
    return true;
  }

  void fetchQuality() async {
    final settings = await core.services.server.admin.readLatest();

    setState(() {
      quality = settings.dimensionHeight.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableSettingsBlock(
        header: core.utils.language
                .langMap[core.state.preferences.language]!["settings"]
            ["preferences"]["header"],
        items: [
          SettingsBlockItem(
            text: core.utils.language
                    .langMap[core.state.preferences.language]!["settings"]
                ["preferences"]["change_phone"],
          ),
          SettingsBlockItem(
            text: core.utils.language
                    .langMap[core.state.preferences.language]!["settings"]
                ["preferences"]["quality"],
            onTap: () {
              print("here");
            },
            action: MutableText(
              quality == null
                  ? "Loading quality..."
                  : "High ({DIMENSION}p)".replaceAll(
                      // TODO: Extract
                      "{DIMENSION}",
                      quality!,
                    ),
              size: 18,
              color: MutableColor.neutral2,
            ),
          ),
          SettingsBlockItem(
            text: core.utils.language
                    .langMap[core.state.preferences.language]!["settings"]
                ["preferences"]["face_id"],
            action: MutableSwitch(
              defaultState: core.state.preferences.isFaceIDEnabled,
              onChange: handleFaceIDTap,
            ),
          ),
        ],
      ),
    );
  }
}
