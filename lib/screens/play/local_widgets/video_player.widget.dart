import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/screens/play/local_widgets/video_player_loader.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:video_player/video_player.dart' as api;

class VideoPlayer extends StatefulWidget {
  final Incident incident;

  VideoPlayer(this.incident);
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late Core core;
  bool loading = true;

  // ⬇️ MASTER STATE
  List<Battery> batteryLog = [];
  List<Location> locationLog = [];

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    // ⬇️ Load External State (battery, location, etc...)
    loadState();

    // ⬇️ Load Video
    load();
  }

  void load() async {
    bool ok = await core.utils.play.initializeVideoPlayer();

    if (!ok) return;

    core.state.incident.player!.addListener(() {
      if (core.state.incident.player!.value.isInitialized && loading) {
        loading = false;
        core.state.incident.player!.play();

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() {});
        });
      }

      refreshState();
    });
  }

  void loadState() {
    batteryLog = widget.incident.battery ?? [];
    locationLog = widget.incident.location ?? [];

    batteryLog.sort(
      (a, b) => a.datetime.compareTo(b.datetime),
    );

    locationLog.sort(
      (a, b) => a.datetime.compareTo(b.datetime),
    );
  }

  void refreshState() {
    // ⬇️ Update State Values
    if (core.state.incident.player!.value.isBuffering) return;
    if (!core.state.incident.player!.value.isInitialized) return;
    if (!mounted) return;

    var position = core.state.incident.player!.value.position;
    var datetimePointer = widget.incident.datetime.add(position);

    // ⬇️ SET DATETIME
    String time = core.utils.play.parseTime(position);
    core.state.incident.setPlayTime(time);

    String date = core.utils.play.parseDate(datetimePointer);
    core.state.incident.setPlayDate(date);

    // ⬇️ SET BATTERY
    Battery? battery = core.utils.play.fetchLatestBattery(
      datetimePointer,
      batteryLog,
    );
    core.state.incident.setPlayBattery(
      core.utils.play.parseBattery(battery),
    );

    // ⬇️ SETLOCATION
    Location? location = core.utils.play.fetchLatestLocation(
      datetimePointer,
      locationLog,
    );
    core.state.incident.setPlaySpeed(
      core.utils.play.parseSpeed(location),
    );

    if (location != null) {
      var pos = LatLng(location.lat!, location.long!);

      core.state.incident.setPlayPosition(pos);

      core.state.incident.mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: kMapZoom,
            target: LatLng(
              location.lat! + kMapPaddingCompensation,
              location.long!,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 720 / 1080,
      child: Stack(
        children: [
          loading ? SizedBox() : api.VideoPlayer(core.state.incident.player!),
          AnimatedOpacity(
            opacity: core.state.incident.player == null ? 1 : 0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeIn,
            child: VideoPlayerLoader(widget.incident),
          ),
        ],
      ),
    );
  }
}
