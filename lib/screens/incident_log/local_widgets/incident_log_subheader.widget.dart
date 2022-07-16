import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentLogSubheader extends StatefulWidget {
  @override
  State<IncidentLogSubheader> createState() => _IncidentLogSubheaderState();
}

class _IncidentLogSubheaderState extends State<IncidentLogSubheader> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  double genTextSize(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0,
      upperBound: 0.13,
      state: state,
    );

    return animation * 20;
  }

  double genOpacity(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0.13,
      upperBound: 0.32,
      state: state,
    );

    return animation;
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: genTextSize(
        core.state.incidentLog.offset,
      ),
      child: MutableText(
        "All Incidents", // Extract
        align: TextAlign.left,
        size: genOpacity(
          core.state.incidentLog.offset,
        ),
        weight: TypeWeight.heavy,
      ),
    );
  }
}
