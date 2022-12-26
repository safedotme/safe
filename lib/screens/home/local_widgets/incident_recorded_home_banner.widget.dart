import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
import 'package:safe/widgets/mutable_home_message.widget.dart/mutable_home_banner.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentRecordedHomeBanner extends StatefulWidget {
  @override
  State<IncidentRecordedHomeBanner> createState() =>
      _IncidentRecordedHomeBannerState();
}

class _IncidentRecordedHomeBannerState
    extends State<IncidentRecordedHomeBanner> {
  late Core core;
  bool imgLoaded = false;
  String name = "";
  String date = "";
  String address = "";
  String? thumbnail;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
    getData();
  }

  void getData() {
    List<Incident>? incidents = core.state.incidentLog.incidents;
    if (incidents == null || incidents.isEmpty) return;

    setState(() {
      thumbnail = incidents.last.thumbnail;
      name = incidents.last.name;
      date = DateFormat.yMd().format(incidents.last.datetime);

      if (incidents.last.location == null) return;

      if (incidents.last.location!.isEmpty ||
          incidents.last.location!.first.address == null) return;

      address = incidents.last.location!.first.address!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MutableHomeBanner(
      header:
          core.utils.language.langMap[core.state.preferences.language]!["home"]
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
                child: thumbnail == null
                    ? SizedBox()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: MutableCachedImage(
                          thumbnail!,
                          shimmerColor: kShimmerAnimationColor.withOpacity(0.3),
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
                      date,
                      size: 13,
                      color: MutableColor.neutral2,
                    ),
                    MutableText(
                      name,
                      size: 15,
                      weight: TypeWeight.bold,
                    ),
                    MutableText(
                      address,
                      size: 13,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
