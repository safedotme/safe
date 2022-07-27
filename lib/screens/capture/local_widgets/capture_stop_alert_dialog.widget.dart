import 'package:flutter/cupertino.dart';

class CaptureStopAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Stop Recording"),
      content: Text(
          "This will stop location and camera streams and upload data to the cloud"),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          isDefaultAction: true,
          textStyle: TextStyle(fontWeight: FontWeight.w500),
          child: Text("Confirm"),
        ),
      ],
    );
  }
}
