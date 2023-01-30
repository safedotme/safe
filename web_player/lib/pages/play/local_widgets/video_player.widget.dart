import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as remote;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:safe/models/incident/stream.model.dart' as model;
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/keys.dart';
import 'package:safe/pages/play/local_widgets/video_player_loader.widget.dart';
import 'package:safe/services/media_server/media_server.service.dart';

class VideoPlayer extends StatefulWidget {
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late Core core;
  RtcEngine? engine;
  bool loaded = false;
  model.Stream? stream;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    initEngine();
  }

  Future<void> initEngine() async {
    // Ensure Stream Available
    final s = core.state.play.incident?.stream;

    if (s == null) return;

    stream = s;

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
        loaded = false;
        context.go("/");
      },
      joinChannelSuccess: (channel, uid, elasped) {
        setState(() {
          loaded = true;
        });
      },
    ));

    await engine!.enableVideo();
    await engine!.enableAudio();
    await engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine!.setClientRole(ClientRole.Broadcaster);

    final uid = core.services.media.generateRandomUid();

    // Fetch Token
    final token = await core.services.media.generateRTCToken(
      channelName: s.channelName,
      role: TokenRole.publisher,
      type: TokenType.userAccount,
      uid: uid,
      onError: (_) {},
    );

    await engine!.muteLocalAudioStream(true);
    await engine!.muteLocalVideoStream(true);

    // Join Channel
    await engine!.joinChannel(token, s.channelName, null, uid);
  }

  @override
  void dispose() {
    engine?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/stream_loader.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 4,
          color: Colors.white.withOpacity(0.15),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: VideoPlayerLoader(),
          ),
          loaded
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: remote.SurfaceView(
                    uid: stream!.userId,
                    channelId: stream!.channelName,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
