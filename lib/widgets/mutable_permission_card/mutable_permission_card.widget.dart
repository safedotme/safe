import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_permission_card/local_widgets/status_circle.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

enum PermissionType {
  microphone,
  camera,
  location,
}

class PermissionData {
  final bool isEnabled;
  final PermissionType type;
  final Map? error;

  PermissionData({
    required this.isEnabled,
    this.error,
    required this.type,
  });
}

class MutablePermissionCard extends StatefulWidget {
  final PermissionType type;
  final void Function()? navigate;

  static const List<PermissionType> permissionList = [
    PermissionType.microphone,
    PermissionType.camera,
    PermissionType.location
  ];

  MutablePermissionCard({
    required this.type,
    this.navigate,
  });

  @override
  State<MutablePermissionCard> createState() => _MutablePermissionCardState();
}

class _MutablePermissionCardState extends State<MutablePermissionCard> {
  late Core core;
  bool isAllowed = false;
  bool processing = false;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);

    fetchPermissions(false);
  }

  Future<PermissionData> fetchPermissions(bool request) async {
    late Map response;

    switch (widget.type) {
      case PermissionType.camera:
        response = await core.services.permissions.requestCamera(core, request);
        break;
      case PermissionType.location:
        response =
            await core.services.permissions.requestLocation(core, request);
        break;
      case PermissionType.microphone:
        response =
            await core.services.permissions.requestMicrophone(core, request);
        break;
    }

    PermissionData data = PermissionData(
      isEnabled: response["status"],
      type: widget.type,
      error: response["error"],
    );

    core.state.auth.setPermission(widget.type, data);

    if (mounted) {
      setState(() {
        isAllowed = data.isEnabled;
      });
    }

    return data;
  }

  Future<void> handleTap() async {
    if (processing) {
      return;
    }

    processing = true;
    PermissionData data = await fetchPermissions(true);
    processing = false;

    // HANDLE ERROR
    if (!data.isEnabled) {
      core.services.permissions.errorBanner(core, widget.type);
      return;
    }

    // Check permissions
    bool hasPermissions = core.services.permissions.checkPermissions(
      core,
      sendError: false,
    );

    if ((widget.navigate != null) && hasPermissions) {
      widget.navigate!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MutableButton(
        onTap: () {
          handleTap();
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: ShapeDecoration(
            color: kColorMap[MutableColor.neutral8],
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerSmoothing: kCornerSmoothing,
                cornerRadius: 12,
              ),
              side: BorderSide(
                width: kBorderWidth,
                color: kColorMap[MutableColor.neutral7]!,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MutableText(
                    core.utils.language
                            .langMap[core.state.preferences.language]!["auth"]
                        ["permissions"]["cards"][widget.type]["header"],
                    size: 15,
                    weight: TypeWeight.bold,
                  ),
                  SizedBox(height: 5),
                  MutableText(
                    core.utils.language
                            .langMap[core.state.preferences.language]!["auth"]
                        ["permissions"]["cards"][widget.type]["desc"],
                    color: MutableColor.neutral2,
                    size: 13,
                  ),
                ],
              ),
              StatusCircle(isAllowed),
            ],
          ),
        ),
      ),
    );
  }
}
