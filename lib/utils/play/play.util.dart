import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
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
}
