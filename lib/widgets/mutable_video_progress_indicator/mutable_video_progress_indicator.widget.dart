import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_video_progress_indicator/local_widgets/video_progress_indicator_skeleton.widget.dart';
import 'package:video_player/video_player.dart';

class MutableVideoProgressIndicator extends StatefulWidget {
  final VideoPlayerController controller;

  MutableVideoProgressIndicator(this.controller);
  @override
  State<MutableVideoProgressIndicator> createState() =>
      _MutableVideoProgressIndicatorState();
}

class _MutableVideoProgressIndicatorState
    extends State<MutableVideoProgressIndicator> {
  double percentage = 0;
  bool _controllerWasPlaying = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (widget.controller.value.isBuffering) return;
      if (!widget.controller.value.isInitialized) return;
      if (!mounted) return;

      setState(() {
        percentage = getPosition(widget.controller.value);
      });
    });
  }

  double getPosition(VideoPlayerValue v) =>
      v.position.inMilliseconds / v.duration.inMilliseconds;

  void set(void Function() f) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        f();
      });
    });
  }

  void seekToRelativePosition(Offset globalPosition) {
    final RenderBox box = context.findRenderObject()! as RenderBox;
    final Offset tapPos = box.globalToLocal(globalPosition);
    final double relative = tapPos.dx / box.size.width;
    final Duration position = widget.controller.value.duration * relative;
    widget.controller.seekTo(position);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragStart: (DragStartDetails details) {
        _controllerWasPlaying = widget.controller.value.isPlaying;
        if (_controllerWasPlaying) {
          widget.controller.pause();
        }
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        seekToRelativePosition(details.globalPosition);
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        if (_controllerWasPlaying &&
            widget.controller.value.position !=
                widget.controller.value.duration) {
          widget.controller.play();
        }
      },
      child: Container(
        height: 40,
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: VideoProgressIndicatorSkeleton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: LayoutBuilder(
                builder: (_, constraints) => Container(
                  width: (constraints.maxWidth * percentage).isNegative
                      ? 0
                      : constraints.maxWidth * percentage,
                  height: kLinearProgressIndicatorWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
