class Contact {
  final String id;
  final String userId;
  final String name;
  final String phone;

  Contact({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
      };
}
