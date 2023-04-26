import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/pages/play/local_widgets/live_pill.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentDataBox extends StatefulWidget {
  @override
  State<IncidentDataBox> createState() => _IncidentDataBoxState();
}

class _IncidentDataBoxState extends State<IncidentDataBox> {
  late Core core;
  String timestamp = "";
  late Timer timer;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
    ticker();
  }

  void ticker() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        timestamp = generateDateTimeStamp(core.state.play.incident!);
      });
    });
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  String generateDateTimeStamp(Incident i) {
    final start = i.datetime;

    final timezone = start.timeZoneName.replaceAll(RegExp(r"[a-z ]"), "");
    final diff = DateTime.now().difference(start);
    final mins = diff.inMinutes;
    final secs = (diff.inSeconds - diff.inMinutes * 60);
    final date = DateFormat.jm().format(start.add(diff));

    return "${mins < 10 ? "0$mins" : mins}:${secs < 10 ? "0$secs" : secs} - $date ($timezone)";
  }

  String generateAddress(Incident i) {
    String base = "";

    if (i.location == null) return base;
    if (i.location!.isEmpty) return base;
    if (i.location![0].address == null) return base;

    String address =
        core.utils.geocoder.removeTag(i.location![0].address!) ?? "";

    base = address.substring(0, address.indexOf(","));

    return base;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LivePill(),
          Spacer(),
          SizedBox(
            width: 250,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MutableText(
                  generateAddress(core.state.play.incident!),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  weight: TypeWeight.bold,
                ),
                SizedBox(height: 3),
                MutableText(
                  timestamp,
                  size: 14,
                  color: MutableColor.neutral2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
