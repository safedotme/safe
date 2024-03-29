import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';

class ContactEditingActionSheet extends StatefulWidget {
  final Contact contact;
  final void Function()? onEdit;

  ContactEditingActionSheet({required this.contact, this.onEdit});
  @override
  State<ContactEditingActionSheet> createState() =>
      _ContactEditingActionSheetState();
}

class _ContactEditingActionSheetState extends State<ContactEditingActionSheet> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  Future<void> handleRemove() async {
    core.state.contact.setIsEditing(false);

    if (core.state.contact.contacts!.length == 1) {
      core.state.preferences.actionController.trigger(
        core.utils.language.langMap[core.state.preferences.language]!["contact"]
            ["errors"]["min"],
        MessageType.error,
      );

      return;
    }

    final shouldAuth = core.state.preferences.biometricsEnabled;

    if (!(shouldAuth == null || !shouldAuth)) {
      final passed = await core.services.localAuth.authenticate(
        core.utils.language.langMap[core.state.preferences.language]!["contact"]
            ["action_sheet"]["auth_reason"],
      );

      if (!passed) {
        core.state.preferences.actionController.trigger(
          core.utils.language
                  .langMap[core.state.preferences.language]!["contact"]
              ["action_sheet"]["auth_unavailable"],
          MessageType.error,
        );
        return;
      }
    }

    // ⬇️ Remove User

    await core.services.server.contacts.delete(widget.contact.id);
  }

  Future<void> handleEdit() async {
    await core.state.contact.controller.close();

    final data = widget.contact.parsePhone();

    core.state.contact.editorContactController.setValues(
      name: widget.contact.name,
      phone: data["phone"],
      code: data["code"],
    );

    core.state.contact.setEditable(widget.contact);

    widget.onEdit?.call();
    core.state.contact.editorController.open();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        widget.contact.name,
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            core.state.contact.setIsEditing(false);
            Navigator.pop(context);

            handleEdit();
          },
          child: Text(core.utils.language
                  .langMap[core.state.preferences.language]!["contact"]
              ["action_sheet"]["edit"]),
        ),
        CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () async {
            Navigator.pop(context);

            handleRemove();
          },
          child: Text(
            core.utils.language
                    .langMap[core.state.preferences.language]!["contact"]
                ["action_sheet"]["remove"],
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(core.utils.language
                .langMap[core.state.preferences.language]!["contact"]
            ["action_sheet"]["cancel"]),
      ),
    );
  }
}
