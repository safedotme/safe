import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_video_progress_indicator/local_widgets/video_progress_indicator_skeleton.widget.dart';
import 'package:safe/widgets/mutable_video_progress_indicator/mutable_video_progress_indicator.widget.dart';
import 'package:video_player/video_player.dart';

class PlayerProgressIndicator extends StatefulWidget {
  @override
  State<PlayerProgressIndicator> createState() =>
      _PlayerProgressIndicatorState();
}

class _PlayerProgressIndicatorState extends State<PlayerProgressIndicator> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Observer(
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
            queryData.padding.left, 0, 24, queryData.padding.bottom),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ⬇️ CONTROLS
            MutableButton(
              scale: 0.9,
              onTap: () {
                HapticFeedback.lightImpact();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                color: Colors.transparent,
                child: MutableIcon(
                  MutableIcons.backward,
                  size: Size(19, 20),
                ),
              ),
            ),
            SizedBox(width: 10),
            MutableButton(
              scale: 0.9,
              onTap: () {
                HapticFeedback.lightImpact();
              },
              child: SizedBox(
                width: 20,
                height: 20,
                child: MutableIcon(
                  MutableIcons.play,
                  size: Size(18, 20),
                ),
              ),
            ),
            SizedBox(width: 10),
            MutableButton(
              scale: 0.9,
              onTap: () {
                HapticFeedback.lightImpact();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 7),
                color: Colors.transparent,
                child: MutableIcon(
                  MutableIcons.forward,
                  size: Size(19, 20),
                ),
              ),
            ),

            // ⬇️ PROGRESS INDICATOR
            SizedBox(width: 14),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: core.state.incident.player != null
                    ? MutableVideoProgressIndicator(core.state.incident.player!)
                    : VideoProgressIndicatorSkeleton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
