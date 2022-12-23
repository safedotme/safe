class AdminSettings {
  final int defaultIncidentCap;
  final int dimensionWidth;
  final int dimensionHeight;
  final int frameRate;
  final String id;

  AdminSettings({
    required this.defaultIncidentCap,
    required this.dimensionHeight,
    required this.dimensionWidth,
    required this.frameRate,
    required this.id,
  });

  // In the case that settings do not load from firebase, these will be set
  static final AdminSettings defaultSettings = AdminSettings(
    defaultIncidentCap: 2,
    dimensionHeight: 720,
    dimensionWidth: 1280,
    frameRate: 15,
    id: "prod",
  );

  factory AdminSettings.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? defaultSettings
        : AdminSettings(
            defaultIncidentCap: json["default_incident_cap"] ??
                defaultSettings.defaultIncidentCap,
            dimensionHeight:
                json["dimension_height"] ?? defaultSettings.dimensionHeight,
            dimensionWidth:
                json["dimension_width"] ?? defaultSettings.dimensionWidth,
            frameRate: json["frame_rate"] ?? defaultSettings.frameRate,
            id: json["id"] ?? defaultSettings.id,
          );
  }

  Map<String, dynamic> toMap() {
    return {
      "default_incident_cap": defaultIncidentCap,
      "dimension_height": dimensionHeight,
      "dimension_width": dimensionWidth,
      "frame_rate": frameRate,
      "id": id,
    };
  }
}
