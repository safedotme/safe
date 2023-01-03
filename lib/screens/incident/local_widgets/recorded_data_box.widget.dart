import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/incident/local_widgets/data_point_box.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class RecordedDataBox extends StatefulWidget {
  @override
  State<RecordedDataBox> createState() => _RecordedDataBoxState();
}

class _RecordedDataBoxState extends State<RecordedDataBox> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSideScreenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MutableText(
            core
                .utils
                .language
                .langMap[core.state.preferences.language]!["incident"]
                    ["recorded_data"]["header"]
                .toUpperCase(),
            align: TextAlign.left,
            weight: TypeWeight.heavy,
          ),
          SizedBox(height: 20),
          DataPointBox(
            header: "One Apple Park Way",
            subheader: "37°20 5″N 122°0 32″W",
            keyIcon: MutableIcon(
              MutableIcons.gear,
              size: Size(12, 12),
              color: kColorMap[MutableColor.neutral3]!,
            ),
            keyText: core.utils.language
                    .langMap[core.state.preferences.language]!["incident"]
                ["recorded_data"]["location"]["key"],
            onTap: () {
              // TODO: Open map view
            },
            sideWidget: Container(
              height: 84,
              width: 115,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DataPointBox(
                  header: "10:31 - 11:05",
                  subheader: "June 19, 2022 (EST)",
                  keyIcon: MutableIcon(
                    MutableIcons.gear,
                    size: Size(12, 12),
                    color: kColorMap[MutableColor.neutral3]!,
                  ),
                  keyText: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["recorded_data"]["date"]["key"],
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: DataPointBox(
                  header: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["recorded_data"]["backup"]["header"],
                  subheader: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["recorded_data"]["backup"]["subheader"],
                  keyIcon: MutableIcon(
                    MutableIcons.gear,
                    size: Size(12, 12),
                    color: kColorMap[MutableColor.neutral3]!,
                  ),
                  keyText: core.utils.language
                          .langMap[core.state.preferences.language]!["incident"]
                      ["recorded_data"]["backup"]["key"],
                ),
              ),
            ],
          ),
          SizedBox(height: 100)
        ],
      ),
    );
  }
}
