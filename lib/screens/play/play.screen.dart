import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/play/local_widgets/play_body.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class PlayScreen extends StatefulWidget {
  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> with TickerProviderStateMixin {
  late Core core;
  AnimationController? controller;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  // Used to prevent RenderFlex Issues
  Future<void> animateIn() async {
    // Always call first (for animation purposes)
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );

    // ⬇️ Animate In
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    Animation animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: controller!, curve: Curves.easeIn),
    );

    controller!.addListener(() {
      setState(() {
        opacity = animation.value;
      });
    });

    await controller!.forward();
  }

  // Used to prevent RenderFlex Issues
  Future<void> animateOut() async {
    // ⬇️ Animate Out
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    Animation animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: controller!, curve: Curves.easeIn),
    );

    controller!.addListener(() {
      setState(() {
        opacity = animation.value;
      });
    });

    await controller!.forward();

    // Always call last (for animation purposes)
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      isOpen: true, // TODO: Change me
      backgroundColor: kColorMap[MutableColor.neutral10],
      isDismissable: false,
      onOpen: () async {
        animateIn();
      },
      onClose: () {},
      controller: core.state.incident.playController,
      // body: Visibility(
      //   visible: opacity != 0,
      //   child: Opacity(
      //     opacity: opacity,
      //     child: SizedBox(), // TODO: Replace with actual content
      //   ),
      // ),
      body: PlayBody(),
    );
  }
}
