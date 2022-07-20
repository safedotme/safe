import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_incident_card/local_widgets/incident_card_loader.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class EmptyIncidentLog extends StatefulWidget {
  @override
  State<EmptyIncidentLog> createState() => _EmptyIncidentLogState();
}

class _EmptyIncidentLogState extends State<EmptyIncidentLog> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          IncidentCardLoader(animate: false),
          Observer(
            builder: (_) => Opacity(
              opacity: core.state.incidentLog.offset,
              child: Container(
                height: 320,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kColorMap[MutableColor.neutral10]!.withOpacity(0),
                      kColorMap[MutableColor.neutral10]!
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: kIncidentCardImageHeight + 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                MutableText(
                  core.utils.language.langMap[core.state.preferences.language]![
                      "incident_log"]["empty"]["header"],
                  align: TextAlign.center,
                  style: TypeStyle.h3,
                  weight: TypeWeight.bold,
                ),
                SizedBox(height: 8),
                MutableText(
                  core.utils.language.langMap[core.state.preferences.language]![
                      "incident_log"]["empty"]["desc"],
                  align: TextAlign.center,
                  color: MutableColor.neutral2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
