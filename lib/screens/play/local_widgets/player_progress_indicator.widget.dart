import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:safe/widgets/mutable_video_progress_indicator/local_widgets/video_progress_indicator_skeleton.widget.dart';
import 'package:safe/widgets/mutable_video_progress_indicator/mutable_video_progress_indicator.widget.dart';

class PlayerProgressIndicator extends StatefulWidget {
  final Incident incident;

  PlayerProgressIndicator(this.incident);
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

                if (core.state.incident.player == null) return;
                if (!core.state.incident.player!.value.isInitialized) return;

                var pos = core.state.incident.player!.value.position -
                    Duration(seconds: 10);

                if (pos < Duration.zero) {
                  core.state.incident.player!.seekTo(Duration.zero);
                  return;
                }

                core.state.incident.player!.seekTo(pos);
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

                if (core.state.incident.player == null) return;
                if (!core.state.incident.player!.value.isInitialized) return;

                if (core.state.incident.player!.value.isPlaying) {
                  core.state.incident.player!.pause();
                } else {
                  core.state.incident.player!.play();
                }
              },
              child: SizedBox(
                width: 20,
                height: 20,
                child: !core.state.incident.isPlaying
                    ? MutableIcon(
                        MutableIcons.play,
                        size: Size(18, 20),
                      )
                    : MutableIcon(
                        MutableIcons.pause,
                        size: Size(15, 20),
                      ),
              ),
            ),
            SizedBox(width: 10),
            MutableButton(
              scale: 0.9,
              onTap: () {
                HapticFeedback.lightImpact();

                if (core.state.incident.player == null) return;
                if (!core.state.incident.player!.value.isInitialized) return;

                var pos = core.state.incident.player!.value.position +
                    Duration(seconds: 10);

                if (pos > core.state.incident.player!.value.duration) {
                  core.state.incident.player!.seekTo(
                    core.state.incident.player!.value.duration,
                  );
                  return;
                }

                core.state.incident.player!.seekTo(pos);
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

            // ⬇️ TIME INDICATOR
            SizedBox(width: 14),
            Observer(
              builder: (_) => Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 45,
                    child: MutableText(
                      core.state.incident.playTime,
                      weight: TypeWeight.semiBold,
                    ),
                  ),
                  SizedBox(width: 3),
                  SizedBox(
                    width: 85,
                    child: MutableText(
                      core.state.incident.playDate,
                      size: 12,
                      color: MutableColor.neutral2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
