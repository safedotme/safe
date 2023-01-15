import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
import 'package:safe/widgets/mutable_video_loader/mutable_video_loader.widget.dart';

class VideoPlayer extends StatefulWidget {
  final Incident incident;

  VideoPlayer(this.incident);
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  String? fetchThumbnail(Map<String, String> keys) {
    bool keyExists = keys.containsKey(widget.incident.id);

    if (!keyExists) return null;

    return keys[widget.incident.id];
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 720 / 1080,
      child: Observer(
        builder: (_) => core.state.incident.loading
            ? Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: MutableCachedImage(
                      fetchThumbnail(core.state.incidentLog.thumbnails),
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        color:
                            kColorMap[MutableColor.neutral10]!.withOpacity(0.6),
                        child: Center(
                          child: SizedBox(
                            height: 34,
                            width: 34,
                            child: MutableVideoLoader(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(),
      ),
    );
  }
}
