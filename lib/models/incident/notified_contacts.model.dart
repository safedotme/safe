class NotifiedContact {
  final String contactId;
  final String messageSent;
  final DateTime datetime;

  NotifiedContact({
    required this.contactId,
    required this.messageSent,
    required this.datetime,
  });

  factory NotifiedContact.fromJson(Map<String, dynamic> json) =>
      NotifiedContact(
        contactId: json["contact_id"],
        messageSent: json["message_sent"],
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toMap() => {
        "contact_id": contactId,
        "message_sent": messageSent,
        "datetime": datetime.toIso8601String(),
      };
}
