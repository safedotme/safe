import 'package:flutter/material.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_body.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_image.widget.dart';

class MutableIncidentCard extends StatelessWidget {
  final Incident incident;

  MutableIncidentCard(this.incident);

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      child: Container(
        decoration: BoxDecoration(
          color: kColorMap[kIncidentCardBgColor],
          borderRadius: BorderRadius.circular(kIncidentCardBorderRadius),
          border: Border.all(
            width: kBorderWidth,
            color: kColorMap[kIncidentCardBorderColor]!,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kIncidentCardBorderRadius),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IncidentCardImage(
                incident,
                onPlayTap: () {
                  print("play");
                },
                onMenuTap: () {
                  print("menu");
                },
              ),
              IncidentCardBody(incident),
            ],
          ),
        ),
      ),
    );
  }
}
