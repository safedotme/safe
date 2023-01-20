class AnalyticsLog {
  final String _project = "safe";
  final String _parser = "markdown";

  final String channel;
  final String event;
  final String description;
  final String icon;
  final bool notify;
  final Map<String, String> tags;

  AnalyticsLog({
    required this.channel,
    required this.event,
    required this.description,
    required this.icon,
    this.notify = true,
    this.tags = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      "project": _project,
      "parser": _parser,
      "channel": channel,
      "event": event,
      "description": description,
      "icon": icon,
      "notify": notify,
      "tags": tags,
    };
  }
}
