import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/mutable_emergency_contact_popup.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
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
        print(name);
      },
      height: 265,
      onPhoneChange: (phone) {
        print(phone);
      },
    );
  }
}

//  MutableEmergencyContactPopup(
//         panelController: core.state.incident.contactPopupController,
//         immutable: true,
//         controller: core.state.incident.contactPopupValuesController,
//         height: 295.0 + (45 * (core.state.incident.contacts.length - 1)),
//         body: Expanded(
//           child: Column(
//             children: [
//               SizedBox(height: 32),
//               MutableDivider(
//                 color: MutableColor.neutral7,
//               ),
//               SizedBox(height: 22),
//               ContactTimeline(core.state.incident.contacts),
//             ],
//           ),
//         ),
//       )
