import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_banner/mutable_banner.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

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

  bool handleCanLoad(LatLng? marker) {
    bool cl = canLoad(marker);

    if (!cl) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        core.state.preferences.actionController.trigger(
          "Unable to load location.", // TODO: Extract
          MessageType.error,
          wait: Duration(seconds: 6),
        );
      });
    }

    return cl;
  }

  bool canLoad(LatLng? marker) {
    List<Location>? l = widget.incident.location;

    if (l == null) return false;
    if (l.isEmpty) return false;
    if (marker == null) return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Observer(
      builder: (_) => !handleCanLoad(core.state.incident.playPosition)
          ? SizedBox()
          : GoogleMap(
              onMapCreated: (c) async {
                core.state.incident.setMapController(c);
                // Set Map Style
                String style = await rootBundle.loadString(
                  'assets/map/style_labeled.txt',
                );

                core.state.incident.mapController!.setMapStyle(style);
              },
              padding: EdgeInsets.only(bottom: 500),
              initialCameraPosition: CameraPosition(
                zoom: kMapZoom,
                target: LatLng(
                  widget.incident.location!.first.lat! +
                      kMapPaddingCompensation,
                  widget.incident.location!.first.long!,
                ),
              ),
              markers: {
                Marker(
                  markerId: MarkerId("user"),
                  icon: marker ?? BitmapDescriptor.defaultMarker,
                  position: core.state.incident.playPosition!,
                ),
              },
            ),
    );
  }
}
