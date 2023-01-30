import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/pages/play/local_widgets/live_pill.widget.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class IncidentDataBox extends StatefulWidget {
  @override
  State<IncidentDataBox> createState() => _IncidentDataBoxState();
}

class _IncidentDataBoxState extends State<IncidentDataBox> {
  late Core core;

  @override
  void initState() {
    super.initState();
    core = Provider.of<Core>(context, listen: false);
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
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              MutableText(
                "One Apple Park Way",
                weight: TypeWeight.bold,
              ),
              SizedBox(height: 3),
              MutableText(
                "9:41 - 12:30 PM (EST)",
                size: 14,
                color: MutableColor.neutral2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
