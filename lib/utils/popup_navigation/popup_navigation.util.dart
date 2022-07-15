import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PopupNavigationUtil {
  Future<void> navigate(
    PanelController? preA,
    PanelController a,
    PanelController b,
    AnimationController cA,
  ) async {
    cA.forward();
    await b.open();
    await cA.reverse();
    await a.close();

    if (preA != null) {
      preA.close();
    }
  }
}
