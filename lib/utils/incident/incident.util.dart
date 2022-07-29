enum IncidentType {
  trafficStop,
  shooting,
  kidnapping,
  general,
}

class IncidentUtil {
  Map<IncidentType, String> incidentTypeMap = {
    IncidentType.general: "general emergency",
    IncidentType.kidnapping: "kidnapping",
    IncidentType.shooting: "shooting",
    IncidentType.trafficStop: "traffic stop",
  };

  String? generateType(IncidentType type) {
    for (IncidentType t in incidentTypeMap.keys) {
      if (type == t) {
        return incidentTypeMap[t]!;
      }
    }
  }

  /// [parseType] expects a String formatted as "IncidentType..."
  static IncidentType parseType(String type) {
    String gen = "";
    bool record = false;

    for (int i = 0; i < type.length; i++) {
      if (record) {
        gen += type[i];
      }

      if (type[i] == ".") {
        record = true;
      }
    }

    switch (gen) {
      case "trafficStop":
        return IncidentType.trafficStop;
      case "shooting":
        return IncidentType.shooting;
      case "kidnapping":
        return IncidentType.kidnapping;
      case "general":
        return IncidentType.general;
      default:
        return IncidentType.general;
    }
  }
}
