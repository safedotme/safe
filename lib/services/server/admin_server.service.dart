import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/admin/admin.model.dart';

class AdminServer {
  final FirebaseFirestore _db;
  static String path = "admin_settings";

  AdminServer(this._db);

  // -> READ
  Future<AdminSettings> readLatest() async {
    var doc = await _db.collection(path).doc("prod").get();

    return AdminSettings.fromJson(doc.data());
  }
}
