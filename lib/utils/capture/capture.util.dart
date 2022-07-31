import 'dart:async';
import 'package:intl/intl.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/models/incident/battery.model.dart';
import 'package:battery_plus/battery_plus.dart' as api;
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contacts.model.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/neuances.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:uuid/uuid.dart';

class CaptureUtil {
  Core? _core;
  StreamSubscription<Location>? locationSubscription;
  Timer? batteryTimer;
  api.Battery? battery;

  void initialize(Core core) {
    _core = core;
  }

  void start() {
    assert(_core != null, "CaptureUtil must be initialized");

    // ⬇️ INCIDENT CREATE
    _uploadChanges(null);

    // ⬇️ LOCATION + SMS
    _locationListen();

    // ⬇️ BATTERY
    _batteryListen();

    // ⬇️ WEBRTC
    _initStream();
  }

  void stop() async {
    // Stops sharding -> Will complete ongoing systems
    _core!.utils.engine.stop();
    _core!.state.capture.overlayController.show();
    _core!.state.engine.setOnStop(true);
    // CALL STOP WHEN NECESSARY
    if (locationSubscription != null) {
      await locationSubscription!.cancel();
    }
  }

  // ⬇️ LOCATION

  Future<String?> _generateAddress(Location location) async {
    // Build better system for judging addresses based on whether one has been generated

    // Checks that received data is not null
    if (location.lat == null || location.long == null) {
      return null;
    }

    var response = await _core!.services.geocoder.fetchAddress(
      lat: location.lat!,
      long: location.long!,
    );

    if (response == null) {
      return null;
    }

    return response["results"][0]["formatted_address"];
  }

  // Initializes incident and sends primitives to backend
  Future<void> _uploadChanges(Incident? i) async {
    Incident? incident;
    // If incident does not exist, create it
    if (i == null) {
      // Generates incident number
      int incidentNumber = _core!.state.incidentLog.incidents == null
          ? 1
          : _core!.state.incidentLog.incidents!.length + 1;

      incident = Incident(
        id: Uuid().v1(),
        userId: _core!.services.auth.currentUser!.uid,
        name: "Incident #$incidentNumber",
        type: [_core!.state.capture.type],
        datetime: DateTime.now(),
      );
    }

    incident ??= i;

    _core!.state.capture.setIncident(incident!);
    return _core!.services.server.incidents.upsert(incident);
  }

  // Updates location as user moves
  void _locationListen() async {
    List<Location>? log;
    bool shouldUpsert = true;

    _core!.services.location.initilaize();
    locationSubscription =
        _core!.services.location.stream.listen((location) async {
      // Check if log is null | this will be the first time
      if (log == null) {
        _generateAddress(location).then((address) async {
          await _sendLocation([location.copyWith(address: address)]);

          // Notifies contact after address is generated and incident is complete
          _notifyContacts();
        });

        log = [];
        return;
      }

      log!.add(location);
      if (!shouldUpsert) {
        return;
      }

      shouldUpsert = false;
      await Future.delayed(kLocationStreamTimeout);
      _sendLocation(log!);
      log = [];
      shouldUpsert = true;
    });
  }

  Future<void> _sendLocation(List<Location> location) async {
    var incident = _core!.state.capture.incident!;

    _uploadChanges(
      incident.copyWith(
        location: [...incident.location ?? [], ...location],
      ),
    );
  }

  // ⬇️ SMS
  void _notifyContacts() async {
    var contacts = await _core!.services.server.contacts.readFromUserIdOnce(
      id: _core!.services.auth.currentUser!.uid,
    );

    print("");

    for (Contact contact in contacts) {
      await message(contact);
    }
  }

  String _generateMessage(Contact contact, User user, Incident incident) {
    String message = kContactMessageTemplate;

    final Map<String, String> replacementMap = {
      "{FULL_NAME}": user.name,
      "{NAME}": _core!.utils.name.genFirstName(user.name, false),
      "{FULL_CONTACT_NAME}": contact.name,
      "{TIME}": DateFormat.jm().format(incident.datetime),
      "{TYPE}": _core!.utils.incident.generateType(incident.type[0])!,
      "{ADDRESS}": _core!.utils.geocoder.removeTag(
        incident.location![0].address!,
      ),
      "{LAT}": incident.location![0].lat!.toStringAsFixed(4),
      "{LONG}": incident.location![0].long!.toStringAsFixed(4),
      "{NAME_POSESSIVE}": _core!.utils.name.genFirstName(user.name, true),
      "{LINK}": "https://joinsafe.me/incident", // CHANGE ME
    };

    for (String key in replacementMap.keys) {
      message = message.replaceAll(key, replacementMap[key]!);
    }

    return message;
  }

  Future<void> message(Contact contact) async {
    var incident = _core!.state.capture.incident!;

    var user = await _core!.services.server.user.readFromIdOnce(
      id: _core!.services.auth.currentUser!.uid,
    );

    var message = _generateMessage(contact, user!, incident);

    await _core!.services.twilio.messageSMS(
      phone: contact.phone,
      message: message,
    );

    print("CAPTURE: Notified ${contact.name}");

    var notified = NotifiedContact(
      id: contact.id,
      name: contact.name,
      phone: contact.phone,
      messageSent: message,
      datetime: DateTime.now(),
    );

    incident = incident.copyWith(
      notifiedContacts: incident.notifiedContacts == null
          ? [notified]
          : [
              ...incident.notifiedContacts!,
              notified,
            ],
    );

    _core!.state.capture.setIncident(incident);
    _core!.services.server.incidents.upsert(incident);
  }

  // ⬇️ BATTERY

  void _batteryListen() async {
    battery = api.Battery();

    // Gets battery immediately
    await uploadBattery();

    // Set timer
    batteryTimer = Timer.periodic(Duration(seconds: 10), (_) async {
      await uploadBattery();
    });
  }

  Future<void> uploadBattery() async {
    // Get battery level
    var current = await battery!.batteryLevel;

    // Set local state
    _core!.state.capture.addToBattery(Battery(
      percentage: current / 100,
      datetime: DateTime.now(),
    ));

    // Upload to server
    var incident = _core!.state.capture.incident!.copyWith(
      battery: _core!.state.capture.battery,
    );

    _core!.state.capture.setIncident(incident);
    _core!.services.server.incidents.upsert(incident);
  }

  // ⬇️ WEBRTC
  void _initStream() async {
    _core!.services.signaling.init(_core!);
    await _core!.services.signaling.openLocalMedia();
    await _core!.services.signaling.createSession();
  }
}
