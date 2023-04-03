import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/pages/play/local_widgets/error_banner.widget.dart';
import 'package:safe/pages/play/local_widgets/gradient_overlay.widget.dart';
import 'package:safe/pages/play/local_widgets/incident_data_box.widget.dart';
import 'package:safe/pages/play/local_widgets/map_box.widget.dart';
import 'package:safe/pages/play/local_widgets/player_data_column.widget.dart';
import 'package:safe/pages/play/local_widgets/stream_view.widget.dart';

class PlayBody extends StatefulWidget {
  @override
  State<PlayBody> createState() => _PlayBodyState();
}

class _PlayBodyState extends State<PlayBody> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Container(
      padding: EdgeInsets.fromLTRB(
        0,
        0,
        0,
        queryData.viewInsets.bottom,
      ),
      height: queryData.size.height,
      child: Stack(
        children: [
          MapBox(),
          GradientOverlay(),
          Padding(
            padding: EdgeInsets.fromLTRB(
              15,
              queryData.viewInsets.top + 22,
              15,
              20,
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IncidentDataBox(),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: PlayerDataColumn(),
                ),
              ],
            ),
          ),
          Visibility(
            visible: queryData.size.width < 500 || queryData.size.height < 500,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ErrorBanner(),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: StreamView(),
          ),
        ],
      ),
    );
  }
}
