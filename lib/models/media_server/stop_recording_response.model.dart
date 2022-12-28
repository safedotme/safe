class StopRecordingResponse {
  final String resourceId;
  final String sid;
  final String uploadingStatus;
  final String fileName;
  final String sliceStartTime;

  StopRecordingResponse({
    required this.resourceId,
    required this.sid,
    required this.uploadingStatus,
    required this.fileName,
    required this.sliceStartTime,
  });

  factory StopRecordingResponse.fromJson(Map json) {
    return StopRecordingResponse(
      resourceId: json["resourceId"],
      sid: json["sid"],
      uploadingStatus: json["uploading_status"],
      fileName: json["filename"],
      sliceStartTime: json["slice_start_time"],
    );
  }
}
