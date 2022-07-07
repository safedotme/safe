import 'package:permission_handler/permission_handler.dart';

class PermissionsUtil {
  Future<Map<String, dynamic>> requestLocation() async {
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
          "error": {
            "header": "Warning: you granted low accuracy location",
            "desc":
                "Your exact location can be critical during an incident. Tap to change",
            "fatal": false,
          }
        };
      case PermissionStatus.denied:
        return {
          "status": false,
          "error": {
            "header": "Hold up! You denied location access to Safe",
            "desc":
                "Tap here to learn more about why Safe needs location access",
            "fatal": true,
          }
        };
      case PermissionStatus.permanentlyDenied:
        return {
          "status": false,
          "error": {
            "header": "Hold up! You denied location access to Safe",
            "desc":
                "Change this through settings. Tap here to learn how to do so",
            "fatal": true,
          }
        };
      case PermissionStatus.restricted:
        return {
          "status": false,
          "error": {
            "header": "Hold up! You denied location access to Safe",
            "desc":
                "Change this through settings. Tap here to learn how to do so",
            "fatal": true,
          }
        };
    }
  }

  Future<Map<String, dynamic>> requestMicrophone() async {
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
          "error": {
            "header": "Hold up! You denied microphone access to Safe",
            "desc":
                "Tap here to learn more about why Safe needs microphone access",
            "fatal": true,
          }
        };
      default:
        return {
          "status": false,
          "error": {
            "header": "Hold up! You denied microphone access to Safe",
            "desc":
                "Change this through settings. Tap here to learn how to do so",
            "fatal": true,
          }
        };
    }
  }

  Future<Map<String, dynamic>> requestCamera() async {
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
          "error": {
            "header": "Hold up! You denied camera access to Safe",
            "desc": "Tap here to learn more about why Safe needs camera access",
            "fatal": true,
          }
        };
      default:
        return {
          "status": false,
          "error": {
            "header": "Hold up! You denied camera access to Safe",
            "desc":
                "Change this through settings. Tap here to learn how to do so",
            "fatal": true,
          }
        };
    }
  }
}
