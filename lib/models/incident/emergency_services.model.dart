import 'package:safe/utils/incident/incident.util.dart';

class EmergencyServices {
  final DateTime datetime;
  final IncidentType type;
  final String messsageSent;

  EmergencyServices({
    required this.datetime,
    required this.type,
    required this.messsageSent,
  });

  factory EmergencyServices.fromJson(Map<String, dynamic> json) =>
      EmergencyServices(
        datetime: DateTime.parse(json["datetime"]),
        type: IncidentUtil.parseType(json["type"]),
        messsageSent: json["message_sent"],
      );

  Map<String, dynamic> toMap() => {
        "datetime": datetime.toIso8601String(),
        "type": type.toString(),
        "message_sent": messsageSent,
      };
}
