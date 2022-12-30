import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:safe/core.dart';

enum CamType { front, back }

class AgoraService {
  Future<void> initialize(
    RtcEngine engine,
    RtcEngineEventHandler eventHandler, {
    required VideoDimensions dimensions,
    required int frameRate,
  }) async {
    // Configure engine
    await engine.initialize(RtcEngineContext(
      appId: dotenv.env["AGORA_APP_ID"],
    ));

    await engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
      orientationMode: OrientationMode.orientationModeFixedPortrait,
      dimensions: dimensions,
      frameRate: frameRate,
      bitrate: 0,
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
    // Called when the type is unknown, only want to flip camera
    if (type == null) {
      if (core.state.capture.isFlashOn) {
        core.state.capture.flashButtonController.setActive(
          false,
        );
        core.state.capture.setFlash();
      }

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

  Future<void> toggleFlash(RtcEngine engine, Core core) async {
    await engine.setCameraTorchOn(!core.state.capture.isFlashOn);
    core.state.capture.flashButtonController.setActive(
      !core.state.capture.isFlashOn,
    );
    core.state.capture.setFlash();
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
