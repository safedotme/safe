import 'package:logger/logger.dart';
import 'package:safe/utils/color/color.util.dart';
import 'package:safe/utils/flows/flows.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/utils/language/language.util.dart';
import 'package:safe/utils/popup_navigation/popup_navigation.util.dart';

class Utils {
  ColorUtils color = ColorUtils();
  Logger log = Logger(
    printer: PrettyPrinter(
        lineLength: 80, // Width of the output
        colors: true, // Colorful log messages
        printEmojis: true, // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );
  LanguageUtil language = LanguageUtil()..initMap();
  Flows flows = Flows();
  IconUtil icons = IconUtil()..init();
  PopupNavigationUtil popupNavigation = PopupNavigationUtil();
}
