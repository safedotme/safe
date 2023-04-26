import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart' hide BoxShadow;
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:safe/core.dart';
import 'package:safe/models/contact/contact.model.dart';
import 'package:safe/screens/add_contact/local_widgets/custom_cupertino_contact_popup.widget.dart';
import 'package:safe/screens/add_contact/local_widgets/import_contact_popup.widget.dart';
import 'package:safe/screens/capture/capture.screen.dart';
import 'package:safe/screens/contact/contact.screen.dart';
import 'package:safe/screens/contact/local_widgets/contact_country_code_selector_controller.widget.dart';
import 'package:safe/screens/contact_editor/contact_editor.screen.dart';
import 'package:safe/screens/home/local_widgets/incident_limit_home_banner.widget.dart';
import 'package:safe/screens/home/local_widgets/event_home_banner.widget.dart.dart';
import 'package:safe/screens/home/local_widgets/tutorial_banner.widget.dart';
import 'package:safe/screens/incident/incident.screen.dart';
import 'package:safe/screens/incident_log/incident_log.screen.dart';
import 'package:safe/screens/play/play.screen.dart';
import 'package:safe/screens/settings/settings.screen.dart';
import 'package:safe/screens/tutorial/tutorial.screen.dart';
import 'package:safe/utils/constants/constants.util.dart';
import 'package:safe/utils/credit/credit.util.dart';
import 'package:safe/widgets/mutable_action_banner/mutable_action_banner.widget.dart';
import 'package:safe/widgets/mutable_confetti_overlay/mutable_confetti_overlay.widget.dart';
import 'package:safe/widgets/mutable_safe_button/mutable_safe_button.widget.dart';
import 'package:safe/widgets/mutable_scaffold/mutable_scaffold.widget.dart';
import 'package:safe/widgets/mutable_text/mutable_text.widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Core core;
  late MediaQueryData queryData;
  int userRetries = kUserServerLoadRetries;

  @override
  void initState() {
    super.initState();

    core = Provider.of<Core>(context, listen: false);
    userSubscribe();
    contactSubscribe();
    permissionSubscribe();
    preferencesSubscribe();
    connectivitySubscribe();
  }

  void contactSubscribe() {
    Stream<List<Contact>> stream = core.services.server.contacts.readFromUserId(
      userId: core.services.auth.currentUser!.uid,
    );

    stream.listen(
      (event) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          core.state.contact.setContacts(event);
          await core.utils.credit.obtainState(core);
        });
      },
    );
  }

  void preferencesSubscribe() async {
    final client = await SharedPreferences.getInstance();

    final biometricsEnabled =
        core.services.preferences.fetchBiometricsEnabled(client);

    core.state.preferences.setBiometricsEnabled(biometricsEnabled);
  }

  void permissionSubscribe() async {
    var disabled = await core.services.permissions.getDisabledPermissions(core);
    core.state.preferences.setDisabledPermissions(disabled);
    await core.utils.credit.obtainState(core);
  }

  void userSubscribe() async {
    final uid = core.services.auth.currentUser!.uid;

    final exists = await core.services.server.user.userExists(uid);

    if (!exists) {
      if (userRetries == 0) return;
      await Future.delayed(Duration(seconds: 1));
      userSubscribe();
      userRetries--;

      return;
    }

    final stream = core.services.server.user.readFromId(
      id: uid,
    );

    userRetries = kUserServerLoadRetries;

    stream.listen((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (event != null) {
          await core.utils.credit.obtainState(core, user: event);
          core.state.incidentLog.setUser(event);
        }
      });
    });
  }

  void handleOnConnectivityChanged(ConnectivityResult res) {
    if (res == ConnectivityResult.none) {
      core.state.preferences.setIsConnected(false);

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        core.utils.credit.obtainState(core);
      });

      return;
    }

    core.state.preferences.setIsConnected(true);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      core.utils.credit.obtainState(core);
    });
  }

  void connectivitySubscribe() async {
    final client = Connectivity();

    Future.delayed(Duration(milliseconds: 100)).then((_) async {
      final res = await client.checkConnectivity();

      handleOnConnectivityChanged(res);
    });

    client.onConnectivityChanged.listen(handleOnConnectivityChanged);
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    Core core = Provider.of<Core>(context, listen: false);
    return MutableScaffold(
      overlays: [
        SettingsScreen(),
        ContactScreen(),
        ContactEditorScreen(),
        ImportContactPopup(),
        CustomCupertinoContactPopup(),
        ContactCountryCodeSelector(),
        CaptureScreen(),
        TutorialScreen(),
        IncidentScreen(),
        PlayScreen(),
        MutableActionBanner(
          controller: core.state.preferences.actionController,
        ),
        MutableConfettiOverlay(),
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
                      core.state.capture.limErrState == null
                          ? "header"
                          : "header_disabled"],
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

                    if (core.state.preferences.isFirstTime) {
                      core.utils.capture.tutorial();
                      core.state.preferences.setIsFirstTime(false);
                      core.state.preferences.tutorialBannerController.close();
                    } else {
                      core.utils.capture.start();
                    }

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
          child: EventHomeBanner(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: TutorialBanner(),
        ),
      ],
      body: IncidentLog(),
    );
  }
}
