import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_home_message.widget.dart/mutable_home_banner.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class IncidentRecordedHomeBanner extends StatefulWidget {
  @override
  State<IncidentRecordedHomeBanner> createState() =>
      _IncidentRecordedHomeBannerState();
}

class _IncidentRecordedHomeBannerState
    extends State<IncidentRecordedHomeBanner> {
  late Core core;
  bool imgLoaded = false;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  Map<String, dynamic> getData(List<Incident>? incidents, String? error) {
    Map<String, dynamic> data = {};

    if (error != null) {
      return {"body": error};
    }

    if (incidents == null || incidents.isEmpty) return data;

    data["name"] = incidents.last.name;
    data["date"] = DateFormat.yMd().format(incidents.last.datetime);

    if (incidents.last.location == null) return data;

    if (incidents.last.location!.isEmpty ||
        incidents.last.location!.first.address == null) return data;

    data["body"] =
        core.utils.geocoder.removeTag(incidents.last.location!.first.address!);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => MutableHomeBanner(
        state: PanelState.CLOSED,
        controller: core.state.capture.incidentRecordedBannerPanelController,
        header: core.utils.language
                    .langMap[core.state.preferences.language]!["home"]
                ["incident_recorded_header"]
            [core.state.capture.errorCapturing != null],
        height: 125,
        onTap: () {
          if (core.state.incidentLog.incidents == null) {
            // LOG
            return;
          }

          if (core.state.incidentLog.incidents!.isEmpty) {
            // LOG
            return;
          }

          core.state.incident.setIncidentId(
            core.state.incidentLog.incidents!.last.id,
          );

          core.state.incident.controller.open();
        },
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kColorMap[core.state.capture.errorCapturing == null
                            ? MutableColor.secondaryGreen
                            : MutableColor.secondaryYellow]!
                        .withOpacity(0.10),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/images/${core.state.capture.errorCapturing == null ? "checkmark" : "warning"}.png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: core.state.capture.errorCapturing == null,
                        child: MutableText(
                          getData(
                                core.state.incidentLog.incidents,
                                core.state.capture.errorCapturing,
                              )["date"] ??
                              "",
                          size: 13,
                          color: MutableColor.neutral2,
                        ),
                      ),
                      Visibility(
                        visible: core.state.capture.errorCapturing == null,
                        child: Spacer(),
                      ),
                      Visibility(
                        visible: core.state.capture.errorCapturing == null,
                        child: MutableText(
                          getData(
                                core.state.incidentLog.incidents,
                                core.state.capture.errorCapturing,
                              )["name"] ??
                              "",
                          size: 15,
                          weight: TypeWeight.bold,
                        ),
                      ),
                      Visibility(
                        visible: core.state.capture.errorCapturing == null,
                        child: Spacer(),
                      ),
                      MutableText(
                        getData(
                              core.state.incidentLog.incidents,
                              core.state.capture.errorCapturing,
                            )["body"] ??
                            "",
                        overflow: core.state.capture.errorCapturing == null
                            ? TextOverflow.ellipsis
                            : null,
                        maxLines: core.state.capture.errorCapturing == null
                            ? 1
                            : null,
                        size: 13,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
