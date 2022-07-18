import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/incident/incident.model.dart';

class IncidentServer {
  final FirebaseFirestore _db;
  static String path = "incidents";

  IncidentServer(this._db);
  // INCIDENTS

  // -> READ
  Stream<List<Incident>> readFromUserId({required String userId}) {
    return _db
        .collection(path)
        .where("user_id", isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Incident.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  // -> UPSERT
  Future<void> upsert(Incident incident) {
    var options = SetOptions(merge: true);

    return _db.collection(path).doc(incident.id).set(incident.toMap(), options);
  }

  // -> DELETE
  Future<void> delete(String id) => _db.collection(path).doc(id).delete();
}
