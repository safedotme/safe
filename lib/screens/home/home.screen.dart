import 'package:flutter/material.dart' hide BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/models/user/user.model.dart';
import 'package:safe/screens/capture/capture.screen.dart';
import 'package:safe/screens/home/local_widgets/incident_limit_home_banner.widget.dart';
import 'package:safe/screens/home/local_widgets/incident_recorded_home_banner.widget.dart';
import 'package:safe/screens/incident/incident.screen.dart';
import 'package:safe/screens/incident_log/incident_log.screen.dart';
import 'package:safe/screens/tutorial/tutorial.screen.dart';
import 'package:safe/services/media_server/media_server.service.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/credit/credit.util.dart';
import 'package:safe/widgets/mutable_action_banner/mutable_action_banner.widget.dart';
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
    contactSubscribe();
    permissionSubscribe();
  }

  void contactSubscribe() {
    Stream<List<Contact>> stream = core.services.server.contacts.readFromUserId(
      userId: core.services.auth.currentUser!.uid,
    );

    stream.listen(
      (event) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await core.utils.credit.obtainState(core, contacts: event.length);
          core.state.contact.setContacts(event);
        });
      },
    );
  }

  void permissionSubscribe() async {
    var disabled = await core.services.permissions.getDisabledPermissions(core);
    core.state.preferences.setDisabledPermissions(disabled);
    await core.utils.credit.obtainState(core);
  }

  void userSubscribe() {
    Stream<User?> stream = core.services.server.user.readFromId(
      id: core.services.auth.currentUser!.uid,
    );

    stream.listen((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (event != null) {
          await core.utils.credit.obtainState(core, user: event);
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
        CaptureScreen(),
        TutorialScreen(),
        IncidentScreen(),
        MutableActionBanner(),
      ],
      underlays: [
        Padding(
          padding: EdgeInsets.only(
              bottom: ((queryData.size.height * kIncidentLogMinPopupHeight) +
                      kSafeButtonSize) +
                  (kHomeHeaderToButtonMargin * 2) -
                  40),
          child: Observer(
            builder: (_) => AnimatedOpacity(
              curve: kFadeInCurve,
              duration: kFadeInDuration,
              opacity: core.state.incidentLog.user == null ? 0 : 1,
              child: Center(
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
        ),
        Observer(
          builder: (_) => Padding(
            padding: EdgeInsets.only(
                bottom:
                    (queryData.size.height * kIncidentLogMinPopupHeight) - 40),
            child: Center(
              child: AnimatedOpacity(
                curve: kFadeInCurve,
                opacity: core.state.incidentLog.user == null ? 0 : 1,
                duration: kFadeInDuration,
                child: MutableSafeButton(
                  onTap: () async {
                    HapticFeedback.heavyImpact();

                    bool shouldCapture = await core.utils.credit.shouldCapture(
                      TriggerIdentifier.primary,
                      core,
                    );

                    bool missingContacts = core.state.capture.limErrState ==
                        LimitErrorState.missingContacts;

                    if (!shouldCapture || missingContacts) {
                      // Flashes Incident Limit Banner
                      if (core.state.capture.shouldFlashLimitBanner == false) {
                        core.state.capture.setFlashLimitBanner(true);
                        await Future.delayed(Duration(seconds: 8));
                        core.state.capture.setFlashLimitBanner(false);
                      }

                      return;
                    }

                    core.utils.capture.start();
                    core.state.capture.controller.open();
                  },
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IncidentLimitHomeBanner(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IncidentRecordedHomeBanner(),
        ),
      ],
      body: IncidentLog(),
    );
  }
}
