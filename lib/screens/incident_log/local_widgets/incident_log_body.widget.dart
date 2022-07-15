import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';

class IncidentLogBody extends StatefulWidget {
  @override
  State<IncidentLogBody> createState() => _IncidentLogBodyState();
}

class _IncidentLogBodyState extends State<IncidentLogBody> {
  late Core core;

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
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            kSideScreenMargin,
            0,
            kSideScreenMargin,
            0,
          ),
          child: SingleChildScrollView(
            controller: ScrollController(), // state
            physics: NeverScrollableScrollPhysics(), // state
            child: Column(
              children: [
                ...List.generate(
                  5,
                  (index) => Container(
                    color: Colors.red[(100 * (index + 1)).toInt()]!,
                    height: 300,
                    width: double.infinity,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.red.withOpacity(0.1),
          padding: EdgeInsets.fromLTRB(
            kSideScreenMargin,
            10 + genTopPadding(core.state.incidentLog.offset),
            kSideScreenMargin,
            0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MutableHandle(),
            ],
          ),
        ),
      ],
    );
  }
}
