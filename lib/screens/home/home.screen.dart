import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/device_info.model.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contacts.model.dart';
import 'package:safe/screens/incident_log/incident_log.screen.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/incident/incident.util.dart';
import 'package:safe/widgets/mutable_safe_button/mutable_safe_button.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";

  void populate(Core core) {
    var incident = Incident(
      id: Uuid().v1(),
      userId: core.services.auth.currentUser!.uid,
      name: "Incident #1",
      type: [IncidentType.general],
      datetime: DateTime.now(),
      location: [
        Location(
          lat: 1038.29,
          long: 92372.9828,
          alt: 18,
          datetime: DateTime.now(),
          address: "One Apple Park Way, Cupertino, CA 95014, United States",
        ),
      ],
      notifiedContacts: [
        NotifiedContact(
          id: Uuid().v1(),
          name: "Kelly Wakasa",
          phone: "+506 71099519",
          messageSent: "",
          datetime: DateTime.now(),
        ),
        NotifiedContact(
          id: Uuid().v1(),
          name: "Filippo Fonseca",
          phone: "+506 71099519",
          messageSent: "",
          datetime: DateTime.now(),
        ),
        NotifiedContact(
          id: Uuid().v1(),
          name: "Ashley Alexander",
          phone: "+506 71099519",
          messageSent: "",
          datetime: DateTime.now(),
        ),
        NotifiedContact(
          id: Uuid().v1(),
          name: "Chris Music",
          phone: "+506 71099519",
          messageSent: "",
          datetime: DateTime.now(),
        ),
      ], // ADD
      battery: [],
      shards: [],
      deviceInfo: DeviceInfo(
        datetime: DateTime.now(),
        modelNumber: "jkdshfufjhlafiuasdhfusdiuf2398",
      ),
      thumbnail:
          "https://d279m997dpfwgl.cloudfront.net/wp/2020/06/GettyImages-1221138690.jpg",
    );

    core.services.server.incidents.upsert(incident);
  }

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return MutableScaffold(
      underlays: [
        Padding(
          padding: EdgeInsets.only(
              bottom: (kIncidentLogMinPopupHeight + kSafeButtonSize) +
                  (kHomeHeaderToButtonMargin * 2) -
                  40),
          child: Center(
            child: MutableText(
              core.utils.language
                  .langMap[core.state.preferences.language]!["home"]["header"],
              style: TypeStyle.h2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: kIncidentLogMinPopupHeight - 40),
          child: Center(
            child: MutableSafeButton(
              onTap: () {
                populate(core);
              },
            ),
          ),
        ),
      ],
      body: IncidentLog(),
    );
  }
}
