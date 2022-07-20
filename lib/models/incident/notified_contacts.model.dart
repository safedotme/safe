class NotifiedContact {
  final String id;
  final String name;
  final String phone;
  final String messageSent;
  final DateTime datetime;

  NotifiedContact({
    required this.id,
    required this.name,
    required this.phone,
    required this.messageSent,
    required this.datetime,
  });

  factory NotifiedContact.fromJson(Map<String, dynamic> json) =>
      NotifiedContact(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        messageSent: json["message_sent"],
        datetime: DateTime.parse(json["datetime"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "phone": phone,
        "message_sent": messageSent,
        "datetime": datetime.toIso8601String(),
      };
}
