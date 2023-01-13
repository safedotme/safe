import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/local_widgets/emergency_contact_popup_header.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableEmergencyContactPopup extends StatelessWidget {
  final Widget body;
  final String name;
  final String phone;
  final String code;
  final bool immutable;
  final Function()? onChange;

  MutableEmergencyContactPopup({
    this.body = const SizedBox(),
    required this.name,
    required this.phone,
    required this.code,
    this.immutable = false,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return MutablePopup(
      type: PopupType.input,
      defaultState: PanelState.OPEN,
      body: Padding(
        padding: EdgeInsets.fromLTRB(18, 26, 18, 20),
        child: Column(
          children: [
            EmergencyContactPopupHeader(
              name: name,
              phone: phone,
              code: code,
              immutable: immutable,
              onChange: onChange,
            ),
          ],
        ),
      ),
    );
  }
}
