import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:flutter/services.dart' show rootBundle;

class MapIncidentPreview extends StatefulWidget {
  @override
  State<MapIncidentPreview> createState() => _MapIncidentPreviewState();
}

class _MapIncidentPreviewState extends State<MapIncidentPreview> {
  late Core core;
  late String style;
  BitmapDescriptor? marker;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    rootBundle.loadString('assets/map/style_unlabeled.txt').then((string) {
      style = string;
    });

    setCustomMarker();
  }

  Future<void> setCustomMarker() async {
    var bytes = await core.utils.map.getBytesFromAsset(
      "assets/images/marker.png",
      80,
    );

    if (bytes == null) return;

    var data = BitmapDescriptor.fromBytes(bytes);

    setState(() {
      marker = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 84,
      width: 115,
      child: GoogleMap(
        compassEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (c) {
          c.setMapStyle(style);
        },
        myLocationEnabled: false,
        scrollGesturesEnabled: false,
        rotateGesturesEnabled: false,
        tiltGesturesEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            core.state.incident.incident!.location![0].lat! + kLatAddition,
            core.state.incident.incident!.location![0].long! + kLongAddition,
          ),
          zoom: kMapZoom,
        ),
        padding: kMapPadding,
        // ignore: prefer_collection_literals
        markers: [
          Marker(
            markerId: MarkerId("user"),
            icon: marker ?? BitmapDescriptor.defaultMarker,
            position: LatLng(
              core.state.incident.incident!.location![0].lat!,
              core.state.incident.incident!.location![0].long!,
            ),
          ),
        ].toSet(),
      ),
    );
  }
}
