import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
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

  Map<String, dynamic> getData(List<Incident>? incidents) {
    Map<String, dynamic> data = {};

    if (incidents == null || incidents.isEmpty) return data;

    data["thumbnai;"] = incidents.last.thumbnail;
    data["name"] = incidents.last.name;
    data["date"] = DateFormat.yMd().format(incidents.last.datetime);

    if (incidents.last.location == null) return data;

    if (incidents.last.location!.isEmpty ||
        incidents.last.location!.first.address == null) return data;

    data["address"] =
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
            ["incident_recorded_header"],
        height: 125,
        onTap: () {
          print("IMPLEMENT ME");
          // ADD ONTAP LOGIC
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
                    borderRadius: BorderRadius.circular(4),
                    color: kColorMap[MutableColor.neutral9],
                  ),
                  child: getData(
                            core.state.incidentLog.incidents,
                          )["thumbnail"] ==
                          null
                      ? SizedBox()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: MutableCachedImage(
                            getData(
                              core.state.incidentLog.incidents,
                            )["thumbnail"]!,
                            shimmerColor:
                                kShimmerAnimationColor.withOpacity(0.3),
                            backgroundColor: kColorMap[MutableColor.neutral9]!,
                          ),
                        ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MutableText(
                        getData(core.state.incidentLog.incidents)["date"] ?? "",
                        size: 13,
                        color: MutableColor.neutral2,
                      ),
                      MutableText(
                        getData(core.state.incidentLog.incidents)["name"] ?? "",
                        size: 15,
                        weight: TypeWeight.bold,
                      ),
                      MutableText(
                        getData(core.state.incidentLog.incidents)["address"] ??
                            "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
