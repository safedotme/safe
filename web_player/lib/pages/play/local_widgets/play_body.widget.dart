import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/pages/play/local_widgets/gradient_overlay.widget.dart';
import 'package:safe/pages/play/local_widgets/live_pill.widget.dart';
import 'package:safe/pages/play/local_widgets/map_box.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

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
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LivePill(),
                        Spacer(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MutableText(
                              "One Apple Park Way",
                              weight: TypeWeight.bold,
                            ),
                            SizedBox(height: 3),
                            MutableText(
                              "9:41 - 12:30 PM (EST)",
                              size: 14,
                              color: MutableColor.neutral2,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
