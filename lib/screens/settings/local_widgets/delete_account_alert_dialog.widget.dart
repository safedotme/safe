import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';

class DeleteAccountAlertDialog extends StatefulWidget {
  @override
  State<DeleteAccountAlertDialog> createState() =>
      _DeleteAccountAlertDialogState();
}

class _DeleteAccountAlertDialogState extends State<DeleteAccountAlertDialog> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        core.utils.language
                .langMap[core.state.preferences.language]!["settings"]["danger"]
            ["delete_acc"]["modal"]["header"],
      ),
      content: Text(
        core.utils.language
                .langMap[core.state.preferences.language]!["settings"]["danger"]
            ["delete_acc"]["modal"]["desc"],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            core.utils.language
                    .langMap[core.state.preferences.language]!["settings"]
                ["danger"]["delete_acc"]["modal"]["button"],
          ),
        ),
      ],
    );
  }
}
