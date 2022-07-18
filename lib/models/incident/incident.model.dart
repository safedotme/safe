// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/device_info.model.dart';
import 'package:safe/models/incident/emergency_services.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contacts.model.dart';
import 'package:safe/models/incident/shard.model.dart';
import 'package:safe/utils/incident/incident.util.dart';

class Incident {
  final String id;
  final String userId;
  final String name;
  final IncidentType type;
  final DateTime datetime;
  final String thumbnail;
  final List<Location> location;
  final List<NotifiedContact> notifiedContacts;
  final List<Battery> battery;
  final List<Shard> shards;
  final List<EmergencyServices>? emergencyServices;
  final DeviceInfo deviceInfo;

  Incident({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.datetime,
    required this.location,
    required this.notifiedContacts,
    required this.battery,
    required this.shards,
    required this.deviceInfo,
    required this.thumbnail,
    this.emergencyServices,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> _location = json["location"];
    List<Map<String, dynamic>> _contacts = json["notified_contacts"];
    List<Map<String, dynamic>> _battery = json["battery"];
    List<Map<String, dynamic>> _shards = json["shards"];

    return Incident(
      id: json["id"],
      userId: json['user_id'],
      name: json["name"],
      type: IncidentUtil.parseType(json["type"]),
      datetime: DateTime.parse(json["datetime"]),
      location: _location.map((e) => Location.fromJson(e)).toList(),
      notifiedContacts:
          _contacts.map((e) => NotifiedContact.fromJson(e)).toList(),
      battery: _battery.map((e) => Battery.fromJson(e)).toList(),
      thumbnail: json["thumbnail"],
      shards: _shards.map((e) => Shard.fromJson(e)).toList(),
      deviceInfo: DeviceInfo.fromJson(json["device_info"]),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "type": type.toString(),
        "datetime": datetime.toIso8601String(),
        "location": location.map((e) => e.toMap()).toList(),
        "notified_contacts": notifiedContacts.map((e) => e.toMap()).toList(),
        "battery": battery.map((e) => e.toMap()).toList(),
        "thumbnail": thumbnail,
        "shards": shards.map((e) => e.toMap()).toList(),
        "device_info": deviceInfo.toMap(),
      };
}
