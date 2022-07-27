import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/services/server/incident_server.service.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:uuid/uuid.dart';

class CaptureUtil {
  Core? _core;

  void initialize(Core core) => _core = core;

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

  void stop() {}

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
  void _locationListen() {
    bool timeout = false;
    List<Location> backlog = [];

    _core!.services.location.stream.listen((location) async {
      if (timeout) {
        // Data thats not sent will be added to a backlog
        backlog.add(location);
        return;
      }

      // Update incident
      // Send incident
      _sendLocation(location);

      // Prevents from spamming firestore
      timeout = true;
      await Future.delayed(kLocationStreamTimeout);
      timeout = false;

      // If there is items in the backlog, send them
      if (backlog.isNotEmpty) {
        _sendLocation(backlog[0]);
        backlog.remove(backlog[0]);
        return;
      }

      return;
    });
  }

  Future<void> _sendLocation(Location location) async {
    var incident = _core!.state.capture.incident!;

    _uploadChanges(
      incident.copyWith(
        location: [...incident.location ?? [], location],
      ),
    );
  }
}
