import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/incident/local_widgets/contact_timeline.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_divider/mutable_divider.widget.dart';
import 'package:safe/widgets/mutable_emergency_contact_popup/mutable_emergency_contact_popup.widget.dart';

class EmergencyContactInfoPopup extends StatefulWidget {
  @override
  State<EmergencyContactInfoPopup> createState() =>
      _EmergencyContactInfoPopupState();
}

class _EmergencyContactInfoPopupState extends State<EmergencyContactInfoPopup> {
  double height = kDefaultInputPopupHeight;
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableEmergencyContactPopup(
        panelController: core.state.incident.contactPopupController,
        immutable: true,
        controller: core.state.incident.contactPopupValuesController,
        height: 295.0 + (45 * (core.state.incident.contacts.length - 1)),
        body: Expanded(
          child: Column(
            children: [
              SizedBox(height: 32),
              MutableDivider(
                color: MutableColor.neutral7,
              ),
              SizedBox(height: 22),
              ContactTimeline(core.state.incident.contacts),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
