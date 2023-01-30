import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MapBox extends StatefulWidget {
  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
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
      30,
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
    var queryData = MediaQuery.of(context);
    return Positioned(
      bottom: -kMapControlSize,
      child: SizedBox(
        height: queryData.size.height + kMapControlSize,
        width: queryData.size.width,
        child: GoogleMap(
          onMapCreated: (c) async {
            core.state.play.setMapController(c);
            // Set Map Style
            String style = await rootBundle.loadString(
              'assets/map/style_labeled.txt',
            );

            core.state.play.mapController!.setMapStyle(style);
          },
          initialCameraPosition: CameraPosition(
            zoom: kMapZoom,
            target: LatLng(
              37.3346,
              -122.0090,
            ),
          ),
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
        ),
      ),
    );
  }
}
