import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:safe/models/incident/shard.model.dart';
import 'package:safe/neuances.dart';

class ShardStorageService {
  FirebaseStorage? _instance;

  final List<String> _buckets = kBuckets;

  bool get isInitialized => _instance != null;

  String? get bucket => _instance?.bucket;

  /// Used to set an explicit bucket
  void setBucket(String id) =>
      _instance = FirebaseStorage.instanceFor(bucket: id);

  /// Chooses a bucket based on previous bucket distribution
  void setDistributedBucket(List<String> usedBuckets) {
    late bool isDistributed;

    // Generates distribution
    var distribution = _generateDistribution(
      usedBuckets,
      _buckets,
    );

    // Checks for even distribution
    isDistributed = _checkDistribution(distribution);

    if (isDistributed) {
      var rnd = Random().nextInt(_buckets.length);
      setBucket(_buckets[rnd]);

      return;
    }

    int? smallest;

    for (String key in distribution.keys) {
      smallest ??= distribution[key]!;

      if (smallest > distribution[key]!) {
        smallest = distribution[key]!;
      }
    }

    // Select smallest key
    var bucket = distribution.keys.firstWhere(
      (k) => distribution[k] == smallest,
    );

    setBucket(bucket);
  }

  bool _checkDistribution(Map<String, int> chart) {
    int sum = 0;
    int? product;

    for (String key in chart.keys) {
      product ??= chart[key]! * chart.length;
      sum = chart[key]! + sum;
    }

    return (sum / product!) == 1;
  }

  Map<String, int> _generateDistribution(
    List<String> base,
    List<String> checkAgainst,
  ) {
    Map<String, int> distributionChart = {};

    for (String c in checkAgainst) {
      distributionChart[c] = 0;
    }

    for (String b in base) {
      distributionChart[b] = distributionChart[b]! + 1;
    }

    return distributionChart;
  }

  /// Uploads shard video and returns new shard content
  Future<Shard?> uploadShardContent(Shard shard, String path) async {
    assert(
      _instance != null,
      "Firebase Storage instance has not been initialized",
    );

    var file = File(path);
    bool exists = await file.exists();

    if (!exists) {
      print("Path does not exist");
      return null;
    }

    Reference ref = _instance!.ref().child(shard.id);
    TaskSnapshot uploadedFile = await ref.putFile(file);

    String? url;
    if (uploadedFile.state == TaskState.success) {
      url = await ref.getDownloadURL();
    }

    return shard.copyWith(
      bucketId: _instance!.bucket,
      bytes: uploadedFile.totalBytes,
      uploadDatetime: DateTime.now(),
      localPath: file.path,
      cloudPath: url,
    );
  }

  void fetch(String path) {}
}
