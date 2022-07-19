import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/screens/incident_log/local_widgets/incident_log_header.widget.dart';
import 'package:safe/screens/incident_log/local_widgets/incident_log_navbar.widget.dart';
import 'package:safe/screens/incident_log/local_widgets/incident_log_subheader.widget.dart';
import 'package:safe/screens/incident_log/local_widgets/incident_nav_buttons.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_incident_card/mutable_incident_card.widget.dart';

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

  double genNavBtnSize(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0.14,
      upperBound: kNavigationTabCutoff,
      state: state,
    );

    return animation * ((kLargeButtonHeight * 2) + 10);
  }

  double genNavBtnSpacer(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0.14,
      upperBound: kNavigationTabCutoff,
      state: state,
    );

    return animation;
  }

  double genNavBtnOpacity(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: kNavigationTabCutoff,
      upperBound: 1,
      state: state,
    );

    return animation;
  }

  List<Widget> handleResponse(List<Incident>? incidents) {
    if (incidents == null) {
      return [Container()]; //loader
    }

    if (incidents.isEmpty) {
      return [Container()]; // Empty State
    }

    return List.generate(
      incidents.length + (incidents.length - 1),
      (i) => i.isEven ? MutableIncidentCard() : SizedBox(height: 25),
    );
  }

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
            child: Observer(
              builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  IncidentLogHeader(),
                  SizedBox(
                    height: 20 * genNavBtnSpacer(core.state.incidentLog.offset),
                  ),
                  core.state.incidentLog.offset > kNavigationTabCutoff
                      ? Opacity(
                          opacity: genNavBtnOpacity(
                            core.state.incidentLog.offset,
                          ),
                          child: NavigationButtons(),
                        )
                      : SizedBox(
                          height: genNavBtnSize(
                            core.state.incidentLog.offset,
                          ),
                        ),
                  SizedBox(
                    height: 35 * genNavBtnSpacer(core.state.incidentLog.offset),
                  ),
                  IncidentLogSubheader(),
                  SizedBox(height: 15),
                  ...handleResponse(core.state.incidentLog.incidents)
                ],
              ),
            ),
          ),
        ),
        IncidentLogNavBar()
      ],
    );
  }
}
