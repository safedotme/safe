import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';

enum MessageType {
  start,
  batteryCrit,
  end,
}

class EmergencyMessages {
  static const Map<MessageType, String> messageMap = {
    MessageType.start: contactMessageTemplateStart,
    MessageType.batteryCrit: contactMessageBatteryTemplate,
    MessageType.end: contactMessageTemplateEnd,
  };

  static String addLocation(String base, Location? l) {
    String key = "{LOCATION}";

    if (!base.contains(key)) return base;

    bool shouldAddLocation = true;

    if (l == null) shouldAddLocation = false;

    if (l!.lat == null || l.long == null) shouldAddLocation = false;

    if (l.address == null) shouldAddLocation = false;

    String lString = "";

    String lats = l.lat!.isNegative ? "S" : "N";
    String longs = l.long!.isNegative ? "W" : "E";

    if (shouldAddLocation) {
      lString =
          "\n{NAME_POSESSIVE} last recorded location was {ADDRESS} ({LAT} {LAT_S}, {LONG} {LONG_S}).\n"
              .replaceAll("{LAT_S}", lats)
              .replaceAll("{LONG_S}", longs);
    }

    return base.replaceAll(key, lString);
  }

  static MessageType parseType(String type) {
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
      case "start":
        return MessageType.start;
      case "batteryCrit":
        return MessageType.batteryCrit;
      case "end":
        return MessageType.end;
      default:
        return MessageType.start;
    }
  }

  static const String contactMessageTemplateStart = """
{FULL_NAME} is actively in an emergency.

{NAME} listed you, {FULL_CONTACT_NAME}, as an emergency contacts.

The emergency began at {TIME} and is listed as a {TYPE}.
{LOCATION}
Watch a livestream of the incident: {LINK}

The app continues to record {NAME} camera and track {NAME_POSESSIVE} exact location. You will recieve a message when {NAME} stops capturing the incident.

This message was sent by the Safe app. Learn more about Safe at https://joinsafe.me.
""";

  static const String contactMessageTemplateEnd = """
{NAME} has stopped capturing the incident at {TIME_END}.

The emergency began at {TIME} and is listed as a {TYPE}.
{LOCATION}
This message was sent by the Safe app. Learn more about Safe at https://joinsafe.me.
""";

  static const String contactMessageBatteryTemplate = """
{NAME_POSESSIVE} battery is at {BATTERY}%, which is dangerously low.

When it runs out, the app will stop capturing the incident.

The app continues to record {NAME} camera and track {NAME_POSESSIVE} exact location.

You will recieve a message when {NAME} stops capturing the incident.

This message was sent by the Safe app. Learn more about Safe at https://joinsafe.me.
""";
}
