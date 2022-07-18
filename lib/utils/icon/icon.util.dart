import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/caret_right.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/checkmark.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/gear.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/key.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/menu.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/phone.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/play_large.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/profile.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/safe.icon.dart';

enum MutableIcons {
  phone,
  profile,
  checkmark,
  caretRight,
  gear,
  playLarge,
  menu,
  key,
  safe,
}

class IconUtil {
  late Map<MutableIcons, CustomPainter Function(Color c)> iconsMap;

  void init() {
    iconsMap = {
      MutableIcons.profile: (c) => ProfileIcon(c),
      MutableIcons.playLarge: (c) => PlayLargeIcon(c),
      MutableIcons.safe: (c) => SafeIcon(c),
      MutableIcons.menu: (c) => MenuIcon(c),
      MutableIcons.checkmark: (c) => CheckmarkIcon(c),
      MutableIcons.key: (c) => KeyIcon(c),
      MutableIcons.gear: (c) => GearIcon(c),
      MutableIcons.phone: (c) => PhoneIcon(c),
      MutableIcons.caretRight: (c) => CaretRightIcon(c),
    };
  }
}
