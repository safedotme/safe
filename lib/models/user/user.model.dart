import 'package:safe/models/device_info.model.dart';

class User {
  final String id;
  final String name;
  final String picturePath;
  final List<String> contacts;
  final List<String> incidents;
  final String phone;
  final DateTime joined;
  final List<DeviceInfo> devices;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.picturePath,
    required this.contacts,
    required this.incidents,
    required this.joined,
    required this.devices,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        picturePath: json["picture_path"],
        contacts: json["contacts"],
        incidents: json["incidents"],
        phone: json["phone"],
        joined: DateTime.parse(json["joined"]),
        devices: json["devices"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "picture_path": picturePath,
        "contacts": contacts,
        "incidents": incidents,
        "phone": phone,
        "joined": joined.toIso8601String(),
        "devices": devices,
      };
}
