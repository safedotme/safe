class Stream {
  final int recordingId;
  final int userId;
  final String? resourceId;
  final String? sid;
  final String? filePath;

  Stream({
    required this.recordingId,
    required this.userId,
    this.resourceId,
    this.sid,
    this.filePath,
  });

  factory Stream.fromJson(Map json) {
    return Stream(
      userId: json["user_id"],
      recordingId: json["recording_id"],
      resourceId: json["resource_id"],
      sid: json["sid"],
      filePath: json["file_path"],
    );
  }

  Stream copyWith({
    int? recordingId,
    int? userId,
    String? resourceId,
    String? sid,
    String? filePath,
  }) {
    return Stream(
      recordingId: recordingId ?? this.recordingId,
      userId: userId ?? this.userId,
      resourceId: resourceId ?? this.resourceId,
      sid: sid ?? this.sid,
      filePath: filePath ?? this.filePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "user_id": userId,
      "recording_id": recordingId,
      "resource_id": resourceId,
      "sid": sid,
      "file_path": filePath,
    };
  }
}
