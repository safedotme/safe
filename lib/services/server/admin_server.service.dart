import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/admin/admin.model.dart';
import 'package:safe/models/user/user.model.dart';

class UserServer {
  final FirebaseFirestore _db;
  static String path = "admin_settings";

  UserServer(this._db);

  // -> READ
  Stream<AdminSettings?> readLatest() {
    return _db.collection(path).doc("prod").snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return null;
      } else {
        return AdminSettings.fromJson(doc.data()!);
      }
    });
  }
}
