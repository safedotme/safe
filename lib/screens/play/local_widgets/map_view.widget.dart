import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';

class MapView extends StatefulWidget {
  final Incident incident;

  MapView(this.incident);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late Core core;
  BitmapDescriptor? marker;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    setCustomMarker();
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
    return GoogleMap(
      onMapCreated: (c) async {
        core.state.incident.setMapController(c);
        // Set Map Style
        String style = await rootBundle.loadString(
          'assets/map/style_labeled.txt',
        );

        core.state.incident.mapController!.setMapStyle(style);
      },
      initialCameraPosition: CameraPosition(
        zoom: 16,
        target: LatLng(37.3346 + 0.0045, -122.0090),
      ),
      padding: EdgeInsets.only(bottom: 500),
      markers: {
        Marker(
          markerId: MarkerId("user"),
          icon: marker ?? BitmapDescriptor.defaultMarker,
          position: LatLng(
            37.3346,
            -122.0090,
          ),
        ),
      },
    );
  }
}
