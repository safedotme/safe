import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_message_page/mutable_message_page.widget.dart';

class ProcessingIncidentLoader extends StatefulWidget {
  @override
  State<ProcessingIncidentLoader> createState() =>
      _ProcessingIncidentLoaderState();
}

class _ProcessingIncidentLoaderState extends State<ProcessingIncidentLoader>
    with TickerProviderStateMixin {
  late Core core;

  double state = 1;
  late AnimationController controller;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    isLoading = core.state.play.loading;
    initAnimation();
  }

  void initAnimation() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    final animation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );

    controller.addListener(() {
      setState(() {
        state = animation.value;
      });
    });
  }

  void handleAnimation(bool l) {
    if (l == isLoading) return;
    isLoading = l;

    if (l == false) {
      controller.forward();
      return;
    }

    controller.reverse();
  }

  @override
  void dispose() {
    if (controller.isAnimating) {
      controller.stop();
    }

    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        handleAnimation(core.state.play.loading);
        return Visibility(
          visible: state != 0,
          child: Opacity(
            opacity: state,
            child: MutableMessagePage(
              loading: true,
              type: MessageType.success,
              header: "Processing Incident",
              description:
                  "We're loading a stream of the incident to your device. This shouldn't take more than a minute.\n\n⚠NOTE: Emergency services (ie, 911) have not been notified.",
            ),
          ),
        );
      },
    );
  }
}
