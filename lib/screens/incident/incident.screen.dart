import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/screens/incident/local_widgets/incident_header_box.widget.dart';
import 'package:safe/screens/incident/local_widgets/incident_nav_bar.widget.dart';
import 'package:safe/screens/incident/local_widgets/incident_processing_loader.widget.dart';
import 'package:safe/screens/incident/local_widgets/recorded_data_box.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_loader/mutable_loader.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';

class IncidentScreen extends StatefulWidget {
  @override
  State<IncidentScreen> createState() => _IncidentState();
}

class _IncidentState extends State<IncidentScreen> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);

    initScrollController();
  }

  void initScrollController() {
    core.state.incident.scrollController.addListener(() {
      closeMenu();
    });
  }

  void closeMenu() {
    if (!core.state.incident.menuController.isAttached) return;
    if (!core.state.incident.menuController.isOpen) return;

    core.state.incident.menuController.close();
  }

  Incident? getIncident() {
    var i = core.state.incidentLog.incidents ?? [];

    if (i.isEmpty || core.state.incident.incidentId == null) {
      return null;
    }

    return i
        .singleWhere((element) => element.id == core.state.incident.incidentId);
  }

  @override
  void dispose() {
    if (core.state.incident.scrollController.hasClients) {
      core.state.incident.scrollController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Observer(
      builder: (_) => MutableScreenTransition(
        isDismissable: false,
        controller: core.state.incident.controller,
        body: Container(
          color: kColorMap[MutableColor.neutral10],
          child: getIncident() == null
              ? Center(
                  child: MutableLoader(
                    text: "Loading incident",
                  ),
                )
              : !getIncident()!.processedFootage
                  ? IncidentProcessingLoader(getIncident())
                  : Stack(
                      children: [
                        Positioned(
                          top: -kIncidentNavBarOffset,
                          child: SizedBox(
                            width: queryData.size.width,
                            height:
                                queryData.size.height + kIncidentNavBarOffset,
                            child: SingleChildScrollView(
                              controller: core.state.incident.scrollController,
                              child: Column(
                                children: [
                                  IncidentHeaderBox(getIncident()),
                                  SizedBox(height: 32),
                                  RecordedDataBox(getIncident())
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -1,
                          left: -1,
                          child: IncidentNavBar(getIncident()!),
                        )
                      ],
                    ),
        ),
      ),
    );
  }
}
