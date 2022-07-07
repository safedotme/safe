import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_permission_card/local_widgets/status_circle.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

enum PermissionType {
  microphone,
  camera,
  location,
}

class MutablePermissionCard extends StatelessWidget {
  final PermissionType type;

  MutablePermissionCard({
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
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
                  "Microphone",
                  size: 15,
                  weight: TypeWeight.bold,
                ),
                SizedBox(height: 5),
                MutableText(
                  "To record and stream your incidents",
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
  }
}
