import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as api;
import 'package:safe/core.dart';
import 'package:safe/models/admin/admin.model.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/models/incident/battery.model.dart';
import 'package:battery_plus/battery_plus.dart' as api;
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/services/token_server/token_server.service.dart';
import 'package:safe/utils/capture/messages.capture.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:uuid/uuid.dart';

class CaptureUtil {
  Core? _core;
  // Used to tell the listening algorithms when to stop capturing
  bool isActive = false;
  // Used to prevent an infinity loop of camera flips
  bool initFlip = false;

  void initialize(Core core) {
    _core = core;
  }

  void start() async {
    assert(_core != null, "CaptureUtil must be initialized");

    // Will be used to start & stop incident
    isActive = true;

    // ⬇️ FETCH ADMIN SETTINGS
    await _fetchSettings();

    int incidentNumber = _core!.state.incidentLog.incidents == null
        ? 1
        : _core!.state.incidentLog.incidents!.length + 1;

    if (_core!.state.capture.settings.defaultIncidentCap == incidentNumber)
      // ignore: curly_braces_in_flow_control_structures
      return;

    print("CRITICAL: INCIDENT LIMIT REACHED");

    // ⬇️ INCIDENT CREATE
    await _uploadChanges(null);

    // ⬇️ STREAM / RECORDING
    _stream();

    // ⬇️ LOCATION + SMS
    _locationListen();

    // ⬇️ BATTERY
    _batteryListen();
  }

  void stop() async {
    isActive = false;
    await _uploadChanges(
      _core!.state.capture.incident!.copyWith(
        stopTime: DateTime.now(),
      ),
    );

    _core!.state.capture.overlayController.show();
    await _notifyContacts(MessageType.end);

    // STREAM
    await _core!.services.agora.stop(_core!.state.capture.engine!);
    await await Future.delayed(Duration(seconds: 5));
    _core!.state.capture.showPreview?.call();

    _core!.state.capture.overlayController.hide();
    _core!.state.capture.controller.close();
    initFlip = false;
  }

  // ⬇️ FETCH SETTINGS
  Future<void> _fetchSettings() async {
    AdminSettings settings = await _core!.services.server.admin.readLatest();

    _core!.state.capture.setSettings(settings);
  }

  // ⬇️ STREAM / RECORDING
  Future<void> _initEngine() async {
    if (_core!.state.capture.engine != null) return;

    _core!.state.capture.setEngine(createAgoraRtcEngine());

    // Initializes engine and sets event handler
    await _core!.services.agora.initialize(
      _core!.state.capture.engine!,
      RtcEngineEventHandler(
        onError: (err, msg) {
          print("$err: $msg");
        },
        onLocalVideoStateChanged: (type, state, err) {
          // Triggers animation
          if (state == LocalVideoStreamState.localVideoStreamStateCapturing &&
              !initFlip) {
            initFlip = true;
            _core!.state.capture.hidePreview?.call();
          }
        },
      ),
    );
  }

  Future<void> _stream() async {
    _initEngine();

    String? token = await _core!.services.token.generate(
      channelName: _core!.state.capture.incident!.id,
      role: TokenRole.publisher,
      type: TokenType.userAccount,
      uid: "0",
    );

    _uploadChanges(_core!.state.capture.incident!.copyWith(
      streamAvailable: token != null,
    ));

    _core!.services.agora.stream(
      _core!.state.capture.engine!,
      token: token ?? "",
      uid: 0,
      channelId: _core!.state.capture.incident!.id,
    );
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
  Future<void> _uploadChanges(Incident? i, {bool shouldMerge = true}) async {
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
    return _core!.services.server.incidents.upsert(
      incident,
      shouldMerge: shouldMerge,
    );
  }

  // Updates location as user moves
  void _locationListen() async {
    List<Location> log = [];
    String? adr;

    await _core!.services.location.initilaize();

    while (isActive) {
      // Fetches location
      api.LocationData data =
          await _core!.services.location.location.getLocation();

      Location loc = Location(
        lat: data.latitude,
        long: data.longitude,
        alt: data.altitude,
        speed: data.speed,
        accuracy: data.accuracy,
        datetime: DateTime.now(),
      );

      if (log.isEmpty) {
        adr = await _generateAddress(loc);

        log.add(
          loc.copyWith(address: adr),
        );

        await _sendLocation(log);

        _notifyContacts(MessageType.start);
      } else {
        log.add(
          loc.copyWith(address: adr),
        );
        await _sendLocation(log);
      }

      await Future.delayed(kCaptureStreamTimeout);
    }
  }

  Future<void> _sendLocation(List<Location> location) async {
    var incident = _core!.state.capture.incident!.copyWith(location: location);

    _uploadChanges(incident, shouldMerge: false);
  }

  // ⬇️ SMS
  Future<void> _notifyContacts(MessageType type, {int? battery}) async {
    var contacts = await _core!.services.server.contacts.readFromUserIdOnce(
      id: _core!.services.auth.currentUser!.uid,
    );

    for (Contact contact in contacts) {
      await message(contact, type, battery: battery);
    }
  }

  String _generateMessage(
    Contact contact,
    User user,
    Incident incident,
    MessageType type, {
    int? battery,
  }) {
    String message = EmergencyMessages.messageMap[type]!;

    final Map<String, String> replacementMap = {
      "{FULL_NAME}": user.name,
      "{NAME}": _core!.utils.name.genFirstName(user.name, false),
      "{FULL_CONTACT_NAME}": contact.name,
      "{TIME}": DateFormat.jm().format(incident.datetime),
      "{TYPE}": _core!.utils.incident.generateType(incident.type[0])!,
      "{TIME_END}": DateFormat.jm().format(DateTime.now()),
      "{ADDRESS}": _core!.utils.geocoder.removeTag(
        incident.location![0].address!,
      ),
      "{LAT}": incident.location![0].lat!.toStringAsFixed(4),
      "{LONG}": incident.location![0].long!.toStringAsFixed(4),
      "{NAME_POSESSIVE}": _core!.utils.name.genFirstName(user.name, true),
      "{BATTERY}": battery.toString(),
      "{LINK}": "https://joinsafe.me/incident", // TODO: CHANGE ME
    };

    for (String key in replacementMap.keys) {
      message = message.replaceAll(key, replacementMap[key]!);
    }

    return message;
  }

  Future<void> message(Contact contact, MessageType type,
      {int? battery}) async {
    var incident = _core!.state.capture.incident!;

    var user = await _core!.services.server.user.readFromIdOnce(
      id: _core!.services.auth.currentUser!.uid,
    );

    var message =
        _generateMessage(contact, user!, incident, type, battery: battery);

    await _core!.services.twilio.messageSMS(
      phone: contact.phone,
      message: message,
    );

    print("CAPTURE ($type): Notified ${contact.name}");

    var notified = NotifiedContact(
      id: contact.id,
      name: contact.name,
      phone: contact.phone,
      messageSent: message,
      type: type,
      datetime: DateTime.now(),
    );

    incident = incident.copyWith(
      contactLog: incident.contactLog == null
          ? [notified]
          : [
              ...incident.contactLog!,
              notified,
            ],
    );

    _core!.state.capture.setIncident(incident);
    _core!.services.server.incidents.upsert(incident);
  }

  // ⬇️ BATTERY

  void _batteryListen() async {
    List<Battery> log = [];
    var battery = api.Battery();
    bool critMsg = false;

    while (isActive) {
      // Fetches location
      var current = await battery.batteryLevel;

      // Checks if battery, if message has already been sent, and if address has been generated
      if (current <= 20 &&
          !critMsg &&
          _core!.state.capture.incident!.location != null) {
        critMsg = true;
        _notifyContacts(MessageType.batteryCrit, battery: current);
      }

      Battery bat = Battery(
        percentage: current / 100,
        datetime: DateTime.now(),
      );

      log.add(bat);
      await _uploadBattery(log);

      await Future.delayed(kCaptureStreamTimeout);
    }
  }

  Future<void> _uploadBattery(List<Battery> log) async {
    var incident = _core!.state.capture.incident!.copyWith(battery: log);

    _uploadChanges(incident, shouldMerge: false);
  }
}
