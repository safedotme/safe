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
  final List<Map>? rtcCandidates;
  final Map<String, dynamic>? rtcOffer;
  final DateTime datetime;
  final String? thumbnail;
  final List<Location>? location;
  final List<NotifiedContact>? notifiedContacts;
  final List<Battery>? battery;
  final List<Shard>? shards;
  final List<EmergencyServices>? emergencyServices;

  Incident({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.datetime,
    this.location,
    this.rtcCandidates,
    this.rtcOffer,
    this.notifiedContacts,
    this.battery,
    this.shards,
    this.thumbnail,
    this.emergencyServices,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>>? _location = json["location"] == null
        ? null
        : List<Map<String, dynamic>>.from(json["location"]);
    List<Map<String, dynamic>>? _contacts = json["notified_contacts"] == null
        ? null
        : List<Map<String, dynamic>>.from(json["notified_contacts"]);
    List<Map<String, dynamic>>? _battery = json["battery"] == null
        ? null
        : List<Map<String, dynamic>>.from(json["battery"]);
    List<Map<String, dynamic>>? _shards = json["shards"] == null
        ? null
        : List<Map<String, dynamic>>.from(json["shards"]);
    List<String> _type = List<String>.from(json["type"]);

    return Incident(
      id: json["id"],
      userId: json['user_id'],
      rtcOffer: json["rtc_offer"],
      rtcCandidates: json["rtc_candidates"],
      name: json["name"],
      type: _type.map((e) => IncidentUtil.parseType(e)).toList(),
      datetime: DateTime.parse(json["datetime"]),
      location: _location?.map((e) => Location.fromJson(e)).toList(),
      notifiedContacts:
          _contacts?.map((e) => NotifiedContact.fromJson(e)).toList(),
      battery: _battery?.map((e) => Battery.fromJson(e)).toList(),
      thumbnail: json["thumbnail"],
      shards: _shards?.map((e) => Shard.fromJson(e)).toList(),
    );
  }

  Incident copyWith({
    String? id,
    String? userId,
    String? name,
    List<IncidentType>? type,
    DateTime? datetime,
    String? thumbnail,
    Map<String, dynamic>? rtcOffer,
    List<Map>? rtcCandidates,
    List<Location>? location,
    List<NotifiedContact>? notifiedContacts,
    List<Battery>? battery,
    List<Shard>? shards,
    List<EmergencyServices>? emergencyServices,
  }) {
    return Incident(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      rtcOffer: rtcOffer ?? this.rtcOffer,
      rtcCandidates: rtcCandidates ?? this.rtcCandidates,
      name: name ?? this.name,
      type: type ?? this.type,
      thumbnail: thumbnail ?? this.thumbnail,
      datetime: datetime ?? this.datetime,
      location: location ?? this.location,
      notifiedContacts: notifiedContacts ?? this.notifiedContacts,
      battery: battery ?? this.battery,
      shards: shards ?? this.shards,
      emergencyServices: emergencyServices ?? this.emergencyServices,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "rtc_offer": rtcOffer,
        "rtc_candidates": rtcCandidates,
        "name": name,
        "type": type.map((e) => e.toString()).toList(),
        "datetime": datetime.toIso8601String(),
        "location":
            location != null ? location!.map((e) => e.toMap()).toList() : null,
        "notified_contacts": notifiedContacts != null
            ? notifiedContacts!.map((e) => e.toMap()).toList()
            : null,
        "battery":
            battery != null ? battery!.map((e) => e.toMap()).toList() : null,
        "thumbnail": thumbnail,
        "shards":
            shards != null ? shards!.map((e) => e.toMap()).toList() : null,
      };
}
