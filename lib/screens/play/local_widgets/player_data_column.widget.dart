import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/play/local_widgets/player_data_box.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class PlayerDataColumn extends StatefulWidget {
  @override
  State<PlayerDataColumn> createState() => _PlayerDataColumnState();
}

class _PlayerDataColumnState extends State<PlayerDataColumn> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Observer(
      builder: (_) => Padding(
        padding: EdgeInsets.fromLTRB(
          queryData.padding.left + 10,
          25,
          0,
          0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            core.state.incident.playBattery == null
                ? SizedBox()
                : PlayerDataBox(
                    icon: MutableIcon(
                      MutableIcons.battery,
                      color: kColorMap[MutableColor.neutral3]!,
                      size: Size(17, 8),
                    ),
                    header: "Battery", // TODO: Extract
                    value: core.state.incident.playBattery!,
                  ),
            SizedBox(height: 6),
            core.state.incident.playSpeed == null
                ? SizedBox()
                : PlayerDataBox(
                    icon: MutableIcon(
                      MutableIcons.location,
                      color: kColorMap[MutableColor.neutral3]!,
                      size: Size(10, 10),
                    ),
                    header: "Speed", // TODO: Extract
                    value: core.state.incident.playSpeed!,
                  ),
          ],
        ),
      ),
    );
  }
}
