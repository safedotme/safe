import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/pages/play/local_widgets/video_player.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';

class StreamView extends StatefulWidget {
  @override
  State<StreamView> createState() => _StreamViewState();
}

class _StreamViewState extends State<StreamView> with TickerProviderStateMixin {
  late AnimationController controller;
  Animation? animation;
  double state = 0;

  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    controller.addListener(() {
      if (animation == null) return;

      setState(() {
        state = animation!.value;
      });
    });
  }

  @override
  void dispose() {
    if (controller.isAnimating) {
      controller.stop();
    }

    controller.dispose();
    super.dispose();
  }

  void animate() {
    animation = Tween<double>(
      begin: state,
      end: (1 - state).abs(),
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Stack(
      children: [
        Visibility(
          visible: state != 0,
          child: Opacity(
            opacity: state,
            child: GestureDetector(
              onTap: () {
                if (controller.isAnimating) return;
                animate();
              },
              onVerticalDragStart: (_) {
                if (controller.isAnimating) return;
                animate();
              },
              child: Container(
                color:
                    kColorMap[MutableColor.neutral10]!.withOpacity(state * 0.5),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            15,
            queryData.viewInsets.top + 22,
            15,
            0,
          ),
          child: SizedBox(
            width: 135 + (queryData.size.width - (135 + 30)) * state,
            child: GestureDetector(
              onTap: () {
                if (controller.isAnimating) return;
                animate();
              },
              child: AspectRatio(
                aspectRatio: 720 / 1080,
                child: VideoPlayer(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
