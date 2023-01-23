import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart' as api;
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_divider/mutable_divider.widget.dart';
import 'package:safe/widgets/mutable_input_popup_action/mutable_input_popup_action.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:uuid/uuid.dart';

class ImportContactPopup extends StatefulWidget {
  @override
  State<ImportContactPopup> createState() => _ImportContactPopupState();
}

class _ImportContactPopupState extends State<ImportContactPopup> {
  late Core core;
  bool tappedOut = true;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  void handleImportAdd() async {
    tappedOut = false;
    await core.state.contact.importContactPopupController.close();
    api.PhoneContact? rawC;

    try {
      rawC = await api.FlutterContactPicker.pickPhoneContact();
    } catch (e) {
      core.state.preferences.actionController.trigger(
        "Unable to load contact.", // TODO: Extract
        MessageType.error,
      );

      return;
    }

    final contact = Contact(
      id: Uuid().v1(),
      userId: core.services.auth.currentUser!.uid,
      name: rawC.fullName ?? "",
      phone: rawC.phoneNumber!.number ?? "",
    );

    core.state.contact.setEditable(contact);
    core.state.contact.editorContactController.setValues(
      phone: contact.phone,
      name: contact.name,
      code: contact.parsePhone()["code"],
    );
    core.state.contact.editorContactController.focus(true);
    core.state.contact.setIsAdding(true);
    core.state.contact.editorController.open();
  }

  void handleManualAdd() async {
    tappedOut = false;
    await core.state.contact.importContactPopupController.close();

    final contact = Contact(
      id: Uuid().v1(),
      userId: core.services.auth.currentUser!.uid,
      name: "",
      phone: "",
    );

    core.state.contact.setEditable(contact);
    core.state.contact.editorContactController.reset();
    core.state.contact.editorContactController.setValues(
      phone: "",
      name: "",
      code: kDefaultCountryCode,
    );
    core.state.contact.editorContactController.focus(true);
    core.state.contact.setIsAdding(true);
    core.state.contact.editorController.open();
  }

  @override
  Widget build(BuildContext context) {
    return MutablePopup(
      type: PopupType.input,
      controller: core.state.contact.importContactPopupController,
      height: 374,
      onClosed: () {
        if (tappedOut) core.utils.tutorial.handleOnLeave(core);
      },
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          kSideScreenMargin,
          25,
          kSideScreenMargin,
          0,
        ),
        child: Column(
          children: [
            Image.asset("assets/images/contacts.png"),
            SizedBox(height: 16),
            MutableText(
              "Import Contacts", //TODO: Extract
              size: 20,
              weight: TypeWeight.heavy,
            ),
            SizedBox(height: 5),
            MutableText(
              "To import, press on the contact's phone number", //TODO: Extract
              size: 14,
              align: TextAlign.center,
              color: MutableColor.neutral2,
            ),
            SizedBox(height: 30),
            MutableDivider(color: MutableColor.neutral7),
            MutableInputPopupAction(
              text: "Import", // TODO: Extract
              active: true,
              onTap: handleImportAdd,
            ),
            MutableDivider(color: MutableColor.neutral7),
            MutableInputPopupAction(
              text: "Add manually",
              onTap: handleManualAdd,
            ),
          ],
        ),
      ),
    );
  }
}
