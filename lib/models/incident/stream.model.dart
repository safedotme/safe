class Stream {
  final int recordingId;
  final int userId;
  final String? resourceId;
  final String? sid;
  final String? filePath;
  final String channelName;

  Stream({
    required this.recordingId,
    required this.userId,
    required this.channelName,
    this.resourceId,
    this.sid,
    this.filePath,
  });

  factory Stream.fromJson(Map json) {
    return Stream(
      userId: json["user_id"],
      channelName: json["channel_name"],
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
    String? channelName,
    String? filePath,
  }) {
    return Stream(
      channelName: channelName ?? this.channelName,
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
      "channel_name": channelName,
      "file_path": filePath,
    };
  }
}
