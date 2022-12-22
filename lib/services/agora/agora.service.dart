import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safe/core.dart';

enum CamType { front, back }

class AgoraService {
  Future<void> initialize(
      RtcEngine engine, RtcEngineEventHandler eventHandler) async {
    // Configure engine
    await engine.initialize(RtcEngineContext(
      appId: dotenv.env["AGORA_APP_ID"],
    ));

    await engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
        // codecType: VideoCodecType.videoCodecH264,
        // dimensions: VideoDimensions(width: 1280, height: 720),
        // frameRate: 15,
        // bitrate: 0,
        ));

    await engine.enableVideo();

    // Set channel and client options
    engine.setChannelProfile(
      ChannelProfileType.channelProfileLiveBroadcasting,
    );
    engine.setClientRole(
      role: ClientRoleType.clientRoleBroadcaster,
    );

    engine.registerEventHandler(eventHandler);
  }

  Future<void> stop(RtcEngine engine) async {
    await engine.leaveChannel();
    await engine.stopPreview();
  }

  Future<void> flipCam(RtcEngine engine, Core core, {CamType? type}) async {
    if (type == null) {
      core.state.capture.changeCam();
      return engine.switchCamera();
    }

    if (type == CamType.back && core.state.capture.isBackCam) return;
    if (type == CamType.front && !core.state.capture.isBackCam) return;

    core.state.capture.changeCam();
    return engine.switchCamera();
  }

  Future<void> muteExernalStreams(RtcEngine engine) async {
    await engine.muteAllRemoteAudioStreams(true);
  }

  Future<void> toggleFlash(RtcEngine engine, bool isOn) async {
    await engine.setCameraTorchOn(isOn);
  }

  Future<void> stream(
    RtcEngine engine, {
    required String token,
    required int uid,
    required String channelId,
  }) async {
    await engine.startPreview();

    await engine.joinChannel(
      token: token,
      channelId: channelId, // Channel Name (Incident ID)
      uid: uid, // User ID (Different for each user, need to store in firebase)
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }
}
