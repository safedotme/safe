class DeviceInfo {
  final DateTime datetime;
  final String modelNumber;

  DeviceInfo({
    required this.datetime,
    required this.modelNumber,
  });

  factory DeviceInfo.toJson(Map<String, dynamic> json) => DeviceInfo(
        datetime: DateTime.parse(json["datetime"]),
        modelNumber: json["model_number"],
      );

  Map<String, dynamic> toMap() => {
        "datetime": datetime.toIso8601String(),
        "model_number": modelNumber,
      };
}
