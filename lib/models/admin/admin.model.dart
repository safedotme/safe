class AdminSettings {
  final int defaultIncidentCap;
  final int dimensionWidth;
  final int dimensionHeight;
  final int frameRate;
  final int defaultContactCap;
  final String id;
  final bool callContacts;
  final int maxIdleTime;

  AdminSettings({
    required this.defaultIncidentCap,
    required this.dimensionHeight,
    required this.dimensionWidth,
    required this.frameRate,
    required this.defaultContactCap,
    required this.callContacts,
    required this.id,
    required this.maxIdleTime,
  });

  // In the case that settings do not load from firebase, these will be set
  static final AdminSettings defaultSettings = AdminSettings(
    defaultIncidentCap: 2,
    dimensionHeight: 720,
    callContacts: false,
    defaultContactCap: 3,
    dimensionWidth: 1280,
    frameRate: 24,
    maxIdleTime: 3600,
    id: "prod",
  );

  factory AdminSettings.fromJson(Map<String, dynamic>? json) {
    return json == null
        ? defaultSettings
        : AdminSettings(
            defaultContactCap: json["default_contact_cap"] ??
                defaultSettings.defaultContactCap,
            defaultIncidentCap: json["default_incident_cap"] ??
                defaultSettings.defaultIncidentCap,
            maxIdleTime: json["max_idle_time"] ?? defaultSettings.maxIdleTime,
            callContacts: json["call_contacts"] ?? defaultSettings.maxIdleTime,
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
      "max_idle_time": maxIdleTime,
      "call_contacts": callContacts,
      "default_contact_cap": defaultContactCap,
      "dimension_width": dimensionWidth,
      "frame_rate": frameRate,
      "id": id,
    };
  }
}
