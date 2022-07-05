import 'package:logger/logger.dart';
import 'package:safe/utils/color/color.util.dart';
import 'package:safe/utils/language/language.util.dart';

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
}
