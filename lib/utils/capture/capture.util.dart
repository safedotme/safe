import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as api;
import 'package:safe/core.dart';
import 'package:safe/models/incident/stream.model.dart' as model;
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/models/incident/battery.model.dart';
import 'package:battery_plus/battery_plus.dart' as api;
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/models/media_server/start_recording_response.model.dart';
import 'package:safe/models/media_server/stop_recording_response.model.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/services/media_server/media_server.service.dart';
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

    // Prevents two banners from being open at same time
    if (_core!
        .state.capture.incidentRecordedBannerPanelController.isPanelOpen) {
      _core!.state.capture.incidentRecordedBannerPanelController.close();
    }

    // ⬇️ INCIDENT CREATE
    await _uploadChanges(null);

    // ⬇️ STREAM / RECORDING
    _stream();

    // // ⬇️ LOCATION + SMS
    // _locationListen();

    // // ⬇️ BATTERY
    // _batteryListen();
  }

  void stop() async {
    // Used to stop location and battery streams
    isActive = false;

    // Uploads immediate time user pressed stop
    await _uploadChanges(
      _core!.state.capture.incident!.copyWith(
        stopTime: DateTime.now(),
      ),
    );

    // UI
    _core!.state.capture.overlayController.show();

    // Notifies contacts that incident has stopped
    // await _notifyContacts(MessageType.end);

    // STREAM

    await _core!.services.agora.stop(_core!.state.capture.engine!);
    await _saveStreamRecording();
    await Future.delayed(Duration(seconds: 1));

    // UI
    _core!.state.capture.showPreview?.call();
    _core!.state.capture.overlayController.hide();
    _core!.state.capture.controller.close();
    initFlip = false;

    // Opens an error if user has reached credit limit
    if (_core!.state.capture.limErrState == null) {
      _core!.state.capture.incidentRecordedBannerPanelController.open();
    }
  }

  // ⬇️ STREAM / RECORDING

  // Initializes streaming engine & prepares for streaming
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

            // Hides camera preview to prevent UI bug
            _core!.state.capture.hidePreview?.call();

            // Starts recording
            _recordStream();
          }
        },
      ),
      frameRate: _core!.state.capture.settings!.frameRate,
      dimensions: VideoDimensions(
        width: _core!.state.capture.settings!.dimensionWidth,
        height: _core!.state.capture.settings!.dimensionHeight,
      ),
    );
  }

  Future<void> _stream() async {
    _initEngine();

    String? token = await _core!.services.mediaServer.generateRTCToken(
      channelName: _core!.state.capture.incident!.stream.channelName,
      role: TokenRole.publisher,
      type: TokenType.userAccount,
      uid: _core!.state.capture.incident!.stream.userId,
    );

    _core!.state.capture.setToken(token);

    if (token == null) {
      _uploadChanges(_core!.state.capture.incident!.copyWith(
        streamAvailable: false,
      ));
    }

    await _core!.services.agora.stream(
      _core!.state.capture.engine!,
      token: token ?? "",
      uid: _core!.state.capture.incident!.stream.userId,
      channelId: _core!.state.capture.incident!.stream.channelName,
    );
  }

  Future<void> _recordStream() async {
    // Fetch resourceId
    String? resourceId = await _core!.services.mediaServer.getResourceID(
      channelName: _core!.state.capture.incident!.stream.channelName,
      recordingId: _core!.state.capture.incident!.stream.recordingId,
    );

    if (resourceId == null) return;

    if (_core!.state.capture.token == null) return;

    StartRecordingResponse? response =
        await _core!.services.mediaServer.startRecording(
      dir1: _core!.services.mediaServer.generateDirectory(
        _core!.state.capture.incident!.userId,
      ),
      dir2: "raw",
      userUid: _core!.state.capture.incident!.stream.userId.toString(),
      channelName: _core!.state.capture.incident!.stream.channelName,
      recordingId: _core!.state.capture.incident!.stream.recordingId,
      resourceId: resourceId,
      maxIdleTime: 180, // TODO: CHANGE ME
      token: _core!.state.capture.token!,
    );

    if (response == null) return;

    print("SID: ${response.sid}");

    await _uploadChanges(_core!.state.capture.incident!.copyWith(
      stream: _core!.state.capture.incident!.stream.copyWith(
        resourceId: resourceId,
        sid: response.sid,
      ),
    ));
  }

  Future<void> _saveStreamRecording() async {
    if (_core!.state.capture.incident!.stream.resourceId == null) return;

    if (_core!.state.capture.incident!.stream.sid == null) return;

    // Call stop recording
    await _core!.services.mediaServer.stopRecording(
      channelName: _core!.state.capture.incident!.stream.channelName,
      recordingId: _core!.state.capture.incident!.stream.recordingId,
      resourceId: _core!.state.capture.incident!.stream.resourceId!,
      sid: _core!.state.capture.incident!.stream.sid!,
    );

    // if (response == null) return;

    // print("FILENAME: ${response.fileName}");

    // // Update Firebase values
    // await _uploadChanges(_core!.state.capture.incident!.copyWith(
    //   cloudRecordingAvailable: true,
    // ));
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

      String incidentId = Uuid().v1();

      var stream = model.Stream(
        // Encodes incident id in base 64 and removes all symbols (occational = sign)
        channelName: _core!.services.mediaServer.generateChannelName(
          incidentId,
        ),
        userId: 1111,
        recordingId: 9999,
      );

      incident = Incident(
        id: incidentId,
        pubID: Uuid().v4(),
        stream: stream,
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
      "{LINK}": "https://live.joinsafe.me/${incident.pubID}",
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
