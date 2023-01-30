import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/battery.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/location.icon.dart';

enum MutableIcons {
  location,
  battery,
}

class IconUtil {
  late Map<MutableIcons, CustomPainter Function(Color c)> iconsMap;

  void init() {
    iconsMap = {
      MutableIcons.location: (c) => LocationIcon(c),
      MutableIcons.battery: (c) => BatteryIcon(c),
    };
  }
}
