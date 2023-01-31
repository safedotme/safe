import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/neuances.dart';
import 'package:safe/screens/tutorial/local_widgets/tutorial_component.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_large_button/mutable_large_button.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TutorialScreen extends StatefulWidget {
  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late Core core;
  // ⬇️ CONSTANTS

  // General
  final Duration duration = Duration(milliseconds: 300);
  final Duration consumeDuration = Duration(milliseconds: 1500);
  final List<Curve> curves = [Curves.easeOut, Curves.easeInOut];
  final Curve bubbleCurve = Curves.easeIn;

  // Specific
  final List<double> headerPositions = [370 / 711, 180 / 711, 0];
  final List<double> infoPositions = [145 / 711, 88 / 711];
  final List<double> streamContactPositions = [363 / 711, 313 / 711];
  final List<double> locationPositions = [500 / 711, 458 / 711];
  final List<double> footerPositions = [650 / 711, 603 / 711];

  // ⬇️ STATE

  // Header
  double headerOpacity = 0;
  double headerPosition = 0;
  int headerCurve = 0;

  // Info
  double infoOpacity = 0;
  double infoPosition = 0;
  int infoCurve = 0;

  // Stream & Contact
  double streamContactOpacity = 0;
  double streamContactPosition = 0;
  int streamContactCurve = 0;

  // Location
  double locationOpacity = 0;
  double locationPosition = 0;
  int locationCurve = 0;

  // Footer
  double footerOpacity = 0;
  double footerPosition = 0;
  int footerCurve = 0;

  // Button
  double buttonOpacity = 0;

  // ⬇️ METHODS

  // Used to ensure all values are default before animation begins
  void resetValues() {
    setState(() {
      headerPosition = headerPositions[0];
      headerOpacity = 0;
      headerCurve = 0;

      infoCurve = 0;
      infoOpacity = 0;
      infoPosition = infoPositions[0];

      streamContactCurve = 0;
      streamContactOpacity = 0;
      streamContactPosition = streamContactPositions[0];

      locationCurve = 0;
      locationOpacity = 0;
      locationPosition = locationPositions[0];

      footerCurve = 0;
      footerOpacity = 0;
      footerPosition = footerPositions[0];

      buttonOpacity = 0;
    });
  }

  Future<void> animate() async {
    resetValues();
    // Bubbles
    await Future.delayed(Duration(seconds: 1));

    // Header
    setState(() {
      headerPosition = headerPositions[1];
      headerOpacity = 1;
    });
    await Future.delayed(duration);

    // Wait
    await Future.delayed(consumeDuration);

    // Header w/ Info
    setState(() {
      headerPosition = headerPositions[2];
      headerCurve = 1;

      infoPosition = infoPositions[1];
      infoOpacity = 1;
    });
    await Future.delayed(duration);

    // Wait
    await Future.delayed(consumeDuration);

    // Stream & Contacts
    setState(() {
      streamContactPosition = streamContactPositions[1];
      streamContactOpacity = 1;
    });
    await Future.delayed(duration + duration);

    // Wait
    await Future.delayed(consumeDuration);

    // Location
    setState(() {
      locationPosition = locationPositions[1];
      locationOpacity = 1;
    });
    await Future.delayed(duration);

    // Wait
    await Future.delayed(consumeDuration);

    // Footer
    setState(() {
      footerPosition = footerPositions[1];
      footerOpacity = 1;
    });
    await Future.delayed(duration);

    // Wait
    await Future.delayed(consumeDuration);

    setState(() {
      buttonOpacity = 1;
    });
    await Future.delayed(duration);
  }

  double genPosition(double percentage, double size, double margin) =>
      (size - margin) * percentage;

  @override
  void initState() {
    core = Provider.of(context, listen: false);

    super.initState();
    if (core.state.auth.isTutorialOpen) {
      animate();
    }
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return Observer(
      builder: (_) => MutableScreenTransition(
        controller: core.state.auth.tutorialController,
        isOpen: core.state.auth.isTutorialOpen,
        onOpen: () {
          animate();
        },
        onClose: () {
          resetValues();
        },
        isDismissable: false,
        backgroundColor: kColorMap[MutableColor.neutral10],
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            kSideScreenMargin,
            query.padding.top,
            kSideScreenMargin,
            kBottomScreenMargin,
          ),
          child: Stack(
            children: [
              // Header Box
              AnimatedPositioned(
                top: genPosition(
                  headerPosition,
                  query.size.height,
                  query.padding.top + kBottomScreenMargin,
                ),
                duration: duration,
                curve: curves[headerCurve],
                child: AnimatedOpacity(
                  duration: duration,
                  curve: curves[headerCurve],
                  opacity: headerOpacity,
                  child: TutorialComponent("header"),
                ),
              ),

              // Info Box
              AnimatedPositioned(
                top: genPosition(
                  infoPosition,
                  query.size.height,
                  query.padding.top + kBottomScreenMargin,
                ),
                duration: duration,
                curve: curves[headerCurve],
                child: AnimatedOpacity(
                  duration: duration,
                  curve: curves[headerCurve],
                  opacity: infoOpacity,
                  child: TutorialComponent("info"),
                ),
              ),

              // Stream & Contacts
              AnimatedPositioned(
                top: genPosition(
                  streamContactPosition,
                  query.size.height,
                  query.padding.top + kBottomScreenMargin,
                ),
                duration: duration,
                curve: curves[streamContactCurve],
                child: AnimatedOpacity(
                  duration: duration,
                  curve: curves[streamContactCurve],
                  opacity: streamContactOpacity,
                  child: TutorialComponent("stream_contacts"),
                ),
              ),

              // Location
              AnimatedPositioned(
                top: genPosition(
                  locationPosition,
                  query.size.height,
                  query.padding.top + kBottomScreenMargin,
                ),
                duration: duration,
                curve: curves[locationCurve],
                child: AnimatedOpacity(
                  duration: duration,
                  curve: curves[locationCurve],
                  opacity: locationOpacity,
                  child: TutorialComponent("location"),
                ),
              ),

              // Footer
              AnimatedPositioned(
                top: genPosition(
                  footerPosition,
                  query.size.height,
                  query.padding.top + kBottomScreenMargin,
                ),
                duration: duration,
                curve: curves[footerCurve],
                child: AnimatedOpacity(
                  duration: duration,
                  curve: curves[footerCurve],
                  opacity: footerOpacity,
                  child: TutorialComponent(
                    "footer",
                    onTap: () {
                      launchUrl(kMarkMusicTwitter);
                    },
                  ),
                ),
              ),

              // CTA Button
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedOpacity(
                  opacity: buttonOpacity,
                  duration: duration,
                  child: MutableLargeButton(
                    textSize: 16,
                    height: 44,
                    borderRadius: 15,
                    animateBeforeVoidCallback: true,
                    onTap: () async {
                      // Opens Incident Log for user to not see contact error
                      await core.state.incidentLog.controller.open();

                      // Close tutorial
                      await core.state.auth.tutorialController.close();
                      core.state.auth.setIsTutorialOpen(false);
                      core.state.preferences.setIsFirstTime(true);

                      core.state.contact.importContactPopupController.open();
                    },
                    text: core.utils.language.langMap[
                        core.state.preferences.language]!["tutorial"]["button"],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
