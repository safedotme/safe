import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';

class ChangePhoneAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return Theme(
      data: ThemeData.dark(),
      child: CupertinoAlertDialog(
        title: Text(
          // TODO: Extract
          "Change Phone",
        ),
        content: Text(
          "Changing your phone number is currently unavailable through the app. Notify the team and we'll help you out through SMS ({PHONE})!"
              .replaceAll(
            "{PHONE}",
            core.state.incidentLog.user?.phone ?? "",
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
              core.state.preferences.overlayController.hide();
            },
            child: Text(
              "Cancel",
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              Navigator.of(context).pop();
              core.state.preferences.overlayController.hide();

              //TODO: Log

              core.state.preferences.actionController.trigger(
                "The team has been notified!",
                MessageType.success,
              );
            },
            isDefaultAction: true,
            textStyle: TextStyle(fontWeight: FontWeight.w500),
            child: Text(
              "Notify",
            ),
          ),
        ],
      ),
    );
  }
}
