import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';
import 'package:safe/core.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_permission_card/mutable_permission_card.widget.dart';

class PermissionsService {
  Future<List<Permission>> getDisabledPermissions(Core core) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    List<Permission> disabled = [];

    for (Permission key in statuses.keys) {
      if (!(_determinePermissionFollowthrough(statuses[key]))) {
        disabled.add(key);
      }
    }

    var locationStatus = await location.Location().requestPermission();

    if (!(locationStatus == location.PermissionStatus.granted ||
        locationStatus == location.PermissionStatus.grantedLimited)) {
      disabled.add(Permission.locationWhenInUse);
    }

    return disabled;
  }

  bool _determinePermissionFollowthrough(PermissionStatus? s) =>
      s == PermissionStatus.granted || s == PermissionStatus.provisional;

  Future<bool> checkContactPermission(
    Core core, {
    void Function()? onError,
  }) async {
    PermissionStatus status = await Permission.contacts.status;

    if (status == PermissionStatus.granted) return true;

    status = await Permission.contacts.request();

    if (status == PermissionStatus.granted) return true;

    onError?.call();
    return false;
  }

  bool checkPermissions(Core core, {required bool sendError}) {
    List<PermissionType> errors = [];
    Map<PermissionType, PermissionData> permissions =
        core.state.auth.permissionMap;

    // Checks that all permission cards have been initialized
    if (permissions.keys.length !=
        MutablePermissionCard.permissionList.length) {
      return false;
    }

    // Itterate through and check for errors
    for (PermissionType type in permissions.keys) {
      if (permissions[type]!.error != null) {
        errors.add(type);
      }
    }

    // Sends an error if necessary
    if (errors.isNotEmpty && sendError) {
      errorBanner(core, errors[0]);
    }

    return errors.isEmpty;
  }

  void errorBanner(Core core, PermissionType permission) {
    if (core.state.auth.permissionMap[permission]!.error == null) {
      return;
    }

    //Maps error to specific message
    Map response = core.state.auth.permissionMap[permission]!.error!;
    core.state.auth.setBannerState(
      response["fatal"] ? MessageType.error : MessageType.warning,
    );

    // Sets properties for banner
    core.state.auth.setBannerTitle(response["header"]);
    core.state.auth.setBannerMessage(response["desc"]);
    core.state.auth.setOnBannerTap(() {
      // Opens app settings when tapped
      openAppSettings();
    });
    core.state.auth.bannerController.show();
  }

  Future<bool> requestContact() async {
    final check = await Permission.contacts.isGranted;

    if (check) return true;

    final res = await Permission.contacts.request();

    if (res.isGranted) return true;

    return false;
  }

  Future<Map<String, dynamic>> requestLocation(Core core, bool request) async {
    PermissionStatus status = await Permission.locationWhenInUse.status;

    // Permission status defaults to denied
    if (request && status == PermissionStatus.denied) {
      var requestedStatus = await location.Location().requestPermission();

      status = requestedStatus == location.PermissionStatus.granted ||
              requestedStatus == location.PermissionStatus.grantedLimited
          ? PermissionStatus.granted
          : PermissionStatus.denied;
    }

    switch (status) {
      case PermissionStatus.granted:
        return {
          "status": true,
        };
      case PermissionStatus.provisional:
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

  Future<Map<String, dynamic>> requestMicrophone(
      Core core, bool request) async {
    PermissionStatus status = await Permission.microphone.status;

    if (request && status == PermissionStatus.denied) {
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

  Future<Map<String, dynamic>> requestCamera(Core core, bool request) async {
    PermissionStatus status = await Permission.camera.status;

    if (request && status == PermissionStatus.denied) {
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
