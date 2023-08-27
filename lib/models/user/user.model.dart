// ignore_for_file: no_leading_underscores_for_local_identifiers

class User {
  final String id;
  final String name;
  final String? picturePath;
  final String phone;
  final DateTime joined;
  final int credits;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.picturePath,
    required this.joined,
    required this.credits,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      credits: json["credits"],
      name: json["name"],
      picturePath: json["picture_path"],
      phone: json["phone"],
      joined: DateTime.parse(json["joined"]),
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? picturePath,
    String? phone,
    DateTime? joined,
    int? credits,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      picturePath: this.picturePath,
      joined: joined ?? this.joined,
      credits: credits ?? this.credits,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "picture_path": picturePath,
        "phone": phone,
        "credits": credits,
        "joined": joined.toIso8601String(),
      };
}
