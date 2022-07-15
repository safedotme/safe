import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_popup/local_widgets/mutable_popup_style.widget.dart';
import 'package:safe/widgets/mutable_popup/mutable_popup.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentLog extends StatefulWidget {
  @override
  State<IncidentLog> createState() => _IncidentLogState();
}

class _IncidentLogState extends State<IncidentLog> {
  late Core core;
  late MediaQueryData queryData;
  double kIncidentLogBorderRadius = 12;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
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
        onSlide: (offset) {
          core.state.incidentLog.setOffset(offset);
        },
        minHeight: kIncidentLogMinPopupHeight,
        maxHeight: queryData.size.height,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kIncidentLogBorderRadius),
              topRight: Radius.circular(kIncidentLogBorderRadius),
            ),
            color: kColorMap[MutableColor.neutral10]!.withOpacity(
              core.state.incidentLog.offset,
            ),
          ),
          child: MutableText("hello"),
        ),
      ),
    );
  }
}
