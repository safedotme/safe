import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_body.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_image.widget.dart';

class MutableIncidentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: [Container(), Container()], // Add Actions later
      child: MutableButton(
        child: Container(
          height: 270,
          decoration: BoxDecoration(
            color: kColorMap[MutableColor.neutral9],
            borderRadius: BorderRadius.circular(6), // Extract
            border: Border.all(
              width: kBorderWidth,
              color: kColorMap[MutableColor.neutral7]!,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6), // Extract
            child: Column(
              children: [
                Expanded(
                  flex: 11,
                  child: IncidentCardImage(),
                ),
                Expanded(
                  flex: 7,
                  child: IncidentCardBody(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
