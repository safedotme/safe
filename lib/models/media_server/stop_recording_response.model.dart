class StopRecordingResponse {
  final String resourceId;
  final String sid;
  final List<String>? files;
  final bool uploadingStatus;

  StopRecordingResponse({
    required this.resourceId,
    required this.files,
    required this.sid,
    required this.uploadingStatus,
  });

  factory StopRecordingResponse.fromJson(Map json) {
    List<String>? raw = json["files"] == null
        ? null
        : (json["files"] as List).map((e) => e.toString()).toList();

    return StopRecordingResponse(
      resourceId: json["resource_id"],
      sid: json["sid"],
      files: raw,
      uploadingStatus: json["uploading_status"],
    );
  }
}
