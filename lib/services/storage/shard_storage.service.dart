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

  void fetch(String path) {}
}
