import 'package:safe/state/auth/auth.store.dart';
import 'package:safe/state/capture/capture.store.dart';
import 'package:safe/state/engine/engine.store.dart';
import 'package:safe/state/incident_log/incident_log.store.dart';
import 'package:safe/state/preferences/preferences.store.dart';
import 'package:safe/utils/signaling/signaling.store.dart';

class State {
  PreferencesStore preferences = PreferencesStore();
  AuthStore auth = AuthStore();
  IncidentLogStore incidentLog = IncidentLogStore();
  CaptureStore capture = CaptureStore();
  EngineStore engine = EngineStore();
  SignalingStore signaling = SignalingStore();
}
