import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe/models/contact/contact.model.dart';

class ContactServer {
  final FirebaseFirestore _db;
  static String path = "contacts";

  ContactServer(this._db);

  // -> READ
  Stream<List<Contact>> readFromUserId({required String userId}) {
    return _db
        .collection(path)
        .where("user_id", isEqualTo: userId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Contact.fromJson(doc.data()),
              )
              .toList(),
        );
  }

  Future<List<Contact>> readFromUserIdOnce({required String id}) async {
    var map = await _db.collection(path).where("user_id", isEqualTo: id).get();

    return map.docs.map((json) => Contact.fromJson(json.data())).toList();
  }

  Stream<Contact> readFromId({required String id}) {
    return _db.collection(path).doc(id).snapshots().map(
          (doc) => Contact.fromJson(doc.data()!), // Handle null value
        );
  }

  // -> UPSERT
  Future<void> upsert(Contact contact) {
    var options = SetOptions(merge: true);

    return _db.collection(path).doc(contact.id).set(contact.toMap(), options);
  }

  // -> DELETE
  Future<void> delete(String id) => _db.collection(path).doc(id).delete();
}
