import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/incident/notified_contact.model.dart';
import 'package:safe/screens/incident/local_widgets/timeline_circle.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class ContactTimeline extends StatefulWidget {
  final List<NotifiedContact> contacts;

  ContactTimeline(this.contacts);

  @override
  State<ContactTimeline> createState() => _ContactTimelineState();
}

class _ContactTimelineState extends State<ContactTimeline> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  // CONSTANTS BASED ON SIZE
  final double circleSpacing = 55;

  List<Widget> genActionPair(NotifiedContact c) {
    String name = core.utils.name.genFirstName(c.name, false);
    String time = DateFormat.Hm().format(c.datetime);

    return [
      MutableText(
        core.utils.language
                .langMap[core.state.preferences.language]!["contacts"]["types"]
            [c.type]!,
        align: TextAlign.left,
        weight: TypeWeight.bold,
      ),
      SizedBox(height: 2),
      MutableText(
        core
            .utils
            .language
            .langMap[core.state.preferences.language]!["contacts"]
                ["notified_msg"]
            .replaceAll("{CONTACT}", name)
            .replaceAll("{TIME}", time),
        align: TextAlign.left,
        size: 12,
        color: MutableColor.neutral2,
      ),
    ];
  }

  List<Widget> genActions() {
    List<Widget> actions = [];

    for (int i = 0; i < (widget.contacts.length * 2) - 1; i++) {
      if (i.isOdd) {
        actions.add(SizedBox(height: 15));
      } else {
        actions.addAll(genActionPair(widget.contacts[i ~/ 2]));
      }
    }

    return actions;
  }

  List<Widget> genTimelineMarkers() {
    List<Widget> markers = [];

    for (int i = 0; i < widget.contacts.length; i++) {
      markers.add(Positioned(
        top: circleSpacing * i,
        child: TimelineCircle(),
      ));
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return widget.contacts.isEmpty
        ? SizedBox()
        : Expanded(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: kContactTimelineWidth,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: Color(0xff555555),
                            height: double.infinity,
                            width: 2,
                          ),
                        ),
                        ...genTimelineMarkers(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: double.infinity,
                            height: 22,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  kColorMap[kInputPopupColor]!.withOpacity(0),
                                  kColorMap[kInputPopupColor]!,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: genActions(),
                  ),
                ),
              ],
            ),
          );
  }
}
