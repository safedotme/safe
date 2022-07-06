import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/profile.icon.dart';

enum MutableIcons {
  profile,
}

class IconUtil {
  late Map<MutableIcons, CustomPainter Function(Color c)> iconsMap;

  void init() {
    iconsMap = {
      MutableIcons.profile: (c) => ProfileIcon(c),
    };
  }
}
