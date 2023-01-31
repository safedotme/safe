// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

class WebUtil {
  bool isIOS() {
    final userAgent = window.navigator.userAgent.toString().toLowerCase();
    if (userAgent.contains("iphone")) return true;
    if (userAgent.contains("ipad")) return true;

    return false;
  }
}
