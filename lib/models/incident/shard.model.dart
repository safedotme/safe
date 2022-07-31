// ignore_for_file: prefer_null_aware_operators

class Shard {
  final String? bucketId;
  final int? bytes;
  final DateTime? uploadDatetime;
  final String id;
  final int position;
  final String? cloudPath;
  final String localPath;
  final DateTime datetime;

  Shard({
    this.bucketId,
    this.bytes,
    this.uploadDatetime,
    required this.id,
    required this.position,
    this.cloudPath,
    required this.localPath,
    required this.datetime,
  });

  factory Shard.fromJson(Map<String, dynamic> json) => Shard(
        bucketId: json["bucket_id"],
        bytes: json["bytes"]?.toInt(),
        uploadDatetime: DateTime.parse(json["upload_datetime"]),
        id: json["id"],
        position: json["position"],
        localPath: json["local_path"],
        cloudPath: json["cloud_path"],
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toMap() => {
        "bucket_id": bucketId,
        "bytes": bytes,
        "upload_datetime": datetime.toIso8601String(),
        "id": id,
        "position": position,
        "local_path": localPath,
        "cloud_path": cloudPath,
        "datetime": datetime.toIso8601String(),
      };

  Shard copyWith({
    String? bucketId,
    int? bytes,
    DateTime? uploadDatetime,
    String? id,
    int? position,
    String? cloudPath,
    String? localPath,
    DateTime? datetime,
  }) {
    return Shard(
      bucketId: bucketId ?? this.bucketId,
      bytes: bytes ?? this.bytes,
      uploadDatetime: uploadDatetime ?? this.uploadDatetime,
      id: id ?? this.id,
      position: position ?? this.position,
      cloudPath: cloudPath ?? this.cloudPath,
      localPath: localPath ?? this.localPath,
      datetime: datetime ?? this.datetime,
    );
  }
}
