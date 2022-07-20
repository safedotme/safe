import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_emergency_contact_avatar/mutable_emergency_contact_avatar.widget.dart';
import 'package:safe/widgets/mutable_pill/mutable_pill.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentCardBody extends StatefulWidget {
  final Incident incident;

  IncidentCardBody(this.incident);

  @override
  State<IncidentCardBody> createState() => _IncidentCardBodyState();
}

class _IncidentCardBodyState extends State<IncidentCardBody> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kIncidentCardBodyPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MutableText(
                  widget.incident.name,
                  style: TypeStyle.h5,
                  weight: TypeWeight.bold,
                ),
                SizedBox(height: kIncidentBodyVerticalSpacing),
                MutableText(
                  widget.incident.location.isEmpty
                      ? ""
                      : (widget.incident.location[0].address ?? ""),
                  style: TypeStyle.body,
                  color: MutableColor.neutral2,
                ),
                SizedBox(height: kIncidentBodyVerticalSpacing),
                Row(
                  children: [
                    MutableEmergencyContactAvatar("Kelly Wakasa"),
                    SizedBox(width: kEmergencyContactAvatarSpacing),
                    MutableEmergencyContactAvatar("Filippo Fonseca"),
                    SizedBox(width: kEmergencyContactAvatarSpacing),
                    MutableEmergencyContactAvatar("Mark Music"),
                    SizedBox(width: kEmergencyContactAvatarSpacing),
                    MutableEmergencyContactAvatar("Ashley Alexander"),
                    SizedBox(width: kEmergencyContactAvatarSpacing),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          MutablePill(
            text: core.utils.language
                    .langMap[core.state.preferences.language]!["incident_card"]
                ["secured"],
            icon: MutableIcons.safe,
          )
        ],
      ),
    );
  }
}
