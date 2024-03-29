import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as api;
import 'package:safe/core.dart';
import 'package:safe/models/admin/admin.model.dart';
import 'package:safe/models/incident/stream.model.dart' as model;
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/models/incident/battery.model.dart';
import 'package:battery_plus/battery_plus.dart' as api;
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/models/media_server/start_recording_response.model.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/services/analytics/analytics.service.dart';
import 'package:safe/services/analytics/helper_classes/analytics_insight.model.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';
import 'package:safe/services/media_server/media_server.service.dart';
import 'package:safe/services/server/incident_server.service.dart';
import 'package:safe/utils/capture/messages.capture.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:uuid/uuid.dart';

class CaptureUtil {
  Core? _core;
  // Used to tell the listening algorithms when to stop capturing
  bool isActive = false;
  // Used to prevent an infinity loop of camera flips
  bool initFlip = false;
  // Used to differenciate between real and fake incidents
  bool isTutorial = false;

  void initialize(Core core) {
    _core = core;
  }

  // Resets phone tally from envs
  void _setPhoneTally() {
    final keys = dotenv.env.keys.where(
      (k) => k.contains("TWILIO_PHONE"),
    );

    List<Map<String, int>> tally = [];

    for (final key in keys) {
      tally.add({key: 0});
    }

    _core!.state.capture.setPhoneTally(tally);
  }

  //
  void tutorial() async {
    assert(_core != null, "CaptureUtil must be initialized");

    // Will be used to start & stop incident
    isTutorial = true;
    isActive = true;

    // Resets error
    if (_core!.state.capture.errorCapturing != null) {
      _core!.state.capture.setErrorCapturing(null);
    }

    // Prevents two banners from being open at same time
    if (_core!
        .state.capture.incidentRecordedBannerPanelController.isPanelOpen) {
      _core!.state.capture.incidentRecordedBannerPanelController.close();
    }

    // ⬇️ INCIDENT CREATE
    await _uploadChanges(null);
    _logTutorial(_core!.state.capture.incident!, false);

    // ⬇️ STREAM / RECORDING
    _stream();

    // ⬇️ LOCATION + SMS
    _locationListen();

    // ⬇️ BATTERY
    _batteryListen();

    // Auto Stop (will stop incident after 30 seconds)
    _timeout(wait: Duration(seconds: 30));
  }

  void start() async {
    assert(_core != null, "CaptureUtil must be initialized");

    // Will be used to start & stop incident
    isActive = true;

    // Resets phone tally
    _setPhoneTally();

    // Resets error
    if (_core!.state.capture.errorCapturing != null) {
      _core!.state.capture.setErrorCapturing(null);
    }

    // Prevents two banners from being open at same time
    if (_core!
        .state.capture.incidentRecordedBannerPanelController.isPanelOpen) {
      _core!.state.capture.incidentRecordedBannerPanelController.close();
    }

    // ⬇️ INCIDENT CREATE
    await _uploadChanges(null);
    _logIncident(_core!.state.capture.incident!, false);
    _core!.services.analytics.insight(
      AnalyticsInsight(
        title: "Incidents",
        value: {"\$inc": 1},
        icon: "📸",
      ),
    );

    // ⬇️ STREAM / RECORDING
    _stream();

    // ⬇️ LOCATION + SMS
    _locationListen();

    // ⬇️ BATTERY
    _batteryListen();

    // Auto Stop (will stop incident after 1 hour)
    _timeout();
  }

  void stop({String? error}) async {
    // Used to stop location and battery streams
    isActive = false;

    // Log Incident
    if (isTutorial) {
      _logTutorial(_core!.state.capture.incident!, true);
    } else {
      _logIncident(_core!.state.capture.incident!, true);
    }

    // Stores stop time to be uploaded later
    final stopTime = DateTime.now();

    // UI
    _core!.state.capture.overlayController.show();

    // Notifies contacts that incident has stopped
    await _notifyContacts(MessageType.end);

    // Upload stop time
    await _uploadChanges(
      _core!.state.capture.incident!.copyWith(
        stopTime: stopTime,
      ),
    );

    // STREAM

    await _core!.services.agora.stop(_core!.state.capture.engine!);
    _saveStreamRecording();
    await Future.delayed(Duration(seconds: 1));

    // UI
    _core!.state.capture.showPreview?.call();
    _core!.state.capture.overlayController.hide();
    _core!.state.capture.controller.close();
    initFlip = false;
    isTutorial = false;

    // Opens an error if user has reached credit limit
    if (_core!.state.capture.limErrState == null) {
      if (error != null) {
        _core!.state.capture.setErrorCapturing(error);
      }
      _core!.state.capture.incidentRecordedBannerPanelController.open();
    }
  }

  // ⬇️ TIMEOUT
  void _timeout({Duration? wait}) async {
    await Future.delayed(wait ??
        Duration(
          seconds: _core!.state.capture.settings!.maxIdleTime,
        ));

    if (isActive) {
      stop();
    }
  }

  // ⬇️ ANALYTICS
  Future<void> _logTutorial(Incident i, bool stopped) {
    return _core!.services.analytics.log(AnalyticsLog(
      channel: "user-register",
      event: "capture-${stopped ? "stopped" : "started"}-tutorial",
      description:
          "User has ${stopped ? "stopped" : "started"} the capture tutorial.",
      icon: stopped ? "☁️" : "📲",
      tags: {
        "incidentid": i.id,
        "userid": i.userId,
      },
    ));
  }

  Future<void> _logIncident(Incident i, bool stopped) {
    return _core!.services.analytics.log(AnalyticsLog(
      channel: "capture-incident",
      event: "capture-${stopped ? "stopped" : "started"}",
      description:
          "User has begun ${stopped ? "stopped" : "started"} capturing the incident.",
      icon: stopped ? "☁️" : "📸",
      tags: {
        "incidentid": i.id,
        "userid": i.userId,
      },
    ));
  }

  Future<void> _logError({
    required ErrorLogType event,
    required String error,
    bool crit = false,
  }) async {
    String body = """
**ERROR**
```
$error
```

**INFORMATION**
```
ID: ${_core!.state.capture.incident!.id}
DATETIME: ${DateTime.now().toIso8601String()}
USER ID: ${_core!.state.capture.incident!.userId}
```
""";

    await _core!.services.analytics.log(AnalyticsLog(
      channel: "error",
      event: AnalyticsService.mapErrors[event]!,
      description: body,
      icon: "🚨",
      tags: {
        "incidentid": _core!.state.capture.incident!.id,
        "userid": _core!.state.capture.incident!.userId,
      },
    ));

    if (isActive && crit) {
      stop(
        error: _core!.utils.language
                .langMap[_core!.state.preferences.language]!["capture"]
            ["errors"][event],
      );
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
          _logError(
            event: ErrorLogType.rtcFailed,
            crit: true,
            error: {"error": err, "message": msg}.toString(),
          );
        },
        onJoinChannelSuccess: (connection, elapsed) {
          _recordStream();

          // Triggers animation
          if (initFlip) return;

          initFlip = true;

          // Hides camera preview to prevent UI bug
          _core!.state.capture.hidePreview?.call();
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
      onError: (e) {
        _logError(
          event: ErrorLogType.mediaServerFailed,
          error: e,
          crit: true,
        );
      },
    );

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
      onError: (e) {
        _logError(event: ErrorLogType.mediaServerFailed, error: e, crit: true);
      },
    );

    if (resourceId == null) return;

    // New RTC token must be generated for recording worker
    String? recordToken = await _core!.services.mediaServer.generateRTCToken(
      channelName: _core!.state.capture.incident!.stream.channelName,
      role: TokenRole.publisher,
      type: TokenType.userAccount,
      uid: _core!.state.capture.incident!.stream.recordingId,
      onError: (e) {
        _logError(event: ErrorLogType.mediaServerFailed, error: e, crit: true);
      },
    );

    if (recordToken == null) return;

    StartRecordingResponse? response =
        await _core!.services.mediaServer.startRecording(
      dir1: _core!.state.capture.incident!.stream.channelName,
      dir2: "raw",
      userUid: _core!.state.capture.incident!.stream.userId.toString(),
      channelName: _core!.state.capture.incident!.stream.channelName,
      recordingId: _core!.state.capture.incident!.stream.recordingId,
      resourceId: resourceId,
      maxIdleTime: _core!.state.capture.settings!.maxIdleTime,
      token: recordToken,
      onError: (e) {
        _logError(
          event: ErrorLogType.mediaServerFailed,
          error: e,
          crit: true,
        );
      },
    );

    if (response == null) return;

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

    Incident i = _core!.state.capture.incident!;

    // Call stop recording
    _core!.services.mediaServer.stopRecording(
      channelName: i.stream.channelName,
      collection: IncidentServer.path,
      incidentId: i.id,
      recordingId: i.stream.recordingId,
      resourceId: i.stream.resourceId!,
      sid: i.stream.sid!,
      onError: (e) {
        _logError(
          event: ErrorLogType.mediaServerFailed,
          error: e,
          crit: true,
        );
      },
    );
  }

  // ⬇️ LOCATION

  Future<String?> _generateAddress(Location location) async {
    // Checks that received data is not null
    if (location.lat == null || location.long == null) {
      return null;
    }

    var response = await _core!.services.geocoder.fetchAddress(
      lat: location.lat!,
      long: location.long!,
      onError: (e) {
        _logError(
          event: ErrorLogType.geocoderFailed,
          error: e.toString(),
        );
      },
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
      final incidents = _core!.state.incidentLog.incidents?.where(
        (i) => !i.isTutorial,
      );
      // Generates incident number
      int incidentNumber = incidents == null ? 1 : incidents.length + 1;

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
        stream: stream,
        isTutorial: isTutorial,
        userId: _core!.services.auth.currentUser!.uid,
        name: isTutorial ? "Tutorial" : "Incident #$incidentNumber",
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

      await Future.delayed(kLocationStreamTimeout);
    }
  }

  Future<void> _sendLocation(List<Location> location) async {
    var incident = _core!.state.capture.incident!.copyWith(location: location);

    _uploadChanges(incident, shouldMerge: false);
  }

  // ⬇️ SMS
  Future<void> _notifyContacts(MessageType type, {int? battery}) async {
    final contacts = await _core!.services.server.contacts.readFromUserIdOnce(
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

    Location? l = type == MessageType.end
        ? incident.location?.last
        : incident.location?.first;

    message = EmergencyMessages.addLocation(message, l);

    final Map<String, String?> replacementMap = {
      "{FULL_NAME}": user.name,
      "{NAME}": _core!.utils.name.genFirstName(user.name, false),
      "{FULL_CONTACT_NAME}": contact.name,
      "{TIME}":
          "${DateFormat.jm().format(incident.datetime)} ${incident.datetime.timeZoneName}",
      "{TYPE}": _core!.utils.incident.generateType(incident.type[0])!,
      "{TIME_END}":
          "${DateFormat.jm().format(DateTime.now())} ${DateTime.now().timeZoneName}",
      "{ADDRESS}": _core!.utils.geocoder.removeTag(
        l?.address,
      ),
      "{LAT}": l?.lat?.abs().toStringAsFixed(4),
      "{LONG}": l?.long?.abs().toStringAsFixed(4),
      "{NAME_POSESSIVE}": _core!.utils.name.genFirstName(user.name, true),
      "{BATTERY}": battery.toString(),
      "{LINK}": "https://live.joinsafe.me/${incident.id}",
      "{LINK_END}": "https://download.joinsafe.me/${incident.stream.channelName}",
    };

    for (String key in replacementMap.keys) {
      if (replacementMap[key] != null) {
        message = message.replaceAll(key, replacementMap[key]!);
      }
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

    // Prevents contacts from being notified during a tutorial

    AdminSettings settings = await _core!.services.server.admin.readLatest();

    if (!isTutorial) {
      await _core!.services.twilio.messageSMS(
        phone: contact.phone,
        message: message,
        tally: _core!.state.capture.phoneTally,
        setTally: _core!.state.capture.setPhoneTally,
      );
    }

    if (!isTutorial && type == MessageType.start && settings.callContacts) {
      final voiceMsg = _generateMessage(
        contact,
        user,
        incident,
        MessageType.voice,
        battery: battery,
      );

      await _core!.services.twilio.call(
        phone: contact.phone,
        message: voiceMsg,
        tally: _core!.state.capture.phoneTally,
        setTally: _core!.state.capture.setPhoneTally,
      );
    }

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

      // Stops stream if battery is at critical level (under 5%)
      _criticalStop(battery);

      Battery bat = Battery(
        percentage: current / 100,
        datetime: DateTime.now(),
      );

      log.add(bat);
      await _uploadBattery(log);

      await Future.delayed(kCaptureStreamTimeout);
    }
  }

  /// Stops stream if battery is at critical level (under 5%)
  Future<void> _criticalStop(api.Battery battery) async {
    int level = await battery.batteryLevel;
    api.BatteryState state = await battery.batteryState;

    // Ensures incident has been recording for at least 60 seconds
    int timeElapsedInSec = DateTime.now()
        .difference(_core!.state.capture.incident!.datetime)
        .inSeconds;

    if (timeElapsedInSec < 60 ||
        level > 5 ||
        state == api.BatteryState.charging) return;

    stop();
  }

  Future<void> _uploadBattery(List<Battery> log) async {
    var incident = _core!.state.capture.incident!.copyWith(battery: log);

    _uploadChanges(incident, shouldMerge: false);
  }
}
