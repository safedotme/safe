import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage? _client;

  void init() {
    _client = FirebaseStorage.instance;
  }

  Future<String> getDownloadUrl(String path) async {
    assert(_client != null, "Storage client has not been initialized");

    var ref = _client!.ref(path);

    return ref.getDownloadURL();
  }
}
