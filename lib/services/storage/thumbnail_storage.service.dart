import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:safe/neuances.dart';

class ThumbnailStorageService {
  final FirebaseStorage _instance = FirebaseStorage.instanceFor(
    bucket: kThumbnailBucketPath,
  );

  Future<String?> upload(String path, String incidentId) async {
    var file = File(path);
    bool exists = await file.exists();

    if (!exists) {
      print("Path does not exist");
      return null;
    }

    Reference ref = _instance.ref().child(incidentId);
    TaskSnapshot uploadedFile = await ref.putFile(file);

    String? url;
    if (uploadedFile.state == TaskState.success) {
      url = await ref.getDownloadURL();
    }

    return url;
  }
}
