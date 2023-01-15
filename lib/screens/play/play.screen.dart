import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
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
    core.utils.play.initialize(core);
  }

  // Used to prevent RenderFlex Issues
  Future<void> animateIn() async {
    // Always call first (for animation purposes)
    await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight],
    );

    await Future.delayed(Duration(milliseconds: 500));

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
      [DeviceOrientation.portraitUp],
    );
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
      isOpen: false, // TODO: Change me
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
          child: getIncident() == null ? SizedBox() : PlayBody(getIncident()!),
        ),
      ),
      //body: getIncident() == null ? SizedBox() : PlayBody(getIncident()!),
    );
  }
}
