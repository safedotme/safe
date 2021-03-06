import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/incident_log/local_widgets/incident_log_body.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';

class IncidentLog extends StatefulWidget {
  @override
  State<IncidentLog> createState() => _IncidentLogState();
}

class _IncidentLogState extends State<IncidentLog> {
  late Core core;
  late MediaQueryData queryData;
  bool preventAnimationSpoofing = false;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    subscribe();
    listenScrollController();
  }

  void subscribe() {
    String id = core.services.auth.currentUser!.uid;

    var incidentStream = core.services.server.incidents.readFromUserId(
      userId: id,
    );

    incidentStream.listen((incidents) {
      core.state.incidentLog.setIncidents(incidents);
    });
  }

  void listenScrollController() {
    core.state.incidentLog.scrollController.addListener(() {
      if (!core.state.incidentLog.scrollController.hasClients) {
        return;
      }

      core.state.incidentLog.setScrollOffset(
        core.state.incidentLog.scrollController.offset,
      );
    });
  }

  Future<void> resetController() async {
    if (core.state.incidentLog.scrollController.offset == 0) {
      return;
    }

    if (preventAnimationSpoofing) {
      return;
    }

    preventAnimationSpoofing = true;

    await core.state.incidentLog.scrollController.animateTo(
      0,
      duration: Duration(
        milliseconds: 200,
      ),
      curve: Curves.decelerate,
    );

    preventAnimationSpoofing = false;
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Observer(
      builder: (_) => MutablePopup(
        controller: core.state.incidentLog.controller,
        style: MutablePopupStyle(
          backgroundColor: null,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kIncidentLogBorderRadius),
            topRight: Radius.circular(kIncidentLogBorderRadius),
          ),
        ),
        enableBorder: false,
        // Updates offset through state
        onSlide: (offset) {
          core.state.incidentLog.setOffset(offset);
          resetController();
        },
        onOpened: () {
          core.state.incidentLog.setScrollPhysics(kIncidentLogScrollPhysics);
          resetController();
        },
        onClosed: () {
          core.state.incidentLog.setScrollPhysics(
            NeverScrollableScrollPhysics(),
          );
          resetController();
        },
        minHeight: kIncidentLogMinPopupHeight,
        maxHeight: queryData.size.height,

        body: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kIncidentLogBorderRadius),
            topRight: Radius.circular(kIncidentLogBorderRadius),
          ),
          child: Container(
            height: queryData.size.height,
            color: kColorMap[MutableColor.neutral10]!.withOpacity(
              core.state.incidentLog.offset,
            ),
            child: IncidentLogBody(),
          ),
        ),
      ),
    );
  }
}
