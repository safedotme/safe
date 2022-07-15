import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_safe_button/mutable_safe_button.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";

  // constants
  double kIncidentLogMinPopupHeight = 138;
  double kHomeHeaderToButtonMargin = 60;

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return MutableScaffold(
      overlays: [],
      underlays: [
        Padding(
          padding: EdgeInsets.only(
              bottom: (kIncidentLogMinPopupHeight + kSafeButtonSize) +
                  (kHomeHeaderToButtonMargin * 2)),
          child: Center(
            child: MutableText(
              "Tap to Safe",
              style: TypeStyle.h2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: kIncidentLogMinPopupHeight),
          child: Center(
            child: MutableSafeButton(
              onTap: () {
                print("here");
              },
            ),
          ),
        ),
      ],
      body: Container(),
    );
  }
}
