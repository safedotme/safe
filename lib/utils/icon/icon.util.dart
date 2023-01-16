import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/backward.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/battery.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/calendar.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/camera.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/camera_flip.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/camera_flip_filled_icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/cancel.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/caret_right.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/checkmark.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/cloud.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/compass.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/film.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/flashlight.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/forward.widget.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/gear.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/key.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/link.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/location.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/map.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/menu.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/next.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/next_borderless.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/pause.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/phone.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/play.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/play_large.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/profile.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/safe.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/share.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/shield.icon.dart';
import 'package:safe/widgets/mutable_icon/local_widgets/stop_recording.icon.dart';

enum MutableIcons {
  phone,
  cancel,
  flashlightFilled,
  cameraFlipFilled,
  profile,
  camera,
  film,
  compass,
  map,
  battery,
  checkmark,
  caretRight,
  gear,
  playLarge,
  menu,
  share,
  nextBorderless,
  next,
  shield,
  play,
  pause,
  forward,
  backward,
  cameraFlip,
  location,
  calendar,
  cloud,
  stopRecording,
  key,
  safe,
  link,
}

class IconUtil {
  late Map<MutableIcons, CustomPainter Function(Color c)> iconsMap;

  void init() {
    iconsMap = {
      MutableIcons.play: (c) => PlayIcon(c),
      MutableIcons.pause: (c) => PauseIcon(c),
      MutableIcons.forward: (c) => ForwardIcon(c),
      MutableIcons.backward: (c) => BackwardIcon(c),
      MutableIcons.profile: (c) => ProfileIcon(c),
      MutableIcons.playLarge: (c) => PlayLargeIcon(c),
      MutableIcons.safe: (c) => SafeIcon(c),
      MutableIcons.shield: (c) => ShieldIcon(c),
      MutableIcons.compass: (c) => CompassIcon(c),
      MutableIcons.link: (c) => LinkIcon(c),
      MutableIcons.cameraFlip: (c) => CameraFlipIcon(c),
      MutableIcons.stopRecording: (c) => StopRecordingIcon(c),
      MutableIcons.menu: (c) => MenuIcon(c),
      MutableIcons.calendar: (c) => CalendarIcon(c),
      MutableIcons.location: (c) => LocationIcon(c),
      MutableIcons.cloud: (c) => CloudIcon(c),
      MutableIcons.checkmark: (c) => CheckmarkIcon(c),
      MutableIcons.share: (c) => ShareIcon(c),
      MutableIcons.key: (c) => KeyIcon(c),
      MutableIcons.gear: (c) => GearIcon(c),
      MutableIcons.map: (c) => MapIcon(c),
      MutableIcons.battery: (c) => BatteryIcon(c),
      MutableIcons.camera: (c) => CameraIcon(c),
      MutableIcons.film: (c) => FilmIcon(c),
      MutableIcons.phone: (c) => PhoneIcon(c),
      MutableIcons.caretRight: (c) => CaretRightIcon(c),
      MutableIcons.nextBorderless: (c) => NextBorderlessIcon(c),
      MutableIcons.next: (c) => NextIcon(c),
      MutableIcons.cameraFlipFilled: (c) => CameraFlipFilledIcon(c),
      MutableIcons.cancel: (c) => CancelIcon(c),
      MutableIcons.flashlightFilled: (c) => FlashlightFilledIcon(c),
    };
  }
}
