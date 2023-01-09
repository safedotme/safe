class Stream {
  final int recordingId;
  final int userId;
  final String? resourceId;
  final String? sid;
  final List<String>? rawFilepath;
  final String channelName;

  Stream({
    required this.recordingId,
    required this.userId,
    required this.channelName,
    this.resourceId,
    this.sid,
    this.rawFilepath,
  });

  factory Stream.fromJson(Map json) {
    List<String>? raw = json["raw_filepath"] == null
        ? null
        : (json["raw_filepath"] as List).map((e) => e.toString()).toList();

    return Stream(
      userId: json["user_id"],
      channelName: json["channel_name"],
      recordingId: json["recording_id"],
      resourceId: json["resource_id"],
      sid: json["sid"],
      rawFilepath: raw,
    );
  }

  Stream copyWith({
    int? recordingId,
    int? userId,
    String? resourceId,
    String? sid,
    String? channelName,
    List<String>? rawFilepath,
  }) {
    return Stream(
      channelName: channelName ?? this.channelName,
      recordingId: recordingId ?? this.recordingId,
      userId: userId ?? this.userId,
      resourceId: resourceId ?? this.resourceId,
      sid: sid ?? this.sid,
      rawFilepath: rawFilepath ?? this.rawFilepath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "user_id": userId,
      "recording_id": recordingId,
      "resource_id": resourceId,
      "sid": sid,
      "channel_name": channelName,
      "raw_filepath": rawFilepath,
    };
  }
}
