import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
{FULL_NAME} is actively in an emergency. {NAME} listed you, {FULL_CONTACT_NAME}, as an emergency contacts.

The emergency began at {TIME} and is listed as a {TYPE}.

{NAME_POSESSIVE} last recorded location was {ADDRESS} ({LAT}° N, {LONG}° W).

Watch a livestream of the incident: {LINK}

The app continues to record {NAME} camera and track {NAME_POSESSIVE} exact location. You will recieve a message when {NAME} stops capturing the incident.

This message was sent by Safe; an app that___.
""";

  static const String contactMessageTemplateEnd = """
{NAME} has stopped capturing the incident at {TIME_END}.

The emergency began at {TIME} and is listed as a {TYPE}.

{NAME_POSESSIVE} last recorded location was {ADDRESS} ({LAT}° N, {LONG}° W).

This message was sent by Safe; an app that___.
""";

  static const String contactMessageBatteryTemplate = """
{NAME_POSESSIVE} battery is at {BATTERY}%, which is dangerously low. When it runs out, the app will stop capturing the incident.

The app continues to record {NAME} camera and track {NAME_POSESSIVE} exact location.

You will recieve a message when {NAME} stops capturing the incident.

This message was sent by Safe; an app that___.
""";
}
