import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/screens/contact_editor/local_widgets/contact_editor_action.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_divider/mutable_divider.widget.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/mutable_emergency_contact_popup.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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

  @override
  Widget build(BuildContext context) {
    return MutableEmergencyContactPopup(
      panelController: core.state.contact.editorController,
      controller: core.state.contact.editorContactController,
      immutable: false,
      onNameChange: (name) {
        final contact = core.state.contact.editable!.copyWith(
          name: name,
        );

        core.state.contact.setEditable(contact);
      },
      height: 316,
      onCodeTap: () {
        core.state.contact.countryCodeSelectorController.open();
      },
      onPhoneChange: (phone) {
        final contact = core.state.contact.editable!;

        final comps = contact.parsePhone();

        core.state.contact.setEditable(contact.copyWith(
          phone: "${comps["code"]} $phone",
        ));
      },
      body: Expanded(
        child: Column(
          children: [
            SizedBox(height: 34),
            MutableDivider(color: MutableColor.neutral7),
            ContactEditorAction(
              text: "Save", // TODO: Extract
              active: true,
              onTap: () {
                HapticFeedback.lightImpact();
                print("save");
              },
            ),
            MutableDivider(color: MutableColor.neutral7),
            ContactEditorAction(
              text: "Cancel", // TODO: Extract
              onTap: () {
                HapticFeedback.lightImpact();
                core.state.contact.editorController.close();
              },
            ),
          ],
        ),
      ),
    );
  }
}
