import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/services/server/incident_server.service.dart';

class ServerService {
  late IncidentServer incidents;

  void init() {
    FirebaseFirestore _db = FirebaseFirestore.instance;

    incidents = IncidentServer(_db);
  }
}
