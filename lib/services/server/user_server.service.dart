import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/user/user.model.dart';

class UserServer {
  final FirebaseFirestore _db;
  static String path = "users";

  UserServer(this._db);

  // -> READ
  Stream<User> readFromId({required String id}) {
    return _db.collection(path).doc(id).snapshots().map(
          (doc) => User.fromJson(doc.data()!), // Handle null value
        );
  }

  // -> UPSERT
  Future<void> upsert(User user) {
    var options = SetOptions(merge: true);

    return _db.collection(path).doc(user.id).set(user.toMap(), options);
  }

  // -> DELETE
  Future<void> delete(String id) => _db.collection(path).doc(id).delete();
}
