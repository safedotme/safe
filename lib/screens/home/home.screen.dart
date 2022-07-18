import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/screens/incident_log/incident_log.screen.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_safe_button/mutable_safe_button.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";

  @override
  Widget build(BuildContext context) {
    Core core = Provider.of<Core>(context, listen: false);
    return MutableScaffold(
      underlays: [
        Padding(
          padding: EdgeInsets.only(
              bottom: (kIncidentLogMinPopupHeight + kSafeButtonSize) +
                  (kHomeHeaderToButtonMargin * 2) -
                  40),
          child: Center(
            child: MutableText(
              "Tap to Safe", // EXTRACT to lang
              style: TypeStyle.h2,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: kIncidentLogMinPopupHeight - 40),
          child: Center(
            child: MutableSafeButton(
              onTap: () {},
            ),
          ),
        ),
      ],
      body: IncidentLog(),
    );
  }
}
