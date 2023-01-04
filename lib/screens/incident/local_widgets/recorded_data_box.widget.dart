import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/screens/incident/local_widgets/data_point_box.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_context_menu/local_widgets/context_menu_body.widget.dart';
import 'package:safe/widgets/mutable_context_menu/local_widgets/context_menu_item.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class RecordedDataBox extends StatefulWidget {
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

    String address = core.utils.geocoder.removeTag(i.location![0].address!);

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

  String genLocationClipboard(Incident? i) {
    String template = "Address: {address}\nLatitude: {lat}\nLongitude:{long}";

    var l = checkLocationAvailable(i);

    if (l == null) return "";

    for (var element in [l.address, l.lat, l.long]) {
      if (element == null) return "";
    }

    return template
        .replaceAll("{address}", core.utils.geocoder.removeTag(l.address!))
        .replaceAll("{lat}", l.lat.toString())
        .replaceAll("{long}", l.long.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSideScreenMargin),
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
          SizedBox(height: 20),
          CupertinoContextMenu(
            actions: [
              ContextMenuBody(
                items: [
                  ContextMenuItem(
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(
                            text: genLocationClipboard(
                          core.state.incident.incident,
                        )),
                      );
                    },
                    text: "Copy",
                    icon: MutableIcon(
                      MutableIcons.link,
                      color: Colors.white,
                      size: Size(18, 18),
                    ),
                  ),
                ],
              ),
            ],
            child: DataPointBox(
              header: genAddress(core.state.incident.incident),
              subheader: genLatLng(core.state.incident.incident),
              keyIcon: MutableIcon(
                MutableIcons.location,
                size: Size(12, 12),
                color: kColorMap[MutableColor.neutral3]!,
              ),
              keyText: core.utils.language
                      .langMap[core.state.preferences.language]!["incident"]
                  ["recorded_data"]["location"]["key"],
              onTap: () {
                // TODO: Open map view
              },
              sideWidget: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 84,
                  width: 115,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(37.3346 + 0.007, -122.0090 + 0.001),
                      zoom: 13.5,
                    ),
                    padding: EdgeInsets.only(bottom: 100, left: 15),
                    // ignore: prefer_collection_literals
                    markers: [
                      Marker(
                        markerId: MarkerId("test"),
                        position: LatLng(37.3346, -122.0090),
                      ),
                    ].toSet(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DataPointBox(
                  header: genTime(
                    core.state.incident.incident!.datetime,
                    core.state.incident.incident!.stopTime,
                  ),
                  subheader: genDate(core.state.incident.incident!.datetime),
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
              SizedBox(width: 14),
              Expanded(
                child: DataPointBox(
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
          SizedBox(height: 100)
        ],
      ),
    );
  }
}
