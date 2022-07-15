import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';

class IncidentLog extends StatefulWidget {
  @override
  State<IncidentLog> createState() => _IncidentLogState();
}

class _IncidentLogState extends State<IncidentLog> {
  late Core core;
  late MediaQueryData queryData;
  late double growthPossibility;
  double kIncidentLogBorderRadius = 12; // EXTRACT TO CONST
  double kIncidentLogActiveTopPading = 44; // EXTRACT TO CONST

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

    return animation * kIncidentLogActiveTopPading;
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    growthPossibility = queryData.size.height - kIncidentLogMinPopupHeight;
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
        },
        minHeight: kIncidentLogMinPopupHeight,
        maxHeight: queryData.size.height,
        body: Container(
            padding: EdgeInsets.fromLTRB(
              kSideScreenMargin,
              10 + genTopPadding(core.state.incidentLog.offset),
              kSideScreenMargin,
              0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kIncidentLogBorderRadius),
                topRight: Radius.circular(kIncidentLogBorderRadius),
              ),
              // Overlays color animating from 0 to 1
              color: kColorMap[MutableColor.neutral10]!.withOpacity(
                core.state.incidentLog.offset,
              ),
            ),
            child: Column(
              children: [
                MutableHandle(),
              ],
            )),
      ),
    );
  }
}
