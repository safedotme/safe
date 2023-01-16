import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:safe/screens/play/local_widgets/player_data_box.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';

class PlayerDataColumn extends StatefulWidget {
  @override
  State<PlayerDataColumn> createState() => _PlayerDataColumnState();
}

class _PlayerDataColumnState extends State<PlayerDataColumn> {
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
            PlayerDataBox(
              icon: MutableIcon(
                MutableIcons.camera,
                color: kColorMap[MutableColor.neutral3]!,
                size: Size(13, 12),
              ),
              header: "Battery",
              value: "89% (High)",
            ),
            SizedBox(height: 6),
            PlayerDataBox(
              icon: MutableIcon(
                MutableIcons.camera,
                color: kColorMap[MutableColor.neutral3]!,
                size: Size(13, 12),
              ),
              header: "Speed",
              value: "13.4 km/h",
            ),
          ],
        ),
      ),
    );
  }
}
