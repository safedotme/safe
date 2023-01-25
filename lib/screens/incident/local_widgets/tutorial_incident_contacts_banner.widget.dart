import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class TutorialIncidentContactsBanner extends StatefulWidget {
  @override
  State<TutorialIncidentContactsBanner> createState() =>
      _TutorialIncidentContactsBannerState();
}

class _TutorialIncidentContactsBannerState
    extends State<TutorialIncidentContactsBanner> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

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
              core.utils.language
                      .langMap[core.state.preferences.language]!["incident"]
                  ["tutorial_contact_warning"]["header"],
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
