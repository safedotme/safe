import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart' as model;
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/phone/codes.util.dart';
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

  String? formatPhone(String ph) {
    Map? country;

    for (final c in kCountryCodes) {
      if (ph.contains(c["dial_code"]!)) {
        country = c;
      }
    }

    country ??= {
      "dial_code": kDefaultCountryCode,
    };

    return "${country["dial_code"]} ${ph.replaceAll(country["dial_code"], "")}";
  }

  void handleImportAdd() async {
    tappedOut = false;
    await core.state.contact.importContactPopupController.close();
    final res = await core.services.permissions.checkContactPermission(core);

    if (!res) {
      core.state.preferences.actionController.trigger(
        core.utils.language.langMap[core.state.preferences.language]!["contact"]
            ["input"]["errors"]["load"],
        MessageType.error,
      );
      return;
    }

    List<Contact> raw = await ContactsService.getContacts();

    List<Map> contacts = [];

    for (Contact c in raw) {
      String? phone;
      String? name = c.displayName == null
          ? null
          : c.displayName == ""
              ? null
              : c.displayName;

      if (c.phones != null && c.phones!.isNotEmpty) {
        phone = formatPhone(c.phones!.first.value ?? "");
      }

      if (phone != null && name != null) {
        contacts.add({
          "name": name,
          "phone": phone,
        });
      }
    }

    core.state.contact.setRawContacts(contacts);
    core.state.contact.setViewContacts(contacts);

    core.state.contact.customContactImportController.open();
  }

  void handleManualAdd() async {
    tappedOut = false;
    await core.state.contact.importContactPopupController.close();

    final contact = model.Contact(
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
      height: 330,
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
            Spacer(),
            Image.asset(
              "assets/images/contacts.png",
              width: 65,
            ),
            Spacer(),
            MutableText(
              core.utils.language
                      .langMap[core.state.preferences.language]!["contact"]
                  ["input"]["header"],
              size: 20,
              weight: TypeWeight.heavy,
            ),
            SizedBox(height: 5),
            MutableText(
              core.utils.language
                      .langMap[core.state.preferences.language]!["contact"]
                  ["input"]["desc"],
              size: 14,
              align: TextAlign.center,
              color: MutableColor.neutral2,
            ),
            SizedBox(height: 30),
            MutableDivider(color: MutableColor.neutral7),
            MutableInputPopupAction(
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["contact"]
                  ["input"]["buttons"]["import"],
              active: true,
              onTap: handleImportAdd,
            ),
            MutableDivider(color: MutableColor.neutral7),
            MutableInputPopupAction(
              text: core.utils.language
                      .langMap[core.state.preferences.language]!["contact"]
                  ["input"]["buttons"]["manual"],
              onTap: handleManualAdd,
            ),
          ],
        ),
      ),
    );
  }
}
