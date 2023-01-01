enum AnalyticsChannel {
  userRegister,
}

class AnalyticsLog {
  final String _project = "safe";
  final String _parser = "markdown";

  final AnalyticsChannel channel;
  final String event;
  final String description;
  final String icon;
  final bool notify;
  final List<Map<String, String>> tags;

  AnalyticsLog({
    required this.channel,
    required this.event,
    required this.description,
    required this.icon,
    this.notify = true,
    this.tags = const [],
  });

  static String parseChannel(AnalyticsChannel c) => c.toString().substring(
        17,
        c.toString().length,
      );

  Map<String, dynamic> toMap() {
    return {
      "project": _project,
      "parser": _parser,
      "channel": AnalyticsLog.parseChannel(channel),
      "event": event,
      "description": description,
      "icon": icon,
      "notify": notify,
      "tags": tags,
    };
  }
}
