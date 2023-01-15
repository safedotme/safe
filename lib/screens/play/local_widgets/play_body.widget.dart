import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/screens/play/local_widgets/map_view.widget.dart';
import 'package:safe/screens/play/local_widgets/video_player.widget.dart';

class PlayBody extends StatefulWidget {
  final Incident incident;
  PlayBody(this.incident);

  @override
  State<PlayBody> createState() => _PlayBodyState();
}

class _PlayBodyState extends State<PlayBody> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    // Initialize Player
    core.utils.play.initPlayer(widget.incident);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MapView(widget.incident),
            ),
            SizedBox(width: 3),
            VideoPlayer(widget.incident)
          ],
        ),
      ],
    );
  }
}
