import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage? _client;

  void init() {
    _client = FirebaseStorage.instance;
  }

  Future<Map<String, dynamic>> getDownloadUrl(String path) async {
    assert(_client != null, "Storage client has not been initialized");
    String? url;
    String? msg;

    try {
      var ref = _client!.ref(path);

      url = await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      msg = e.toString();
    }

    return {
      "url": url,
      "error": msg,
    };
  }
}
