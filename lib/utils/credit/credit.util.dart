import 'package:safe/core.dart';
import 'package:safe/models/admin/admin.model.dart';
import 'package:safe/models/user/user.model.dart';

enum TriggerIdentifier {
  primary, // Used for typical safe buttons
  secondary, // Used to grant user final credit
}

class CreditUtil {
  // Call obtain state on
  /// -> On incidents loaded / On user loaded
  Future<void> obtainState(
    Core core, {
    User? user,
    int? incidents,
  }) async {
    await _base(
      core,
      onFirstIncident: () {},
      onAnyIncident: () {},
      onLastIncident: () {
        // Change state
      },
      onMaxedOut: () {
        // Change state
      },
      incidents: incidents,
      user: user,
    );
  }

  Future<bool> shouldCapture(
    TriggerIdentifier identifier,
    Core core, {
    User? user,
    int? incidents,
  }) async {
    bool capture = false;
    await _base(
      core,
      onFirstIncident: () {
        capture = true;
      },
      onAnyIncident: () {
        capture = true;
      },
      onLastIncident: () {
        if (identifier == TriggerIdentifier.secondary) {
          capture = true;
        }
      },
      onMaxedOut: () {},
      incidents: incidents,
      user: user,
    );

    return capture;
  }

  Future<void> _base(
    Core core, {
    required Function onFirstIncident,
    required Function onAnyIncident,
    required Function onLastIncident,
    required Function onMaxedOut,
    User? user,
    int? incidents,
  }) async {
    // Load all credits
    user ??= await core.services.server.user.readFromIdOnce(
      id: core.services.auth.currentUser!.uid,
    );

    if (user == null) return;

    AdminSettings settings = await core.services.server.admin.readLatest();

    incidents ??= core.state.incidentLog.incidents?.length;

    // All Credits
    int credits = user.credits + settings.defaultIncidentCap;

    if (incidents == null) {
      onFirstIncident();
      return;
    }
    ; // First incident

    if (credits > incidents + 1) {
      onAnyIncident();
      return;
    }

    if (credits == incidents + 1) {
      onLastIncident();
      return;
    }

    if (credits == incidents) {
      onMaxedOut();
      return;
    }

    return;
  }
}
