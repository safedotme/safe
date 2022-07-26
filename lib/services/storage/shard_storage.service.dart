import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';

class ShardStorageService {
  FirebaseStorage? _instance;

  final List<String> _buckets = [
    "gs://safe-f73bf-2iwra",
    "gs://safe-f73bf-2iymj",
    "gs://safe-f73bf-6rjlm",
    "gs://safe-f73bf-he25n",
    "gs://safe-f73bf-yomzj",
  ];

  bool get isInitialized => _instance != null;

  String? get bucket => _instance?.bucket;

  /// Will set a random bucket to [_instance]
  void setBucket() {
    var chosen = Random().nextInt(_buckets.length);

    _instance = FirebaseStorage.instanceFor(bucket: _buckets[chosen]);
  }

  void fetch(String path) {}
}
