// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/emergency_services.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contacts.model.dart';
import 'package:safe/models/incident/shard.model.dart';
import 'package:safe/utils/incident/incident.util.dart';

class Incident {
  final String id;
  final String userId;
  final String name;
  final List<IncidentType> type;
  final DateTime datetime;
  final String thumbnail;
  final List<Location> location;
  final List<NotifiedContact> notifiedContacts;
  final List<Battery> battery;
  final List<Shard> shards;
  final List<EmergencyServices>? emergencyServices;

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
    required this.thumbnail,
    this.emergencyServices,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    var _location = List<Map<String, dynamic>>.from(json["location"]);
    var _contacts = List<Map<String, dynamic>>.from(json["notified_contacts"]);
    var _battery = List<Map<String, dynamic>>.from(json["battery"]);
    var _shards = List<Map<String, dynamic>>.from(json["shards"]);
    var _type = List<String>.from(json["type"]);

    return Incident(
      id: json["id"],
      userId: json['user_id'],
      name: json["name"],
      type: _type.map((e) => IncidentUtil.parseType(e)).toList(),
      datetime: DateTime.parse(json["datetime"]),
      location: _location.map((e) => Location.fromJson(e)).toList(),
      notifiedContacts:
          _contacts.map((e) => NotifiedContact.fromJson(e)).toList(),
      battery: _battery.map((e) => Battery.fromJson(e)).toList(),
      thumbnail: json["thumbnail"],
      shards: _shards.map((e) => Shard.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "type": type.map((e) => e.toString()).toList(),
        "datetime": datetime.toIso8601String(),
        "location": location.map((e) => e.toMap()).toList(),
        "notified_contacts": notifiedContacts.map((e) => e.toMap()).toList(),
        "battery": battery.map((e) => e.toMap()).toList(),
        "thumbnail": thumbnail,
        "shards": shards.map((e) => e.toMap()).toList(),
      };
}
