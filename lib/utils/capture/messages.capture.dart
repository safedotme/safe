import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contact.model.dart';

class EmergencyMessages {
  static const Map<MessageType, String> messageMap = {
    MessageType.start: contactMessageTemplateStart,
    MessageType.batteryCrit: contactMessageBatteryTemplate,
    MessageType.end: contactMessageTemplateEnd,
    MessageType.voice: contactPhoneTemplateStart,
  };

  static String addLocation(String base, Location? l) {
    String key = "{LOCATION}";
    String sayKey = "{LOCATION_SAY}";
    bool say = false;

    if (base.contains(sayKey)) {
      say = true;
      key = sayKey;
    } else if (base.contains(key)) {
      say = false;
    } else {
      return base.replaceAll(key, "");
    }

    bool shouldAddLocation = true;

    if (l == null) shouldAddLocation = false;

    if (l!.lat == null || l.long == null) shouldAddLocation = false;

    if (l.address == null) shouldAddLocation = false;

    String lString = "";

    String lats = l.lat!.isNegative ? "S" : "N";
    String longs = l.long!.isNegative ? "W" : "E";

    if (shouldAddLocation) {
      lString =
          "\n{NAME_POSESSIVE} last recorded location was {ADDRESS} {COORDINATES}.\n";

      lString = say
          ? lString.replaceAll("{COORDINATES}", "")
          : lString
              .replaceAll("{COORDINATES}", "({LAT} {LAT_S}, {LONG} {LONG_S})")
              .replaceAll("{LAT_S}", lats)
              .replaceAll("{LONG_S}", longs);
    }

    return base.replaceAll(key, lString);
  }

  static const String contactPhoneTemplateStart = """
{FULL_NAME} is actively in an emergency.

{NAME} listed you, {FULL_CONTACT_NAME}, as an emergency contact.

The emergency began at {TIME} and is listed as a {TYPE}.

{LOCATION_SAY}

You have been sent an SMS message with more information. Watch a livestream of the incident by opening the SMS message.

The app continues to record {NAME_POSESSIVE} camera and track {NAME_POSESSIVE} exact location. You will receive a message when {NAME} stops capturing the incident.

This message was sent by the Safe app. Learn more about Safe at joinsafe dot me.

This message will now be repeated.

{FULL_NAME} is actively in an emergency.

{NAME} listed you, {FULL_CONTACT_NAME}, as an emergency contact.

The emergency began at {TIME} and is listed as a {TYPE}.

{LOCATION_SAY}

You have been sent an SMS message with more information. Watch a livestream of the incident by opening the SMS message.

The app continues to record {NAME_POSESSIVE} camera and track {NAME_POSESSIVE} exact location. You will receive a message when {NAME} stops capturing the incident.

This message was sent by the Safe app. Learn more about Safe at joinsafe dot me.
""";

  static const String contactMessageTemplateStart = """
{FULL_NAME} is actively in an emergency.

{NAME} listed you, {FULL_CONTACT_NAME}, as an emergency contact.

The emergency began at {TIME} and is listed as a {TYPE}.
{LOCATION}
Watch a video livestream of the incident along with {NAME_POSESSIVE} real-time location and battery life by opening the following link: {LINK}

The app continues to record {NAME_POSESSIVE} camera and track {NAME_POSESSIVE} exact location. You will receive a message when {NAME} stops capturing the incident.

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

The app continues to record {NAME_POSESSIVE} camera and track {NAME_POSESSIVE} exact location.

You will receive a message when {NAME} stops capturing the incident.

This message was sent by the Safe app. Learn more about Safe at https://joinsafe.me.
""";
}
