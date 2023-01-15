import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/screens/play/local_widgets/video_player_loader.widget.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:video_player/video_player.dart' as api;

class VideoPlayer extends StatefulWidget {
  final Incident incident;

  VideoPlayer(this.incident);
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late Core core;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    load();
  }

  void load() async {
    bool ok = await core.utils.play.initializeVideoPlayer();

    if (!ok) return;

    core.state.incident.player!.addListener(() {
      if (core.state.incident.player!.value.isInitialized && loading) {
        loading = false;
        core.state.incident.player!.play();

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 720 / 1080,
      child: Stack(
        children: [
          loading ? SizedBox() : api.VideoPlayer(core.state.incident.player!),
          AnimatedOpacity(
            opacity: loading ? 1 : 0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            child: VideoPlayerLoader(widget.incident),
          ),
        ],
      ),
    );
  }
}
