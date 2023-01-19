import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/screens/capture/local_widgets/capture_stop_alert_dialog.widget.dart';
import 'package:safe/screens/settings/local_widgets/change_phone_alert_dialog.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_settings_block/local_widgets/settings_block_item.widget.dart';
import 'package:safe/widgets/mutable_settings_block/mutable_settings_block.widget.dart';
import 'package:safe/widgets/mutable_switch/mutable_switch.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPreferencesBlock extends StatefulWidget {
  @override
  State<UserPreferencesBlock> createState() => _UserPreferencesBlockState();
}

class _UserPreferencesBlockState extends State<UserPreferencesBlock> {
  late Core core;
  String? quality;
  SharedPreferences? _client;

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
      setBiometrics(false);
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
      setBiometrics(false);
      return false;
    }

    setBiometrics(true);
    return true;
  }

  void setBiometrics(bool v) {
    core.state.preferences.setBiometricsEnabled(v);
    core.services.preferences.setBiometricsEnabled(v, _client!);
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
                ["preferences"]["change_phone"]["header"],
            onTap: () {
              HapticFeedback.lightImpact();
              showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => ChangePhoneAlertDialog(),
              );
            },
          ),
          SettingsBlockItem(
            text: core.utils.language
                    .langMap[core.state.preferences.language]!["settings"]
                ["preferences"]["quality"]["header"],
            onTap: () {
              launchUrl(kLivestreamQualityInfo);
            },
            following: Padding(
              padding: EdgeInsets.only(left: 8),
              child: MutableIcon(
                MutableIcons.info,
                size: Size(16, 16),
                color: Colors.white,
              ),
            ),
            action: MutableText(
              quality == null
                  ? core.utils.language
                          .langMap[core.state.preferences.language]!["settings"]
                      ["preferences"]["quality"]["loading"]
                  : core
                      .utils
                      .language
                      .langMap[core.state.preferences.language]!["settings"]
                          ["preferences"]["quality"]["template"]
                      .replaceAll(
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
              defaultState: core.state.preferences.biometricsEnabled ?? false,
              onChange: handleFaceIDTap,
            ),
          ),
        ],
      ),
    );
  }
}
