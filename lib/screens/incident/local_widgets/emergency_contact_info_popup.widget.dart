import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/mutable_emergency_contact_popup.widget.dart';

class EmergencyContactInfoPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MutableEmergencyContactPopup(
      name: "Filippo Fonseca",
      code: "(+506)",
      phone: "6049-9858",
    );
  }
}
