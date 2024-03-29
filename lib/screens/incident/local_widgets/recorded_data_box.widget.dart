import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/neuances.dart';
import 'package:safe/screens/incident/local_widgets/data_point_box.widget.dart';
import 'package:safe/screens/incident/local_widgets/incident_download_box.widget.dart';
import 'package:safe/screens/incident/local_widgets/map_incident_preview.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RecordedDataBox extends StatefulWidget {
  final Incident? incident;
  RecordedDataBox(this.incident);
  @override
  State<RecordedDataBox> createState() => _RecordedDataBoxState();
}

class _RecordedDataBoxState extends State<RecordedDataBox> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  String genDate(DateTime d) {
    return "${DateFormat.yMMMd().format(d)} (${d.timeZoneName})";
  }

  String genTime(DateTime s, DateTime? e) {
    String raw = "";

    raw += DateFormat.Hm().format(s);

    if (e != null) {
      raw += " - ${DateFormat.Hm().format(e)}";
    }
    return raw;
  }

  String genAddress(Incident? i) {
    String base = "";

    if (i == null) return base;
    if (i.location == null) return base;
    if (i.location!.isEmpty) return base;
    if (i.location![0].address == null) return base;

    String address =
        core.utils.geocoder.removeTag(i.location![0].address!) ?? "";

    base = address.substring(0, address.indexOf(","));

    return base;
  }

  Location? checkLocationAvailable(Incident? i) {
    if (i == null) return null;
    if (i.location == null) return null;
    if (i.location!.isEmpty) return null;

    return i.location![0];
  }

  String genLatLng(Incident? i) {
    String base = "";

    var location = checkLocationAvailable(i);

    if (location == null) return base;

    double? lat = location.lat;
    double? long = location.long;

    if (lat == null || long == null) return base;

    base = "{LAT}°N, {LONG}°E";
    lat = double.parse(lat.toStringAsFixed(5));
    long = double.parse(long.toStringAsFixed(5));

    if (lat.isNegative) {
      base = base.replaceAll("N", "S");
    }

    if (long.isNegative) {
      base = base.replaceAll("E", "W");
    }

    return base
        .replaceAll("{LAT}", lat.abs().toString())
        .replaceAll("{LONG}", long.abs().toString());
  }

  bool shoudDisplayMap(Incident? i) {
    if (i == null) return false;
    if (i.location == null) return false;
    if (i.location!.isEmpty) return false;
    if (i.location![0].lat == null || i.location![0].long == null) return false;

    return true;
  }

  String genLocationClipboard(Incident? i) {
    String template = core.utils.language
            .langMap[core.state.preferences.language]!["incident"]
        ["recorded_data"]["location"]["clipboard_msg"];

    var l = checkLocationAvailable(i);

    if (l == null) return "";

    for (var element in [l.address, l.lat, l.long]) {
      if (element == null) return "";
    }

    return template
        .replaceAll(
            "{address}", core.utils.geocoder.removeTag(l.address!) ?? "")
        .replaceAll("{lat}", l.lat.toString())
        .replaceAll("{long}", l.long.toString());
  }

  String? genDatetimeClipboard(Incident? i) {
    String template = core.utils.language
            .langMap[core.state.preferences.language]!["incident"]
        ["recorded_data"]["date"]["clipboard_msg"];

    if (i!.stopTime == null) return null;

    return template
        .replaceAll(
          "{DATE}",
          "${DateFormat.yMMMd().format(i.datetime)} (${i.datetime.timeZoneName})",
        )
        .replaceAll("{TIME_START}", DateFormat.jms().format(i.datetime))
        .replaceAll("{TIME_END}", DateFormat.jms().format(i.stopTime!));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSideScreenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MutableText(
            core
                .utils
                .language
                .langMap[core.state.preferences.language]!["incident"]
                    ["recorded_data"]["header"]
                .toUpperCase(),
            align: TextAlign.left,
            weight: TypeWeight.heavy,
          ),
          SizedBox(height: kIncidentSubheaderToBody),
          DataPointBox(
            header: genAddress(widget.incident),
            subheader: genLatLng(widget.incident),
            keyIcon: MutableIcon(
              MutableIcons.location,
              size: Size(12, 12),
              color: kColorMap[MutableColor.neutral3]!,
            ),
            keyText: core.utils.language
                    .langMap[core.state.preferences.language]!["incident"]
                ["recorded_data"]["location"]["key"],
            onTap: () {
              Clipboard.setData(
                ClipboardData(
                  text: genLocationClipboard(widget.incident),
                ),
              );

              core.state.preferences.actionController.trigger(
                core.utils.language
                        .langMap[core.state.preferences.language]!["incident"]
                    ["recorded_data"]["location"]["copied_msg"]["success"],
                MessageType.success,
              );
            },
            sideWidget: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: shoudDisplayMap(widget.incident)
                  ? MapIncidentPreview(widget.incident)
                  : SizedBox(),
            ),
          ),
          SizedBox(height: kRecordedDataBoxSpacing),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DataPointBox(
                  onTap: () {
                    String? data = genDatetimeClipboard(widget.incident);

                    if (data == null) {
                      core.state.preferences.actionController.trigger(
                        core.utils.language.langMap[
                                core.state.preferences.language]!["incident"]
                            ["recorded_data"]["date"]["copied_msg"]["err"],
                        MessageType.error,
                      );
                      return;
                    }

                    Clipboard.setData(
                      ClipboardData(
                        text: data,
                      ),
                    );

                    core.state.preferences.actionController.trigger(
                      core.utils.language.langMap[
                              core.state.preferences.language]!["incident"]
                          ["recorded_data"]["date"]["copied_msg"]["success"],
                      MessageType.success,
                    );
                  },
                  header: genTime(
                    widget.incident!.datetime,
                    widget.incident!.stopTime,
                  ),
                  subheader: genDate(widget.incident!.datetime),
                  keyIcon: MutableIcon(
                    MutableIcons.calendar,
                    size: Size(12, 11),
                    color: kColorMap[MutableColor.neutral3]!,
                  ),
                  keyText: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["recorded_data"]["date"]["key"],
                ),
              ),
              SizedBox(width: kRecordedDataBoxSpacing),
              Expanded(
                child: DataPointBox(
                  onTap: () {
                    launchUrl(kSecurityInfoUrl);
                  },
                  header: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["recorded_data"]["backup"]["header"],
                  subheader: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["recorded_data"]["backup"]["subheader"],
                  keyIcon: MutableIcon(
                    MutableIcons.cloud,
                    size: Size(16, 11),
                    color: kColorMap[MutableColor.neutral3]!,
                  ),
                  keyText: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["recorded_data"]["backup"]["key"],
                ),
              ),
            ],
          ),
          SizedBox(height: kRecordedDataBoxSpacing),
          IncidentDownloadBox(widget.incident!),
        ],
      ),
    );
  }
}
