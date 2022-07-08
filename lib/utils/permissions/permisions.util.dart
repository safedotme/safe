import 'package:permission_handler/permission_handler.dart';
import 'package:safe/core.dart';

class PermissionsUtil {
  Future<Map<String, dynamic>> requestLocation(Core core) async {
    PermissionStatus status = await Permission.locationWhenInUse.status;

    if (status == PermissionStatus.denied) {
      status = await Permission.locationWhenInUse.request();
    }

    switch (status) {
      case PermissionStatus.granted:
        return {
          "status": true,
        };
      case PermissionStatus.limited:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"]["location"]["limited"]
        };
      case PermissionStatus.denied:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"]["location"]["denied"]
        };
      case PermissionStatus.permanentlyDenied:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"]["location"]["default"]
        };
      case PermissionStatus.restricted:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"]["location"]["default"],
        };
    }
  }

  Future<Map<String, dynamic>> requestMicrophone(Core core) async {
    PermissionStatus status = await Permission.microphone.status;

    if (status == PermissionStatus.denied) {
      status = await Permission.microphone.request();
    }

    switch (status) {
      case PermissionStatus.granted:
        return {
          "status": true,
        };
      case PermissionStatus.denied:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"]["location"]["denied"]
        };
      default:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"]["location"]["default"]
        };
    }
  }

  Future<Map<String, dynamic>> requestCamera(Core core) async {
    PermissionStatus status = await Permission.camera.status;

    if (status == PermissionStatus.denied) {
      status = await Permission.camera.request();
    }

    switch (status) {
      case PermissionStatus.granted:
        return {
          "status": true,
        };
      case PermissionStatus.denied:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"]["location"]["denied"],
        };
      default:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"]["location"]["default"],
        };
    }
  }
}
