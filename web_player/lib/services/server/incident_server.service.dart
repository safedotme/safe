import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/incident/incident.model.dart';

class IncidentServer {
  final FirebaseFirestore _db;
  static String path = "incidents";

  IncidentServer(this._db);

  // -> READ
  Stream<Incident> read(String id) {
    return _db.collection(path).doc(id).snapshots().map(
          (doc) => Incident.fromJson(
            doc.data()!,
          ),
        );
  }
}
