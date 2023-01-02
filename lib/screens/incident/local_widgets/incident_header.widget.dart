import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/contacts/contacts.util.dart';
import 'package:safe/widgets/mutable_emergency_contact_avatar/mutable_emergency_contact_avatar.widget.dart';
import 'package:safe/widgets/mutable_play_button/mutable_play_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentHeader extends StatefulWidget {
  @override
  State<IncidentHeader> createState() => _IncidentHeaderState();
}

class _IncidentHeaderState extends State<IncidentHeader> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  String generateAddress(Incident incident) {
    if (incident.location == null) {
      return "";
    }

    if (incident.location!.isEmpty) {
      return "";
    }

    if (incident.location![0].address == null) {
      return "";
    }

    return core.utils.geocoder.removeTag(incident.location![0].address!);
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return SizedBox(
      width: query.size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kSideScreenMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MutableText(
                    core.state.incident.incident!.name,
                    size: 26,
                    weight: TypeWeight.heavy,
                  ),
                  SizedBox(height: 6),
                  MutableText(
                    generateAddress(core.state.incident.incident!),
                    size: 14,
                    color: MutableColor.neutral2,
                  ),
                  SizedBox(height: 6),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Transform.scale(
                      scale: 1.1,
                      child: core.state.incident.incident!.contactLog == null
                          ? SizedBox()
                          : Row(
                              children: List.generate(
                                ContactsUtil.formatContactList(
                                  core.state.incident.incident!.contactLog,
                                )!
                                    .length,
                                (i) => Padding(
                                  padding: EdgeInsets.only(
                                    right: i + 1 ==
                                            ContactsUtil.formatContactList(
                                              core.state.incident.incident!
                                                  .contactLog,
                                            )!
                                                .length
                                        ? 0
                                        : kEmergencyContactAvatarSpacing,
                                  ),
                                  child: MutableEmergencyContactAvatar(
                                    ContactsUtil.formatContactList(core.state
                                        .incident.incident!.contactLog)![i],
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 46),
            MutablePlayButton(
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
