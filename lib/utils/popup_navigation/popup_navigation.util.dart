import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PopupNavigationUtil {
  Future<void> navigate(
      PanelController a, PanelController b, AnimationController cA) async {
    cA.forward();
    await b.open();
    await cA.reverse();
    a.close();
  }
}
