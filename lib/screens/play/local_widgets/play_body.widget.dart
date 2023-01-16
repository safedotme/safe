import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/screens/play/local_widgets/map_view.widget.dart';
import 'package:safe/screens/play/local_widgets/player_border.widget.dart';
import 'package:safe/screens/play/local_widgets/player_progress_indicator.widget.dart';
import 'package:safe/screens/play/local_widgets/video_player.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_overlay_button/mutable_overlay_button.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class PlayBody extends StatefulWidget {
  final Incident incident;
  final void Function() onClose;
  PlayBody(this.incident, this.onClose);

  @override
  State<PlayBody> createState() => _PlayBodyState();
}

class _PlayBodyState extends State<PlayBody> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    // Initialize Player
    core.utils.play.initIncident(widget.incident);
  }

  String generateAddress(Incident i) {
    String base = "";

    if (i.location == null) return base;
    if (i.location!.isEmpty) return base;
    if (i.location![0].address == null) return base;

    String address =
        core.utils.geocoder.removeTag(i.location![0].address!) ?? "";

    base = address.substring(0, address.indexOf(","));

    return base;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: MapView(widget.incident),
            ),
            SizedBox(width: 3),
            VideoPlayer(widget.incident)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PlayerBorder(true),
            Spacer(),
            PlayerBorder(false),
            Container(
              height: 30,
              color: kColorMap[MutableColor.neutral10]!.withOpacity(0.8),
            )
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 28, 22, 0),
            child: MutableOverlayButton(
              icon: MutableIcon(
                MutableIcons.cancel,
                size: Size(12, 12),
              ),
              onTap: widget.onClose,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MutableText(
                  widget.incident.name,
                  weight: TypeWeight.bold,
                  size: 20,
                ),
                SizedBox(height: 2),
                MutableText(
                  generateAddress(widget.incident),
                  size: 14,
                  color: MutableColor.neutral2,
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: PlayerProgressIndicator(widget.incident),
        )
      ],
    );
  }
}
