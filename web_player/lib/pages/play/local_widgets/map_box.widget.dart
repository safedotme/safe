import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';

class MapBox extends StatefulWidget {
  @override
  State<MapBox> createState() => _MapBoxState();
}

class _MapBoxState extends State<MapBox> {
  late Core core;
  bool loaded = false;
  LatLng? initPos;
  LatLng? current;
  Set<Marker> markers = {};
  BitmapDescriptor? d;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    initializePos();
    setCustomMarker();
  }

  Future<void> setCustomMarker() async {
    if (initPos == null) return;

    var bytes = await core.utils.map.getBytesFromAsset(
      "assets/images/marker.png",
      80,
    );

    if (bytes == null) return;

    var data = BitmapDescriptor.fromBytes(bytes);

    d = data;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        markers = {
          Marker(
            markerId: MarkerId("${initPos!.latitude}:${initPos!.longitude}"),
            icon: data,
            position: initPos!,
          ),
        };
      });
    });
  }

  void initializePos() {
    final i = core.state.play.incident;

    if (i == null) return;

    if (i.location == null || i.location!.isEmpty) return;

    i.location!.sort(
      (a, b) => a.datetime.compareTo(b.datetime),
    );

    final latest = i.location!.last;

    if (latest.lat == null || latest.long == null) return;

    final pos = LatLng(latest.lat!, latest.long!);

    initPos = pos;
    loaded = true;
    current = pos;
  }

  void listen(Incident? i) async {
    if (!loaded) return;

    final i = core.state.play.incident;

    if (i == null) return;

    if (i.location == null || i.location!.isEmpty) return;

    i.location!.sort(
      (a, b) => a.datetime.compareTo(b.datetime),
    );

    final latest = i.location!.last;

    if (latest.lat == null || latest.long == null) return;

    if (!(latest.lat! != current!.latitude ||
        latest.long! != current!.longitude)) {
      return;
    }
    final pos = LatLng(latest.lat!, latest.long!);
    current = pos;

    if (d == null) return;

    core.state.play.mapController!.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        zoom: kMapZoom,
        target: pos,
      )),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        markers = {
          Marker(
            markerId: MarkerId("${pos.latitude}:${pos.longitude}"),
            icon: d!,
            position: pos,
          ),
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Observer(
      builder: (_) {
        listen(core.state.play.incident);
        return loaded
            ? Positioned(
                bottom: -kMapControlSize,
                child: SizedBox(
                  height: queryData.size.height + kMapControlSize,
                  width: queryData.size.width,
                  child: GoogleMap(
                    rotateGesturesEnabled: !(queryData.size.width < 500 ||
                        queryData.size.height < 500),
                    scrollGesturesEnabled: !(queryData.size.width < 500 ||
                        queryData.size.height < 500),
                    zoomControlsEnabled: !(queryData.size.width < 500 ||
                        queryData.size.height < 500),
                    zoomGesturesEnabled: !(queryData.size.width < 500 ||
                        queryData.size.height < 500),
                    tiltGesturesEnabled: !(queryData.size.width < 500 ||
                        queryData.size.height < 500),
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
                      target: initPos!,
                    ),
                    markers: markers,
                  ),
                ),
              )
            : SizedBox();
      },
    );
  }
}
