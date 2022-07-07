import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/checkmark.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/key.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/profile.icon.dart';

enum MutableIcons {
  profile,
  checkmark,
  key,
}

class IconUtil {
  late Map<MutableIcons, CustomPainter Function(Color c)> iconsMap;

  void init() {
    iconsMap = {
      MutableIcons.profile: (c) => ProfileIcon(c),
      MutableIcons.checkmark: (c) => CheckmarkIcon(c),
      MutableIcons.key: (c) => KeyIcon(c),
    };
  }
}
