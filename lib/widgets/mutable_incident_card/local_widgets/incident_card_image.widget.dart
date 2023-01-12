import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_play_button.widget.dart';

class IncidentCardImage extends StatefulWidget {
  final Incident incident;
  final void Function() onPlayTap;

  IncidentCardImage(
    this.incident, {
    required this.onPlayTap,
  });

  @override
  State<IncidentCardImage> createState() => _IncidentCardImageState();
}

class _IncidentCardImageState extends State<IncidentCardImage> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  String? fetchThumbnail(Map map) {
    bool keyExists = map.containsKey(widget.incident.id);

    if (!keyExists) return null;

    return map[widget.incident.id];
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => SizedBox(
        height: kIncidentCardImageHeight,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              color: kColorMap[kIncidentCardLoaderColor],
              child: MutableCachedImage(
                fetchThumbnail(core.state.incidentLog.thumbnails),
                backgroundColor: kColorMap[kIncidentCardLoaderColor]!,
                fit: BoxFit.cover,
                shimmerColor: kBoxLoaderShimmerColor,
              ),
            ),
            Visibility(
              visible:
                  fetchThumbnail(core.state.incidentLog.thumbnails) != null,
              child: IncidentCardPlayButton(onTap: widget.onPlayTap),
            ),
          ],
        ),
      ),
    );
  }
}
