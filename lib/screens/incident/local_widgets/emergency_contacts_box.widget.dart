import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/screens/incident/local_widgets/emergency_contact_bar.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/contacts/contacts.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_divider/mutable_divider.widget.dart';
import 'package:safe/widgets/mutable_emergency_contact_avatar/mutable_emergency_contact_avatar.widget.dart';
import 'package:safe/widgets/mutable_tag/mutable_tag.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class EmergencyContactsBox extends StatefulWidget {
  final Incident incident;

  EmergencyContactsBox(this.incident);
  @override
  State<EmergencyContactsBox> createState() => _EmergencyContactsBoxState();
}

class _EmergencyContactsBoxState extends State<EmergencyContactsBox> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  List<Widget> constructEmergencyContactList() {
    List<Widget> widgets = [];
    List<NotifiedContact>? contacts = widget.incident.contactLog;

    if (contacts == null) return widgets;

    contacts = ContactsUtil.formatContactList(contacts);

    // For loop will add spacer or widget based on widget length
    for (int i = 0; i < contacts!.length * 2 - 1; i++) {
      if (i.isOdd) {
        // Add Separator
        widgets.add(
          MutableDivider(color: MutableColor.neutral7),
        );
      } else {
        // Add widget
        widgets.add(EmergencyContactBar(
          contacts[i ~/ 2],
          onTap: (c) {
            fetchContactNotifications(c.id);
            core.state.incident.contactPopupController.open();
          },
        ));
      }
    }

    return widgets;
  }

  void fetchContactNotifications(String id) {
    List<NotifiedContact> contacts = [];

    if (widget.incident.contactLog == null) return;

    contacts = widget.incident.contactLog!.where((c) => c.id == id).toList();

    core.state.incident.setContacts(contacts);

    // Values used to set popup controller name and phone
    var phoneInfo = contacts.first.parsePhone();

    core.state.incident.contactPopupValuesController.setValues(
      name: contacts.first.name,
      phone: phoneInfo["phone"],
      code: phoneInfo["code"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSideScreenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MutableText(
            core
                .utils
                .language
                .langMap[core.state.preferences.language]!["incident"]
                    ["contacts"]["header"]
                .toUpperCase(),
            weight: TypeWeight.heavy,
          ),
          SizedBox(height: 5),
          ...constructEmergencyContactList(),
        ],
      ),
    );
  }
}
