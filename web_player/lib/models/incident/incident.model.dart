// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/stream.model.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/utils/incident/incident.util.dart';

enum MessageType {
  start,
  batteryCrit,
  voice,
  end,
}

class Incident {
  final String id;
  final String userId;
  final String name;
  final List<IncidentType> type;
  final Stream stream;
  final bool processedFootage;
  final bool isTutorial;
  final DateTime? stopTime;
  final DateTime datetime;
  final String? path;
  final String? thumbnail;
  final List<Location>? location;
  final List<NotifiedContact>? contactLog;
  final List<Battery>? battery;

  Incident({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.stream,
    required this.datetime,
    this.processedFootage = false,
    this.isTutorial = false,
    this.thumbnail,
    this.stopTime,
    this.location,
    this.contactLog,
    this.battery,
    this.path,
  });

  static MessageType parseType(String type) {
    String gen = "";
    bool record = false;

    for (int i = 0; i < type.length; i++) {
      if (record) {
        gen += type[i];
      }

      if (type[i] == ".") {
        record = true;
      }
    }

    switch (gen) {
      case "start":
        return MessageType.start;
      case "batteryCrit":
        return MessageType.batteryCrit;
      case "end":
        return MessageType.end;
      default:
        return MessageType.start;
    }
  }

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
      isTutorial: json["is_tutorial"],
      processedFootage: json["processed_footage"],
      stream: Stream.fromJson(json["stream"]),
      type: _type.map((e) => IncidentUtil.parseType(e)).toList(),
      datetime: DateTime.parse(json["datetime"]),
      location: _location?.map((e) => Location.fromJson(e)).toList(),
      contactLog: _contacts?.map((e) => NotifiedContact.fromJson(e)).toList(),
      battery: _battery?.map((e) => Battery.fromJson(e)).toList(),
      path: json["path"],
      thumbnail: json["thumbnail"],
      stopTime:
          json["stop_time"] == null ? null : DateTime.parse(json["stop_time"]),
    );
  }

  Incident copyWith({
    String? id,
    String? userId,
    String? name,
    List<IncidentType>? type,
    DateTime? datetime,
    String? path,
    bool? processedFootage,
    Stream? stream,
    String? thumbnail,
    List<Location>? location,
    List<NotifiedContact>? contactLog,
    List<Battery>? battery,
    bool? isTutorial,
    DateTime? stopTime,
  }) {
    return Incident(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      processedFootage: processedFootage ?? this.processedFootage,
      thumbnail: thumbnail ?? this.thumbnail,
      stream: stream ?? this.stream,
      stopTime: stopTime ?? this.stopTime,
      path: path ?? this.path,
      isTutorial: isTutorial ?? this.isTutorial,
      datetime: datetime ?? this.datetime,
      location: location ?? this.location,
      contactLog: contactLog ?? this.contactLog,
      battery: battery ?? this.battery,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "is_tutorial": isTutorial,
        "processed_footage": processedFootage,
        "thumbnail": thumbnail,
        "stop_time": stopTime?.toIso8601String(),
        "stream": stream.toMap(),
        "type": type.map((e) => e.toString()).toList(),
        "datetime": datetime.toIso8601String(),
        "location":
            location != null ? location!.map((e) => e.toMap()).toList() : null,
        "contact_log": contactLog != null
            ? contactLog!.map((e) => e.toMap()).toList()
            : null,
        "battery":
            battery != null ? battery!.map((e) => e.toMap()).toList() : null,
        "path": path,
      };
}
