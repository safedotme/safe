import 'package:flutter/material.dart';
import 'package:safe/screens/tutorial/local_widgets/tutorial_component.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';

class TutorialScreen extends StatefulWidget {
  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  // ⬇️ CONSTANTS

  // ⬇️ STATE
  double headerOpacity = 1;
  double headerPosition = 0;

  // ⬇️ METHODS
  Future<void> animate() async {}

  double genPosition(double percentage, double size, double margin) =>
      (size - margin) * percentage;

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return MutableScreenTransition(
      isOpen: true,
      onOpen: () {
        animate();
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
            // Header
            AnimatedPositioned(
              top: genPosition(
                headerPosition,
                query.size.height,
                query.padding.top + kBottomScreenMargin,
              ),
              duration: Duration(seconds: 1),
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: headerOpacity,
                child: TutorialComponent("header"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
