import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/location.model.dart';

class PlayerUtil {
  String? parseBattery(Battery? battery) {
    if (battery == null) return null;

    String state = "${(battery.percentage * 100).round()}% ({STATE})";

    if (battery.percentage < 0.1) {
      return state.replaceAll(
        "{STATE}",
        "CRITICAL",
      );
    }

    if (battery.percentage < 0.2) {
      return state.replaceAll(
        "{STATE}",
        "LOW",
      );
    }

    if (battery.percentage < 0.8) {
      return state.replaceAll(
        "{STATE}",
        "NORMAL",
      );
    }

    return state.replaceAll(
      "{STATE}",
      "HIGH",
    );
  }

  String? parseSpeed(Location? l) {
    if (l == null) return null;
    if (l.speed == null) return null;
    if (l.speed! < 0) return "0 KM/H";

    String speed = (l.speed! * 3.6).toString();

    if (!speed.contains(".")) {
      return "$speed.0 KM/H";
    }

    return "${speed.substring(0, speed.indexOf(".") + 1)} KM/H";
  }
}
