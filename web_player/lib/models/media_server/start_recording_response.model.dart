class StartRecordingResponse {
  final String resourceId;
  final String sid;

  StartRecordingResponse({required this.resourceId, required this.sid});

  factory StartRecordingResponse.fromJson(Map json) {
    return StartRecordingResponse(
      resourceId: json["resource_id"],
      sid: json["sid"],
    );
  }
}
