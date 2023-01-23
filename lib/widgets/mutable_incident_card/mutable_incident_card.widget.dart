import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_body.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_image.widget.dart';

class MutableIncidentCard extends StatefulWidget {
  final Incident incident;

  MutableIncidentCard(this.incident);

  @override
  State<MutableIncidentCard> createState() => _MutableIncidentCardState();
}

class _MutableIncidentCardState extends State<MutableIncidentCard> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  Future<bool> authenticate() async {
    bool auth = core.state.preferences.biometricsEnabled ?? false;

    if (auth) {
      bool passed = await core.services.localAuth.authenticate(
        core.utils.language
                .langMap[core.state.preferences.language]!["incident"]["auth"]
            ["reason"],
      );

      if (!passed) {
        core.state.preferences.actionController.trigger(
          core.utils.language
                  .langMap[core.state.preferences.language]!["incident"]["auth"]
              ["error"],
          MessageType.error,
        );

        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MutableButton(
      onTap: () async {
        bool pass = await authenticate();

        if (!pass) return;

        core.state.incident.setIncidentId(widget.incident.id);
        core.state.incident.controller.open();
      },
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
                widget.incident,
                onPlayTap: () async {
                  bool pass = await authenticate();

                  if (!pass) return;

                  core.state.incident.setIncidentId(widget.incident.id);
                  core.state.incident.playController.open();
                },
              ),
              IncidentCardBody(widget.incident),
            ],
          ),
        ),
      ),
    );
  }
}
