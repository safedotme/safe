import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_icon/icons/phone/phone.icon.dart';

enum MutableIcons {
  phone,
}

class IconUtil {
  late Map<MutableIcons, CustomPainter Function(Color c)> icons;

  void init() {
    icons = {
      MutableIcons.phone: ((c) => PhoneIcon(kColorMap[c]!)),
    };
  }
}
