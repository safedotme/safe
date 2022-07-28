// UPDATE BEFORE LAUNCH
final Uri kRequestCountryUrl = Uri.parse("https://joinsafe.me");

const List<String> kBuckets = [
  "gs://safe-f73bf-2iwra",
  "gs://safe-f73bf-2iymj",
  "gs://safe-f73bf-6rjlm",
  "gs://safe-f73bf-he25n",
  "gs://safe-f73bf-yomzj",
];

const String kThumbnailBucketPath = "gs://safe-thumbnails";

const String kContactMessageTemplate = """
{FULL_NAME} is actively in an emergency. {NAME} listed you, {FULL_CONTACT_NAME}, as an emergency contacts.

The emergency began at {TIME} EST and is listed as a {TYPE}.

His last recorded location is {ADDRESS} ({LAT}° N, {LONG}° W).

Watch a livestream of the incident from {NAME_POSESSIVE} phone: {LINK}

This message was sent by Safe; an app that___. The app continues to record his camera and track {NAME_POSESSIVE} exact location.

You will recieve a message when {NAME} stops capturing the incident.
""";
