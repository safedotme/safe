class AdminSettings {
  final int incidentCap;
  final int dimensionWidth;
  final int dimensionHeight;
  final int frameRate;
  final String id;

  AdminSettings({
    required this.incidentCap,
    required this.dimensionHeight,
    required this.dimensionWidth,
    required this.frameRate,
    required this.id,
  });

  // In the case that settings do not load from firebase, these will be set
  static final AdminSettings defaultSettings = AdminSettings(
    incidentCap: 2,
    dimensionHeight: 720,
    dimensionWidth: 1280,
    frameRate: 15,
    id: "prod",
  );

  factory AdminSettings.fromJson(Map<String, dynamic> json) {
    return AdminSettings(
      incidentCap: json["incident_cap"] ?? defaultSettings.incidentCap,
      dimensionHeight:
          json["dimension_height"] ?? defaultSettings.dimensionHeight,
      dimensionWidth: json["dimension_width"] ?? defaultSettings.dimensionWidth,
      frameRate: json["frame_rate"] ?? defaultSettings.frameRate,
      id: json["id"] ?? defaultSettings.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "incident_cap": incidentCap,
      "dimension_height": dimensionHeight,
      "dimension_width": dimensionWidth,
      "frame_rate": frameRate,
      "id": id,
    };
  }
}
