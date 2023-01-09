import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
  BitmapDescriptor? marker;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    setCustomStyle();

    setCustomMarker();
  }

  void setCustomStyle() {
    if (core.state.incident.mapStyle != null) return;

    rootBundle.loadString('assets/map/style_unlabeled.txt').then((string) {
      core.state.incident.setMapStyle(string);
    });
  }

  Future<void> setCustomMarker() async {
    var bytes = await core.utils.map.getBytesFromAsset(
      "assets/images/marker.png",
      80,
    );

    if (bytes == null) return;

    var data = BitmapDescriptor.fromBytes(bytes);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        marker = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        color: kColorMap[MutableColor.mapBackground],
        height: 84,
        width: 115,
        child: GoogleMap(
          compassEnabled: false,
          mapType: MapType.normal,
          zoomControlsEnabled: false,
          onMapCreated: (c) {
            c.setMapStyle(core.state.incident.mapStyle);
          },
          myLocationEnabled: false,
          scrollGesturesEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              core.state.incident.incident!.location![0].lat! + 0.0013,
              core.state.incident.incident!.location![0].long! + 0.0001,
            ),
            zoom: 16,
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
      ),
    );
  }
}
