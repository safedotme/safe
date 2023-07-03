import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/user/user.model.dart';

class UserServer {
  final FirebaseFirestore _db;
  static String path = "users";

  UserServer(this._db);

  // -> READ
  Stream<User?> readFromId({required String id}) {
    return _db.collection(path).doc(id).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) {
        return null;
      } else {
        return User.fromJson(doc.data()!);
      }
    });
  }

  Future<bool> userExists(String id) async {
    try {
      await readFromIdOnce(id: id);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> userExistsFromPhone(String phone) async {
    try {
      var map =
          await _db.collection(path).where("phone", isEqualTo: phone).get();

      return map.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<User?> readFromIdOnce({required String id}) async {
    var map = await _db.collection(path).doc(id).get();

    return map.exists ? User.fromJson(map.data()!) : null;
  }

  // -> UPSERT
  Future<void> upsert(User user) {
    var options = SetOptions(merge: true);

    return _db.collection(path).doc(user.id).set(user.toMap(), options);
  }

  // -> DELETE
  Future<void> delete(String id) => _db.collection(path).doc(id).delete();
}
