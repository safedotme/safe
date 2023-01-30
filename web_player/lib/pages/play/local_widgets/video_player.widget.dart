import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/keys.dart';
import 'package:safe/services/media_server/media_server.service.dart';

class VideoPlayer extends StatefulWidget {
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late Core core;
  RtcEngine? engine;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    initEngine();
  }

  Future<void> initEngine() async {
    // Ensure Stream Available
    final stream = core.state.play.incident?.stream;

    if (stream == null) return;

    // Create Engine
    try {
      engine = await RtcEngine.create(kAgoraAppId);
    } on PlatformException catch (_) {
      await Future.delayed(Duration(seconds: 1));
      initEngine();

      return;
    }

    // ignore: invalid_use_of_protected_member
    await engine!.initialize(RtcEngineContext(kAgoraAppId));

    // Setup
    engine!.setEventHandler(RtcEngineEventHandler(
      error: (err) {
        print("error: $err");
        // _logError(
        //   event: ErrorLogType.rtcFailed,
        //   crit: true,
        //   error: {"error": err, "message": msg}.toString(),
        // );
      },
      userJoined: (uid, elapsed) {
        print(uid);
      },
      joinChannelSuccess: (channel, uid, elasped) {
        print("success");
        // _recordStream();

        // // Triggers animation
        // if (initFlip) return;

        // initFlip = true;

        // // Hides camera preview to prevent UI bug
        // _core!.state.capture.hidePreview?.call();
      },
    ));

    await engine!.disableVideo();
    await engine!.disableAudio();
    await engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine!.setClientRole(ClientRole.Audience);

    final uid = core.services.media.generateRandomUid();

    // Fetch Token
    final token = await core.services.media.generateRTCToken(
      channelName: stream.channelName,
      role: TokenRole.subscriber,
      type: TokenType.userAccount,
      uid: uid,
      onError: (_) {},
    );

    // Join Channel
    await engine!.joinChannel(token, stream.channelName, null, uid);
  }

  @override
  void dispose() {
    engine?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
