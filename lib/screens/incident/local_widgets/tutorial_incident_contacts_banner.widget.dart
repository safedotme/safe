import 'package:flutter/material.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

import '../../../utils/constants/constants.util.dart';

class TutorialIncidentContactsBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kHomeBannerBorderRadius),
          border: Border.all(
            width: kBorderWidth,
            color: kColorMap[MutableColor.neutral8]!,
          ),
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MutableText(
              "⚠️ NOTE", // TODO: Extract
              align: TextAlign.left,
              size: 14,
              weight: TypeWeight.bold,
              color: MutableColor.neutral2,
            ),
            SizedBox(height: 5),
            MutableText(
              "These contacts were not notified as the incident was a tutorial. They would have been notified if it weren’t.",
              align: TextAlign.left,
              color: MutableColor.neutral2,
              size: 13,
            ),
          ],
        ),
      ),
    );
  }
}
