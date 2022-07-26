import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:safe/neuances.dart';

class ThumbnailStorageService {
  final FirebaseStorage _instance = FirebaseStorage.instanceFor(
    bucket: kThumbnailBucketPath,
  );

  Future<String?> upload(String path, String incidentId) async {
    var task = _instance.ref().child(incidentId).putFile(File(path));
    String url = await task.snapshot.ref.getDownloadURL();
    return url;
  }
}
