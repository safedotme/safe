import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/utils/phone/codes.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_divider/mutable_divider.widget.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/mutable_emergency_contact_popup.widget.dart';
import 'package:safe/widgets/mutable_input_popup_action/mutable_input_popup_action.widget.dart';

import '../../widgets/mutable_icon/mutable_icon.widget.dart';

class ContactEditorScreen extends StatefulWidget {
  @override
  State<ContactEditorScreen> createState() => _ContactEditorScreenState();
}

class _ContactEditorScreenState extends State<ContactEditorScreen> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  Future<bool> authenticate() async {
    final enabled = core.state.preferences.biometricsEnabled;
    if (enabled == null || !enabled) return true;

    final authenticate = await core.services.localAuth.authenticate(
      "Authenticate to add contact", //TODO: Extract
    );

    return authenticate;
  }

  void handleSave() async {
    HapticFeedback.lightImpact();

    // Unfocus
    core.state.contact.editorContactController.unfocus(true);
    core.state.contact.editorContactController.unfocus(false);

    final auth = await authenticate();

    if (!auth) {
      core.state.preferences.actionController.trigger(
        "Face ID failed. Try again", //TODO: Extract
        MessageType.error,
      );

      return;
    }

    // Check if phone is valid
    final contact = core.state.contact.editable!;
    final phone = contact.parsePhone();

    final code = kCountryCodes
        .where(
          (c) => c["dial_code"] == phone["code"],
        )
        .toList();

    final valid = await core.utils.phone.validate(
      phone["phone"]!,
      code.first["code"]!,
    );

    if (!valid) {
      core.state.preferences.actionController.trigger(
        "Phone number is invalid", //TODO: Extract
        MessageType.error,
      );
      return;
    }

    // Check if name is valid
    final res = core.utils.name.validateName(contact.name);

    if (!res["error"]) {
      // Show success
      core.state.contact.editorController.close();
      core.state.preferences.actionController.trigger(
        "Contact saved!", //TODO: Extract
        MessageType.success,
      );

      core.services.server.contacts.upsert(contact);
      return;
    }

    Map<String, String> errors = {
      //TODO: Extract
      "error-emptyField": "To save, name your contact.",
      "error-lastName": "To save, add a last name.",
    };

    core.state.preferences.actionController.trigger(
      errors[res["reason"]]!,
      MessageType.error,
    );

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableEmergencyContactPopup(
        panelController: core.state.contact.editorController,
        controller: core.state.contact.editorContactController,
        immutable: false,
        showInitials: !core.state.contact.isAdding,
        onNameChange: (name) {
          final contact = core.state.contact.editable!.copyWith(
            name: name,
          );

          core.state.contact.setEditable(contact);
        },
        height: 316 -
            (kEmergencyContactAvatarPopupSize *
                (core.state.contact.isAdding ? 1 : 0)),
        onCodeTap: () {
          core.state.contact.countryCodeSelectorController.open();
        },
        onPhoneChange: (phone) {
          final contact = core.state.contact.editable!;

          core.state.contact.setEditable(contact.copyWith(phone: phone));
        },
        body: Expanded(
          child: Column(
            children: [
              SizedBox(height: 34),
              MutableDivider(color: MutableColor.neutral7),
              MutableInputPopupAction(
                text: core.state.contact.isAdding
                    ? "Add Contact"
                    : "Save", // TODO: Extract
                active: true,
                onTap: handleSave,
                icon: MutableIcon(
                  MutableIcons.faceID,
                  size: Size(18, 18),
                ),
              ),
              MutableDivider(color: MutableColor.neutral7),
              MutableInputPopupAction(
                text: "Cancel", // TODO: Extract
                onTap: () {
                  HapticFeedback.lightImpact();
                  core.state.contact.editorController.close();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
