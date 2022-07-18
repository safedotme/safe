import 'package:safe/models/incident/address.model.dart';
import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/device_info.model.dart';
import 'package:safe/models/incident/emergency_services.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contacts.model.dart';
import 'package:safe/models/incident/shard.model.dart';

enum IncidentType {
  trafficStop,
  shooting,
  kidnapping,
  general,
}

class Incident {
  final String id;
  final String userId;
  final String name;
  final IncidentType type;
  final DateTime datetime;
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
    this.emergencyServices,
  });

  factory Incident.fromJson(Map<String, dynamic> json) => Incident(
        id: id,
        userId: userId,
        name: name,
        type: type,
        datetime: datetime,
        location: location,
        notifiedContacts: notifiedContacts,
        battery: battery,
        shards: shards,
        deviceInfo: deviceInfo,
      );
}
