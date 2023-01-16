import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:video_player/video_player.dart';

class PlayUtil {
  Core? core;
  Incident? incident;

  void initialize(Core c) => core = c;

  // ⬇️ Initialize Player
  Future<void> initIncident(Incident i) async {
    assert(core != null, "Utility has not been initialized.");
    // Set incident
    incident = i;

    core!.state.incident.setPlayTime(parseTime(Duration.zero));
    core!.state.incident.setPlayDate(parseDate(i.datetime));

    if (i.battery != null && i.battery!.isNotEmpty) {
      core!.state.incident.setPlayBattery(parseBattery(i.battery!.first));
    }

    if (i.location != null && i.location!.isNotEmpty) {
      core!.state.incident.setPlayPosition(parsePosition(i.location!.first));
    }
  }

  void reset() {
    assert(core != null, "Utility has not been initialized.");

    if (core!.state.incident.player != null) {
      core!.state.incident.player!.pause();
    }

    core!.state.incident.setPlayer(null);
  }

  // ⬇️ Video
  Future<Map<String, dynamic>> _fetchVideo() async {
    String path = "${incident!.path}/raw/output.mp4";

    return core!.services.storage.getDownloadUrl(path);
  }

  Future<void> _logError(String userMessage, String error) async {
    core!.state.preferences.actionController.trigger(
      userMessage,
      MessageType.error,
      wait: Duration(seconds: 6),
    );

    await core!.services.analytics.log(
      AnalyticsLog(
        channel: "error",
        event: "play-failed",
        description: "Unable to load video: $error",
        icon: "🚨",
        tags: {
          "incidentid": incident!.id,
          "userid": incident!.userId,
        },
      ),
    );
  }

  Future<bool> initializeVideoPlayer() async {
    // ⬇️ Fetch Video URL
    Map? data = await _fetchVideo();

    // Logs error
    if (data["error"] != null) {
      _logError("Unable to load video", data["error"]); // TODO: Extract message
      return false;
    }

    // ⬇️ Initialize Video Player
    core!.state.incident.setPlayer(
      VideoPlayerController.network(data["url"]),
    );

    try {
      await core!.state.incident.player!.initialize();
    } catch (e) {
      _logError("Unable to load video", e.toString()); // TODO: Extract message
      return false;
    }

    return true;
  }

  Battery? fetchLatestBattery(DateTime pointer, List<Battery> log) {
    if (log.isEmpty) return null;

    Battery latest = log.first;

    for (Battery current in log) {
      var beat = pointer.difference(latest.datetime).inMilliseconds.abs();
      var contender = pointer.difference(current.datetime).inMilliseconds.abs();

      if (contender < beat) {
        latest = current;
      }
    }

    return latest;
  }

  LatLng? parsePosition(Location? l) {
    if (l == null || l.lat == null || l.long == null) return null;

    return LatLng(l.lat!, l.long!);
  }

  String? parseBattery(Battery? battery) {
    if (battery == null) return null;

    String state = "${battery.percentage * 100}% ({STATE})";

    if (battery.percentage < 0.1) {
      return state.replaceAll("{STATE}", "CRITICAL"); // TODO: Extract message
    }

    if (battery.percentage < 0.2) {
      return state.replaceAll("{STATE}", "LOW"); // TODO: Extract message
    }

    if (battery.percentage < 0.8) {
      return state.replaceAll("{STATE}", "NORMAL"); // TODO: Extract message
    }

    return state.replaceAll("{STATE}", "HIGH"); // TODO: Extract message
  }

  String parseDate(DateTime t) {
    String time = DateFormat.jm().format(t);

    return "$time (${t.timeZoneName})";
  }

  String parseTime(Duration position) {
    int minutes = position.inMinutes;
    int seconds = position.inSeconds;
    String parsedMin = "";
    String parsedSec = "";

    seconds = seconds - (minutes * 60);

    if (minutes.toString().length == 1) {
      parsedMin = "0$minutes";
    } else {
      parsedMin = minutes.toString();
    }

    if (seconds.toString().length == 1) {
      parsedSec = "0$seconds";
    } else {
      parsedSec = seconds.toString();
    }

    return "$parsedMin:$parsedSec";
  }
}
