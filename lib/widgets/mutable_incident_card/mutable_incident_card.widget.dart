import 'package:flutter/cupertino.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_body.widget.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_image.widget.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';

class MutableIncidentCard extends StatelessWidget {
  final bool isLoading;

  MutableIncidentCard({this.isLoading = false});
  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      actions: [Container()],
      child: MutableButton(
        child: MutableShimmer(
          animateToColor: kShimmerAnimationColor.withOpacity(0.05),
          active: isLoading,
          child: Container(
            decoration: BoxDecoration(
              color: kColorMap[kIncidentCardBgColor],
              borderRadius: BorderRadius.circular(kIncidentCardBorderRadius),
              border: Border.all(
                width: kBorderWidth,
                color: kColorMap[MutableColor.neutral7]!,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(kIncidentCardBorderRadius),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IncidentCardImage(
                    isLoading: isLoading,
                    onPlayTap: () {
                      print("play");
                    },
                    onMenuTap: () {
                      print("menu");
                    },
                  ),
                  IncidentCardBody(
                    isLoading: isLoading,
                    name: "Incident Name",
                    address:
                        "One Apple Park Way, Cupertino, CA 95014, United States",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
