import 'package:safe/utils/animation/animation.util.dart';
import 'package:safe/utils/capture/capture.util.dart';
import 'package:safe/utils/color/color.util.dart';
import 'package:safe/utils/credit/credit.util.dart';
import 'package:safe/utils/flows/flows.dart';
import 'package:safe/utils/geocoder/geocoder.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/utils/incident/incident.util.dart';
import 'package:safe/utils/language/language.util.dart';
import 'package:safe/utils/map/map.util.dart';
import 'package:safe/utils/name/name.util.dart';
import 'package:safe/utils/phone/phone.util.dart';
import 'package:safe/utils/popup_navigation/popup_navigation.util.dart';
import 'package:safe/utils/text/text.util.dart';

class Utils {
  ColorUtils color = ColorUtils();
  LanguageUtil language = LanguageUtil()..initMap();
  Flows flows = Flows();
  IconUtil icons = IconUtil()..init();
  PopupNavigationUtil popupNavigation = PopupNavigationUtil();
  PhoneUtil phone = PhoneUtil();
  TextUtil text = TextUtil();
  AnimationUtil animation = AnimationUtil();
  NameUtil name = NameUtil();
  CaptureUtil capture = CaptureUtil();
  CreditUtil credit = CreditUtil();
  GeocoderUtil geocoder = GeocoderUtil();
  IncidentUtil incident = IncidentUtil();
  MapUtil map = MapUtil();
}
