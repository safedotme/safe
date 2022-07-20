import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/icon/icon.util.dart';
import 'package:safe/widgets/mutable_avatar/mutable_avatar.widget.dart';
import 'package:safe/widgets/mutable_button/mutable_button.widget.dart';
import 'package:safe/widgets/mutable_handle/mutable_handle.dart';
import 'package:safe/widgets/mutable_icon/mutable_icon.widget.dart';
import 'package:safe/widgets/mutable_nav_safe_button/mutable_nav_safe_button.widget.dart';

class IncidentLogNavBar extends StatefulWidget {
  @override
  State<IncidentLogNavBar> createState() => _IncidentLogNavBarState();
}

class _IncidentLogNavBarState extends State<IncidentLogNavBar> {
  late Core core;

  double kNavBarButtonHeight = 40;

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

    return 10 + (animation * kIncidentLogActiveTopPading);
  }

  double genButtonScale(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0,
      upperBound: 0.7,
      state: state,
    );

    return animation;
  }

  double genButtonOpacity(double state) {
    double animation = core.utils.animation.percentBetweenPoints(
      lowerBound: 0.70,
      upperBound: 1,
      state: state,
    );

    return animation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        kSideScreenMargin,
        genTopPadding(core.state.incidentLog.offset),
        kSideScreenMargin,
        0,
      ),
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MutableHandle(),
          SizedBox(height: 5),
          Opacity(
            opacity: genButtonOpacity(core.state.incidentLog.offset),
            child: Transform.scale(
              scale: genButtonScale(core.state.incidentLog.offset),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  MutableButton(
                    onTap: () {
                      print("navigate to settings");
                    },
                    child: MutableIcon(
                      MutableIcons.gear,
                      size: Size(24, 24),
                      color: kColorMap[MutableColor.neutral2]!,
                    ),
                  ),
                  Spacer(),
                  MutableAvatar(
                    name: "Mark Music",
                    onTap: () {
                      print("edit profile");
                    },
                  ),
                  SizedBox(width: 15),
                  MutableNavSafeButton(
                    onTap: () {
                      print(core.state.incidentLog.scrollController.offset);
                      print("activate safe");
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
