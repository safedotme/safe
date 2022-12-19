import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgoraService {
  Future<void> initialize(RtcEngine engine) async {
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

    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (err, msg) {
        print("$err: $msg");
      },
    ));
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
