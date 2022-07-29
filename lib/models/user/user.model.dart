// ignore_for_file: no_leading_underscores_for_local_identifiers

class User {
  final String id;
  final String name;
  final String? picturePath;
  final String phone;
  final DateTime joined;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.picturePath,
    required this.joined,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      picturePath: json["picture_path"],
      phone: json["phone"],
      joined: DateTime.parse(json["joined"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "picture_path": picturePath,
        "phone": phone,
        "joined": joined.toIso8601String(),
      };
}
