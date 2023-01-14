import 'package:flutter/material.dart';
import 'package:safe/screens/play/local_widgets/map_view.widget.dart';
import 'package:safe/screens/play/local_widgets/video_player.widget.dart';

class PlayBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MapView(),
            ),
            SizedBox(width: 3),
            VideoPlayer()
          ],
        )
      ],
    );
  }
}
