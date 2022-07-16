import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/incident_log/local_widgets/incident_log_navbar.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentLogBody extends StatefulWidget {
  @override
  State<IncidentLogBody> createState() => _IncidentLogBodyState();
}

class _IncidentLogBodyState extends State<IncidentLogBody> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  // 30 is the initial margin and 130 is the final margin where 100 is final - initial
  double genTopPadding(double state) => 30 + (state * 100);

  // 20 is the initial size and 30 is the final size where 14 is final - initial size
  double genFontSize(double state) => 20 + (state * 10);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kSideScreenMargin),
          child: SingleChildScrollView(
            controller: core.state.incidentLog.scrollController,
            physics: core.state.incidentLog.scrollPhysics,
            padding: EdgeInsets.only(
              top: genTopPadding(core.state.incidentLog.offset),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MutableText(
                      "Incident Log",
                      size: genFontSize(core.state.incidentLog.offset),
                      weight: TypeWeight.heavy,
                    ),
                    MutableText(
                      "14 Incidents",
                      style: TypeStyle.body,
                      weight: TypeWeight.semiBold,
                      color: MutableColor.neutral2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        IncidentLogNavBar()
      ],
    );
  }
}
