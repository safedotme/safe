import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/admin/admin.model.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/screens/capture/capture.screen.dart';
import 'package:safe/screens/capture/local_widgets/emergency_services.widget.dart';
import 'package:safe/screens/incident_log/incident_log.screen.dart';
import 'package:safe/utils/capture/capture.util.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/credit/credit.util.dart';
import 'package:safe/widgets/mutable_home_message.widget.dart/mutable_home_banner.widget.dart';
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
  late MediaQueryData queryData;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    userSubscribe();
  }

  void userSubscribe() {
    Stream<User?> stream = core.services.server.user.readFromId(
      id: core.services.auth.currentUser!.uid,
    );

    stream.listen((event) {
      WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
        if (event != null) {
          core.state.incidentLog.setUser(event);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    Core core = Provider.of<Core>(context, listen: false);

    return MutableScaffold(
      overlays: [
        Capture(),
        //EmergencyServicesPopup(),
      ],
      underlays: [
        Padding(
          padding: EdgeInsets.only(
              bottom: ((queryData.size.height * kIncidentLogMinPopupHeight) +
                      kSafeButtonSize) +
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
          padding: EdgeInsets.only(
              bottom:
                  (queryData.size.height * kIncidentLogMinPopupHeight) - 40),
          child: Center(
            child: MutableSafeButton(
              onTap: () async {
                HapticFeedback.heavyImpact();

                bool shouldCapture = await core.utils.credit.shouldCapture(
                  TriggerIdentifier.primary,
                  core,
                );

                if (!shouldCapture) {
                  // ADD MAD HAPTIC FEEDBACK
                  return;
                }

                core.utils.capture.start();
                core.state.capture.controller.open();
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MutableHomeBanner(),
        ),
      ],
      body: IncidentLog(),
    );
  }
}
