import 'package:safe/core.dart';

class TutorialUtil {
  // Used to take user to home screen if during tutorial and show success message
  Future<void> handleOnLeave(Core core) async {
    if (!core.state.preferences.isFirstTime) return;

    await core.state.incidentLog.controller.close();

    if (core.state.capture.limErrState != null) return;

    // Trigger fireworks and success message
    core.state.preferences.confettiController.play();
  }
}
