import 'package:permission_handler/permission_handler.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_permission_card/mutable_permission_card.widget.dart';

class PermissionsUtil {
  Future<bool> checkPermissions() async {
    // IMPLEMENT

    return false;
  }

  void errorBanner(Core core) {
    // Finds error
    PermissionType key = core.state.signup.permissionsErrors.keys.toList()[0];

    //Maps error to specific message
    Map response = core.state.signup.permissionsErrors[key]!;
    core.state.signup.setBannerState(
      response["error"]["fatal"] ? MessageType.error : MessageType.warning,
    );

    // Sets properties for banner
    core.state.signup.setBannerTitle(response["error"]["header"]);
    core.state.signup.setBannerMessage(response["error"]["desc"]);
    core.state.signup.setOnBannerTap(() {
      // Opens app settings when clicked
      openAppSettings();
    });
    core.state.signup.bannerController.show();
  }

  Future<Map<String, dynamic>> requestLocation(Core core) async {
    PermissionStatus status = await Permission.locationWhenInUse.status;

    // Permission status defaults to denied
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
              ["permissions"]["errors"][PermissionType.location]["limited"]
        };
      case PermissionStatus.denied:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"][PermissionType.location]["denied"]
        };
      case PermissionStatus.permanentlyDenied:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"][PermissionType.location]["default"]
        };
      case PermissionStatus.restricted:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"][PermissionType.location]["default"]
        };
    }
  }

  Future<Map<String, dynamic>> requestMicrophone(Core core) async {
    PermissionStatus status = await Permission.microphone.status;

    if (status == PermissionStatus.denied) {
      // Permission status defaults to denied
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
              ["permissions"]["errors"][PermissionType.microphone]["denied"]
        };
      default:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"][PermissionType.microphone]["default"]
        };
    }
  }

  Future<Map<String, dynamic>> requestCamera(Core core) async {
    PermissionStatus status = await Permission.camera.status;

    if (status == PermissionStatus.denied) {
      // Permission status defaults to denied
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
              ["permissions"]["errors"][PermissionType.camera]["denied"],
        };
      default:
        return {
          "status": false,
          "error": core.utils.language
                  .langMap[core.state.preferences.language]!["auth"]
              ["permissions"]["errors"][PermissionType.camera]["default"],
        };
    }
  }
}
