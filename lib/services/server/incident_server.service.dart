import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/incident/incident.model.dart';

class IncidentServer {
  final FirebaseFirestore _db;
  static String path = "incidents";

  IncidentServer(this._db);

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

  Stream<Incident> readFromId({required String id}) {
    return _db.collection(path).doc(id).snapshots().map(
          (doc) => Incident.fromJson(doc.data()!),
        );
  }

  // -> UPSERT
  Future<void> upsert(Incident incident, {bool shouldMerge = true}) {
    var options = SetOptions(merge: shouldMerge);

    return _db.collection(path).doc(incident.id).set(incident.toMap(), options);
  }

  // -> DELETE
  Future<void> delete(String id) => _db.collection(path).doc(id).delete();
}
