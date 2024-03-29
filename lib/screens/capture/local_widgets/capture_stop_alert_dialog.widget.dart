import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';

class CaptureStopAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return Theme(
      data: ThemeData.dark(),
      child: CupertinoAlertDialog(
        title: Text(
          core.utils.language
                  .langMap[core.state.preferences.language]!["capture"]
              ["controls"]["stop_alert"]["header"],
        ),
        content: Text(
          core.utils.language
                  .langMap[core.state.preferences.language]!["capture"]
              ["controls"]["stop_alert"]["content"],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              core.utils.language
                      .langMap[core.state.preferences.language]!["capture"]
                  ["controls"]["stop_alert"]["cancel"],
            ),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              core.utils.capture.stop();
              Navigator.of(context).pop();
            },
            isDefaultAction: true,
            textStyle: TextStyle(fontWeight: FontWeight.w500),
            child: Text(
              core.utils.language
                      .langMap[core.state.preferences.language]!["capture"]
                  ["controls"]["stop_alert"]["confirm"],
            ),
          ),
        ],
      ),
    );
  }
}
