import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safe/models/incident/incident.model.dart';

class AgoraService {
  late RtcEngine engine;
  int? uid;
  Incident? incident;

  Future<void> initialize(int id, Incident icd) async {
    engine = createAgoraRtcEngine();
    uid = id;
    incident = icd;

    await engine.initialize(
      RtcEngineContext(appId: dotenv.env["AGORA_APP_ID"]),
    );

    // SEND IMPORTANT INFO TO DB
    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (error, message) {
        print(error);
        print(message);
        //TODO: Add propper error handling
      },
    ));

    await engine.enableAudio();
    await engine.enableVideo();

    // TODO: Add actual configs
    await engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
      codecType: VideoCodecType.videoCodecH264,
      dimensions: VideoDimensions(width: 1280, height: 720),
      frameRate: 15,
      bitrate: 0,
    ));
  }

  Future<void> start(int id) async {
    if (uid == null) {
      print("STREAM ERROR: UID is null");
      return;
    }
    if (incident == null) {
      print("STREAM ERROR: Incident is null");
      return;
    }

    await engine.startPreview();

    await engine.joinChannel(
      token: incident!.id,
      channelId: incident!.name,
      uid: id,
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> stop() async {
    if (uid == null) {
      print("STREAM ERROR: UID is null");
      return;
    }
    if (incident == null) {
      print("STREAM ERROR: Incident is null");
      return;
    }

    await engine.leaveChannel();
  }

  Future<void> dispose() async {
    if (uid == null) {
      print("STREAM ERROR: UID is null");
      return;
    }
    if (incident == null) {
      print("STREAM ERROR: Incident is null");
      return;
    }

    incident = null;
    uid = null;
    await engine.release();
  }

  Future<void> flipCamera() async {
    if (uid == null) {
      print("STREAM ERROR: UID is null");
      return;
    }
    if (incident == null) {
      print("STREAM ERROR: Incident is null");
      return;
    }

    await engine.switchCamera();
  }
}
