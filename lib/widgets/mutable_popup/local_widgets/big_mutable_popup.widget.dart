import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BigMutablePopup extends StatelessWidget {
final void Function() onPanelOpened;
final


  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 325,
      maxHeight: 500,
      borderRadius: BorderRadius.circular(35),
      boxShadow: const [],
      onPanelOpened: () {}, // PROP
      onPanelClosed: () {}, // PROP
      onPanelSlide: (_) {}, // PROP
      defaultPanelState: PanelState.OPEN, // PROP
      isDraggable: true, // PROP
      controller: PanelController(), // PROP
      backdropTapClosesPanel: true, // PROP
      backdropEnabled: true, // PROP
      backdropColor: kColorMap[MutableColor.neutral10]!, // PROP
      backdropOpacity: kTransparencyMap[Transparency.v80]!, // PROP
      panel: Center(
        child: Text("This is the sliding Widget"),
      ),
      body: Center(
        child: Text("This is the Widget behind the sliding panel"),
      ),
    );
  }
}
