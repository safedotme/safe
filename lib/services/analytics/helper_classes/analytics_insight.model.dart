class AnalyticsInsight {
  final String _project = "safe";
  final String title;
  final dynamic value;
  final String icon;

  AnalyticsInsight({
    required this.title,
    required this.value,
    required this.icon,
  });

  Map<String, dynamic> toMap() {
    return {
      "project": _project,
      "title": title,
      "value": value,
      "icon": icon,
    };
  }
}
