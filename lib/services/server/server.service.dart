// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/services/server/contact_server.service.dart';
import 'package:safe/services/server/incident_server.service.dart';
import 'package:safe/services/server/user_server.service.dart';

class ServerService {
  late IncidentServer incidents;
  late UserServer user;
  late ContactServer contacts;

  void init() {
    final FirebaseFirestore _db = FirebaseFirestore.instance;

    incidents = IncidentServer(_db);
    user = UserServer(_db);
    contacts = ContactServer(_db);
  }
}
