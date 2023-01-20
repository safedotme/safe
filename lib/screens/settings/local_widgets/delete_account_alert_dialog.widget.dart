import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';

class DeleteAccountAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return CupertinoAlertDialog(
      title: Text(
        "Delete Account", // TODO: Extract
      ),
      content: Text(
        "Deleting an account is currently unavailable due to the highly sensitive nature of Safe accounts and the information they store. We're actively working on finding a secure way make this possible.",
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Ok",
          ),
        ),
      ],
    );
  }
}
