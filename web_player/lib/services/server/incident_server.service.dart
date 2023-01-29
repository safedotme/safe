import 'package:cloud_firestore/cloud_firestore.dart';

class IncidentServer {
  final FirebaseFirestore _db;
  static String path = "incidents";

  IncidentServer(this._db);

  // -> READ
  void read(String pubId) async {
    final query = _db.collection(path).where("id", isEqualTo: pubId);

    try {
      final val = await query.get();
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
