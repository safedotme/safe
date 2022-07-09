import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MutableCountryCodeSelector extends StatelessWidget {
  final PanelController controller;

  MutableCountryCodeSelector({required this.controller});

  @override
  Widget build(BuildContext context) {
    return MutablePopup(
      controller: controller,
      defaultState: PanelState.CLOSED,
      maxHeight: 500,
      minHeight: 0,
      body: Container(),
    );
  }
}
