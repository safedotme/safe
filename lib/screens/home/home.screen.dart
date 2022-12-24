import 'package:flutter/material.dart' hide BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/screens/capture/capture.screen.dart';
import 'package:safe/screens/home/local_widgets/incident_limit_home_banner.widget.dart';
import 'package:safe/screens/incident_log/incident_log.screen.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/credit/credit.util.dart';
import 'package:safe/widgets/mutable_home_message.widget.dart/mutable_home_banner.widget.dart';
import 'package:safe/widgets/mutable_pill/mutable_pill.widget.dart';
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (event != null) {
          core.state.incidentLog.setUser(event);
          core.utils.credit.obtainState(core, user: event);
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
          child: Observer(
            builder: (_) => Center(
              child: MutableText(
                core.utils.language
                        .langMap[core.state.preferences.language]!["home"][
                    core.state.capture.limErrState != null
                        ? "header_disabled"
                        : "header"],
                style: TypeStyle.h2,
              ),
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
                  // Flashes Incident Limit Banner
                  if (core.state.capture.shouldFlashLimitBanner == false) {
                    core.state.capture.setFlashLimitBanner(true);
                    await Future.delayed(Duration(seconds: 8));
                    core.state.capture.setFlashLimitBanner(false);
                  }

                  // Add haptic feedback
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
          child: IncidentLimitHomeBanner(),
        ),
      ],
      body: IncidentLog(),
    );
  }
}
