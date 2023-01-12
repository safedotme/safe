import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/contacts/contacts.util.dart';
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
        widgets.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: MutableDivider(color: MutableColor.neutral7),
        ));
      } else {
        // Add widget

        widgets.add(Row(
          children: [
            MutableEmergencyContactAvatar(
              contacts[i ~/ 2],
            ),
            SizedBox(width: 6),
            MutableText(contacts[i ~/ 2].name, size: 18),
            Spacer(),
            MutableTag(),
          ],
        ));
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSideScreenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MutableText(
            "Emergency Contacts".toUpperCase(), // TODO: Extract
            weight: TypeWeight.heavy,
          ),
          SizedBox(height: kIncidentSubheaderToBody),
          ...constructEmergencyContactList(),

          // TODO: Remove later (spacer)
          SizedBox(height: 600),
        ],
      ),
    );
  }
}
