import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_home_message.widget.dart/mutable_home_banner.widget.dart';
import 'package:safe/widgets/mutable_pill/mutable_pill.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentLimitHomeBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MutableHomeBanner(
      isShimmering: true,
      shimmerColor: kColorMap[MutableColor.secondaryRed]!.withOpacity(0.75),
      height: 108,
      header: "INCIDENT LIMIT REACHED",
      backgroundColor: MutableColor.secondaryRed,
      borderColor: MutableColor.secondaryRed,
      body: Padding(
        padding: EdgeInsets.only(top: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MutableText(
              "There is a two incident limit per Safe account.",
              weight: TypeWeight.medium,
              size: 13,
              color: MutableColor.neutral2,
            ),
            Row(
              children: [
                MutablePill(
                  isButton: true,
                  text: "Emergency Activate".toUpperCase(),
                  color: MutableColor.secondaryRed,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
