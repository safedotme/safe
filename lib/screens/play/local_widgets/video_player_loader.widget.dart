import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
import 'package:safe/widgets/mutable_video_loader/mutable_video_loader.widget.dart';

class VideoPlayerLoader extends StatefulWidget {
  final Incident incident;
  VideoPlayerLoader(this.incident);

  @override
  State<VideoPlayerLoader> createState() => _VideoPlayerLoaderState();
}

class _VideoPlayerLoaderState extends State<VideoPlayerLoader> {
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
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: MutableCachedImage(
            fetchThumbnail(core.state.incidentLog.thumbnails),
            backgroundColor: kColorMap[MutableColor.neutral5]!,
            fit: BoxFit.cover,
          ),
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: kColorMap[MutableColor.neutral10]!.withOpacity(0.8),
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
    );
  }
}
