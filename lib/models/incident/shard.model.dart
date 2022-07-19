class Shard {
  final String bucketId;
  final double bytes;
  final DateTime uploadDatetime;
  final String shardId;
  final int position;
  final String path;
  final DateTime datetime;

  Shard({
    required this.bucketId,
    required this.bytes,
    required this.uploadDatetime,
    required this.shardId,
    required this.position,
    required this.path,
    required this.datetime,
  });

  factory Shard.fromJson(Map<String, dynamic> json) => Shard(
        bucketId: json["bucket_id"],
        bytes: json["bytes"].toDouble(),
        uploadDatetime: DateTime.parse(json["upload_datetime"]),
        shardId: json["shard_id"],
        position: json["position"],
        path: json["path"],
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toMap() => {
        "bucket_id": bucketId,
        "bytes": bytes,
        "upload_datetime": datetime.toIso8601String(),
        "shard_id": shardId,
        "position": position,
        "path": path,
        "datetime": datetime.toIso8601String(),
      };
}
