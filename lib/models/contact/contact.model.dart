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

  Map<String, String> parsePhone() {
    int codeStop = phone.indexOf(" ");
    String c = "";
    String p = "";

    for (int i = 0; i < phone.length; i++) {
      if (i < codeStop) {
        c += phone[i];
      }

      if (i > codeStop) {
        p += phone[i];
      }
    }

    return {"code": c, "phone": p};
  }

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        phone: json["phone"],
      );

  Contact copyWith({
    String? id,
    String? name,
    String? phone,
    String? userId,
  }) {
    return Contact(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "phone": phone,
      };
}
