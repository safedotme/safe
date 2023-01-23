import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/credit/credit.util.dart';
import 'package:safe/widgets/mutable_home_message.widget.dart/mutable_home_banner.widget.dart';
import 'package:safe/widgets/mutable_pill/mutable_pill.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class IncidentLimitHomeBanner extends StatefulWidget {
  @override
  State<IncidentLimitHomeBanner> createState() =>
      _IncidentLimitHomeBannerState();
}

class _IncidentLimitHomeBannerState extends State<IncidentLimitHomeBanner> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  String parsePermissions(List<Permission> p) {
    String template = "{p} permission";

    List<String> parsed = [];

    for (Permission permission in p) {
      parsed.add(
          permission.toString().substring(11, permission.toString().length));
    }

    if (parsed.length == 1) {
      return template.replaceAll("{p}", parsed.first);
    }

    String last = parsed.removeLast();

    String raw = parsed.toString();

    template += "s";

    String listed = "${raw.replaceAll("[", "").replaceAll("]", "")}, and $last";

    return template.replaceAll("{p}", listed);
  }

  String handlePermissionError() {
    String base =
        core.utils.language.langMap[core.state.preferences.language]!["home"]
            ["incident_limit"]["body"][core.state.capture.limErrState];

    if (core.state.capture.limErrState != LimitErrorState.permissions) {
      return base;
    }

    return base.replaceAll(
      "{permission}",
      parsePermissions(core.state.preferences.disabledPermissions),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableHomeBanner(
        state: PanelState.CLOSED,
        isShimmering: core.state.capture.shouldFlashLimitBanner,
        shimmerColor: kColorMap[MutableColor.secondaryRed]!.withOpacity(0.75),
        controller: core.state.capture.limErrorBannerController,
        height: 120,
        dismissable: false,
        header: (core.utils.language
                        .langMap[core.state.preferences.language]!["home"]
                    ["incident_limit"]["header"][core.state.capture.limErrState]
                as String)
            .toUpperCase(),
        backgroundColor: MutableColor.secondaryRed,
        borderColor: MutableColor.secondaryRed,
        onTap: () async {
          HapticFeedback.mediumImpact();

          if (core.state.capture.limErrState == LimitErrorState.noConnection) {
            AppSettings.openWIFISettings();
            return;
          }

          if (core.state.capture.limErrState ==
              LimitErrorState.missingContacts) {
            core.state.contact.importContactPopupController.open();
            return;
          }

          if (core.state.capture.limErrState == LimitErrorState.permissions) {
            openAppSettings();
            return;
          }

          if (core.state.capture.limErrState == LimitErrorState.emergency) {
            core.utils.capture.start();
            core.state.capture.controller.open();
            return;
          }

          if (core.state.capture.limErrState == LimitErrorState.maxed) {
            core.state.incidentLog.controller.open();
            return;
          }
        },
        body: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MutableText(
                handlePermissionError(),
                weight: TypeWeight.medium,
                size: 13,
                color: MutableColor.neutral2,
              ),
              Row(
                children: [
                  MutablePill(
                    isButton: true,
                    text: (core.utils.language.langMap[core.state.preferences
                                .language]!["home"]["incident_limit"]["button"]
                            [core.state.capture.limErrState] as String)
                        .toUpperCase(),
                    color: MutableColor.secondaryRed,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
