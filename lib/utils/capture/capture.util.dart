import 'dart:async';

import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/neuances.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:uuid/uuid.dart';

class CaptureUtil {
  Core? _core;
  StreamSubscription<Location>? subscription;

  void initialize(Core core) {
    _core = core;
  }

  void start() {
    assert(_core != null, "CaptureUtil must be initialized");

    // ⬇️ INCIDENT CREATE
    _uploadChanges(null);

    // ⬇️ LOCATION
    _locationListen();

    // ⬇️ SMS

    // ⬇️ WEBRTC

    // ⬇️ BATTERY
  }

  void stop() async {
    // CALL STOP WHEN NECESSARY
    if (subscription != null) {
      await subscription!.cancel();
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
    subscription = _core!.services.location.stream.listen((location) async {
      // Check if log is null | this will be the first time
      if (log == null) {
        _generateAddress(location).then((address) {
          _sendLocation([location.copyWith(address: address)]);
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
  void notifyContacts() async {
    var contacts = await _core!.services.server.contacts.readFromUserIdOnce(
      id: _core!.services.auth.currentUser!.uid,
    );

    // contacts.forEach((contact) {
    message(contacts[0]);
    // });
  }

  Future<void> message(Contact contact) async {
    _core!.services.twilio.messageSMS(
      phone: "+506 71099519",
      message: kContactMessageTemplate,
    );
  }
}
