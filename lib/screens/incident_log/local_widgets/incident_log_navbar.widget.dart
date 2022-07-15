import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';

class IncidentLogNavBar extends StatefulWidget {
  @override
  State<IncidentLogNavBar> createState() => _IncidentLogNavBarState();
}

class _IncidentLogNavBarState extends State<IncidentLogNavBar> {
  late Core core;

  double kNavBarButtonHeight = 40;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  double genTopPadding(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0.8,
      upperBound: 1,
      state: state,
    );

    return 10 + (animation * kIncidentLogActiveTopPading);
  }

  double genButtonScale(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0,
      upperBound: 0.7,
      state: state,
    );

    return animation;
  }

  double genButtonOpacity(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0.71,
      upperBound: 1,
      state: state,
    );

    return animation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.red.withOpacity(0.1),
      padding: EdgeInsets.fromLTRB(
        kSideScreenMargin,
        genTopPadding(core.state.incidentLog.offset),
        kSideScreenMargin,
        0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MutableHandle(),
          SizedBox(height: 5),
          Opacity(
            opacity: genButtonOpacity(core.state.incidentLog.offset),
            child: Transform.scale(
              scale: genButtonScale(core.state.incidentLog.offset),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    color: Colors.red,
                  ),
                  Spacer(),
                  Container(
                    height: 40,
                    width: 40,
                    color: Colors.red,
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 40,
                    width: 40,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
