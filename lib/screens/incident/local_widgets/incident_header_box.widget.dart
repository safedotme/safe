import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/screens/incident/local_widgets/incident_header.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_cached_image/mutable_cached_image.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentHeaderBox extends StatefulWidget {
  final Incident? incident;

  IncidentHeaderBox(this.incident);
  @override
  State<IncidentHeaderBox> createState() => _IncidentHeaderBoxState();
}

class _IncidentHeaderBoxState extends State<IncidentHeaderBox> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  String? fetchThumbnail(Map<String, String> keys) {
    bool keyExists = keys.containsKey(widget.incident!.id);

    if (!keyExists) return null;

    return keys[widget.incident!.id];
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return Observer(
      builder: (_) => SizedBox(
        height: query.size.height * 0.6 + kIncidentNavBarOffset,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Container(
                color: kColorMap[MutableColor.neutral7],
              ),
            ),
            Positioned(
              bottom: 1,
              child: SizedBox(
                width: query.size.width,
                child: MutableCachedImage(
                  fetchThumbnail(core.state.incidentLog.thumbnails),
                  shimmerColor: kShimmerAnimationColor.withOpacity(0.15),
                  backgroundColor: kColorMap[MutableColor.neutral3],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kColorMap[MutableColor.neutral10]!,
                    kColorMap[MutableColor.neutral10]!.withOpacity(0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kColorMap[MutableColor.neutral10]!.withOpacity(0.5),
                    kColorMap[MutableColor.neutral10]!.withOpacity(0),
                    kColorMap[MutableColor.neutral10]!.withOpacity(0)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: IncidentHeader(widget.incident),
            ),
          ],
        ),
      ),
    );
  }
}
