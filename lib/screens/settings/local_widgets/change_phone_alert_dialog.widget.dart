import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';

class ChangePhoneAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return CupertinoAlertDialog(
      title: Text(
        core.utils.language
                .langMap[core.state.preferences.language]!["settings"]
            ["preferences"]["change_phone"]["popup"]["header"],
      ),
      content: Text(
        core
            .utils
            .language
            .langMap[core.state.preferences.language]!["settings"]
                ["preferences"]["change_phone"]["popup"]["body"]
            .replaceAll(
          "{PHONE}",
          core.state.incidentLog.user?.phone ?? "",
        ),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            core.utils.language
                    .langMap[core.state.preferences.language]!["settings"]
                ["preferences"]["change_phone"]["popup"]["cancel"],
          ),
        ),
        CupertinoDialogAction(
          onPressed: () async {
            Navigator.of(context).pop();

            core.services.analytics.log(AnalyticsLog(
              channel: "change-phone-number",
              event: "change-request",
              description:
                  "User has requested to change their phone number.\n\t**Phone Number**: ${core.state.incidentLog.user?.phone}\n**Name**: ${core.state.incidentLog.user?.name}",
              icon: "☎️",
              tags: {
                "userid": core.state.incidentLog.user?.id ?? "",
              },
            ));

            core.state.preferences.actionController.trigger(
              core.utils.language
                      .langMap[core.state.preferences.language]!["settings"]
                  ["preferences"]["change_phone"]["popup"]["notify_success"],
              MessageType.success,
            );
          },
          isDefaultAction: true,
          textStyle: TextStyle(fontWeight: FontWeight.w500),
          child: Text(
            core.utils.language
                    .langMap[core.state.preferences.language]!["settings"]
                ["preferences"]["change_phone"]["popup"]["notify"],
          ),
        ),
      ],
    );
  }
}
