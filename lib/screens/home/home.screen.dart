import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/screens/incident_log/incident_log.screen.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/widgets/mutable_safe_button/mutable_safe_button.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Core core;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    userSubscribe();
  }

  void userSubscribe() {
    Stream<User> stream = core.services.server.user.readFromId(
      id: core.services.auth.currentUser!.uid,
    );

    stream.listen((event) {
      WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
        core.state.incidentLog.setUser(event);
      });
    });
  }

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
              core.utils.language
                  .langMap[core.state.preferences.language]!["home"]["header"],
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
