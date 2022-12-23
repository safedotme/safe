// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/emergency_services.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/utils/incident/incident.util.dart';

class Incident {
  final String id;
  final String userId;
  final String name;
  final List<IncidentType> type;
  final bool streamAvailable;
  final DateTime? stopTime;
  final DateTime datetime;
  final String? thumbnail;
  final List<Location>? location;
  final List<NotifiedContact>? contactLog;
  final List<Battery>? battery;
  final List<EmergencyServices>? emergencyServices;

  Incident({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.datetime,
    this.stopTime,
    this.streamAvailable = false,
    this.location,
    this.contactLog,
    this.battery,
    this.thumbnail,
    this.emergencyServices,
  });

  factory Incident.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>>? _location = json["location"] == null
        ? null
        : List<Map<String, dynamic>>.from(json["location"]);
    List<Map<String, dynamic>>? _contacts = json["contact_log"] == null
        ? null
        : List<Map<String, dynamic>>.from(json["contact_log"]);
    List<Map<String, dynamic>>? _battery = json["battery"] == null
        ? null
        : List<Map<String, dynamic>>.from(json["battery"]);
    List<String> _type = List<String>.from(json["type"]);

    return Incident(
      id: json["id"],
      userId: json['user_id'],
      name: json["name"],
      type: _type.map((e) => IncidentUtil.parseType(e)).toList(),
      datetime: DateTime.parse(json["datetime"]),
      location: _location?.map((e) => Location.fromJson(e)).toList(),
      contactLog: _contacts?.map((e) => NotifiedContact.fromJson(e)).toList(),
      battery: _battery?.map((e) => Battery.fromJson(e)).toList(),
      thumbnail: json["thumbnail"],
      stopTime:
          json["stop_time"] == null ? null : DateTime.parse(json["stop_time"]),
      streamAvailable: json["stream_available"],
    );
  }

  Incident copyWith({
    String? id,
    String? userId,
    String? name,
    List<IncidentType>? type,
    DateTime? datetime,
    String? thumbnail,
    bool? streamAvailable,
    List<Location>? location,
    List<NotifiedContact>? contactLog,
    List<Battery>? battery,
    DateTime? stopTime,
    List<EmergencyServices>? emergencyServices,
  }) {
    return Incident(
      id: id ?? this.id,
      streamAvailable: streamAvailable ?? this.streamAvailable,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      stopTime: stopTime ?? this.stopTime,
      thumbnail: thumbnail ?? this.thumbnail,
      datetime: datetime ?? this.datetime,
      location: location ?? this.location,
      contactLog: contactLog ?? this.contactLog,
      battery: battery ?? this.battery,
      emergencyServices: emergencyServices ?? this.emergencyServices,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "stream_available": streamAvailable,
        "stop_time": stopTime?.toIso8601String(),
        "type": type.map((e) => e.toString()).toList(),
        "datetime": datetime.toIso8601String(),
        "location":
            location != null ? location!.map((e) => e.toMap()).toList() : null,
        "contact_log": contactLog != null
            ? contactLog!.map((e) => e.toMap()).toList()
            : null,
        "battery":
            battery != null ? battery!.map((e) => e.toMap()).toList() : null,
        "thumbnail": thumbnail,
      };
}
