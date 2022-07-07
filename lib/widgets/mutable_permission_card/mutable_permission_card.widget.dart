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

class MutablePermissionCard extends StatefulWidget {
  final PermissionType type;

  static const List<PermissionType> permissionList = [
    PermissionType.microphone,
    PermissionType.camera,
    PermissionType.location
  ];

  MutablePermissionCard({
    required this.type,
  });

  @override
  State<MutablePermissionCard> createState() => _MutablePermissionCardState();
}

class _MutablePermissionCardState extends State<MutablePermissionCard> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return MutableButton(
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
              StatusCircle(true)
            ],
          ),
        ),
      );
    });
  }
}
