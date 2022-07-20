import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentLogHeader extends StatefulWidget {
  @override
  State<IncidentLogHeader> createState() => _IncidentLogHeaderState();
}

class _IncidentLogHeaderState extends State<IncidentLogHeader> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  // 20 is the initial size and 30 is the final size where 14 is final - initial size
  double genFontSize(double state) => 20 + (state * 10);

  double genCntrOpacity(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0,
      upperBound: 0.5,
      state: state,
    );

    return (animation - 1) * -1;
  }

  String handleResponse(List<Incident>? incidents, String message) {
    if (incidents == null) {
      return message.replaceAll("{count}", "0");
    }

    var base = message.replaceAll("{count}", incidents.length.toString());

    if (incidents.length == 1) {
      return base.replaceAll("s", "");
    }

    return base;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // EXTRACT ROW
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MutableText(
          core.utils.language
                  .langMap[core.state.preferences.language]!["incident_log"]
              ["header"], // Extract
          size: genFontSize(core.state.incidentLog.offset),
          weight: TypeWeight.heavy,
        ),
        Opacity(
          opacity: genCntrOpacity(
            core.state.incidentLog.offset,
          ),
          child: MutableText(
            handleResponse(
              core.state.incidentLog.incidents,
              core.utils.language
                      .langMap[core.state.preferences.language]!["incident_log"]
                  ["counter"]!,
            ),
            style: TypeStyle.body,
            weight: TypeWeight.semiBold,
            color: MutableColor.neutral2,
          ),
        ),
      ],
    );
  }
}
