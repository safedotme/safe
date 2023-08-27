import 'package:safe/core.dart';
import 'package:safe/services/analytics/helper_classes/analytics_log_model.service.dart';

class TutorialUtil {
  void _log(Core core, bool isSuccess) {
    core.services.analytics.log(AnalyticsLog(
      channel: "user-register",
      event: "tutorial-finished-${isSuccess ? "success" : "missing-contacts"}",
      description:
          "User has finished their tutorial ${isSuccess ? "successfully" : "without contacts"}.",
      icon: isSuccess ? "🎉" : "💥",
      tags: {
        "userid": core.services.auth.currentUser!.uid,
        "datetime": DateTime.now().toIso8601String(),
      },
    ));
  }

  // Used to take user to home screen if during tutorial and show success message
  Future<void> handleOnLeave(Core core) async {
    if (!core.state.preferences.isFirstTime) return;

    if (core.state.preferences.tutorialCalled) return;

    if (!core.state.preferences.seenWidgetPreview) {
      core.state.incident.widgetShowcasePopupController.open();
      core.state.preferences.setSeenWidgetPreview(true);
      return;
    }

    await core.state.incidentLog.controller.close();

    if (core.state.capture.limErrState != null) {
      _log(core, false);
      return;
    }
    _log(core, true);

    // Trigger fireworks and success message
    core.state.preferences.confettiController.play();
    core.state.preferences.tutorialBannerController.open();

    core.state.preferences.setTutorialCalled(true);
  }

  void handleCaptureTutorial(Core core) {
    core.utils.capture.tutorial();
    core.state.preferences.setIsFirstTime(false);
    core.state.preferences.tutorialBannerController.close();

    core.state.capture.controller.open();
  }
}
