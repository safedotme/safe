import 'package:flutter/material.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_body_loader.widget.dart';
import 'package:safe/widgets/mutable_shimmer/mutable_shimmer.widget.dart';

class IncidentCardLoader extends StatelessWidget {
  final bool animate;

  IncidentCardLoader({this.animate = true});

  @override
  Widget build(BuildContext context) {
    return MutableShimmer(
      active: animate,
      animateToColor: kIncidentLoaderShimmerColor,
      child: Container(
        decoration: BoxDecoration(
          color: kColorMap[kIncidentCardBgColor],
          borderRadius: BorderRadius.circular(kIncidentCardBorderRadius),
          border: Border.all(
            width: kBorderWidth,
            color: kColorMap[kIncidentCardBorderColor]!,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kIncidentCardBorderRadius),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: kIncidentCardImageHeight,
                color: kColorMap[kIncidentCardLoaderColor],
              ),
              Padding(
                padding: EdgeInsets.all(kIncidentCardBodyPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IncidentBodyLoader(150),
                          SizedBox(height: 8),
                          ...List.generate(
                            3,
                            (i) => i.isEven
                                ? IncidentBodyLoader(200 - (i * 10), height: 14)
                                : SizedBox(height: 4),
                          ).toList(),
                          SizedBox(height: kIncidentBodyVerticalSpacing),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    IncidentBodyLoader(80, height: 22)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
