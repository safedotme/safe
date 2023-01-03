import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSideScreenMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MutableText(
            "Recorded Data".toUpperCase(),
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
            keyText: "LOCATION",
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
                  keyText: "DATE & TIME",
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: DataPointBox(
                  header: "Fully Secure",
                  subheader: "Powered by Google",
                  keyIcon: MutableIcon(
                    MutableIcons.gear,
                    size: Size(12, 12),
                    color: kColorMap[MutableColor.neutral3]!,
                  ),
                  keyText: "BACKUPS",
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
