import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/screens/play/local_widgets/play_body.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';

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
    core.utils.play.initialize(core);
  }

  // Used to prevent RenderFlex Issues
  Future<void> animateIn() async {
    core.state.incident.setIsPlayerOpen(true);

    // Always call first (for animation purposes)
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight],
    );

    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    await Future.delayed(kRotationDuration);

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
    if (core.state.incident.player != null) {
      core.state.incident.player!.pause();
    }

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
    await Future.delayed(Duration(milliseconds: 500));

    // Always call last (for animation purposes)
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );

    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );

    await Future.delayed(kRotationDuration);

    core.state.incident.setIsPlayerOpen(false);

    core.utils.play.reset();
    core.state.incident.playController.close();
  }

  Incident? getIncident() {
    var i = core.state.incidentLog.incidents ?? [];

    if (i.isEmpty || core.state.incident.incidentId == null) {
      return null;
    }

    return i
        .singleWhere((element) => element.id == core.state.incident.incidentId);
  }

  @override
  Widget build(BuildContext context) {
    return MutableScreenTransition(
      backgroundColor: kColorMap[MutableColor.neutral10],
      isDismissable: false,
      onOpen: () async {
        animateIn();
      },
      onClose: () {},
      controller: core.state.incident.playController,
      body: Visibility(
        visible: opacity != 0,
        child: Opacity(
          opacity: opacity,
          child: getIncident() == null
              ? SizedBox()
              : PlayBody(getIncident()!, animateOut),
        ),
      ),
    );
  }
}
