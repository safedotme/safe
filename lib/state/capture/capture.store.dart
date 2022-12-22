import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:mobx/mobx.dart';
import 'package:safe/models/incident/battery.model.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/screens/capture/local_widgets/capture_text_shimmer.widget.dart';
import 'package:safe/utils/incident/incident.util.dart';
import 'package:safe/widgets/mutable_overlay/mutable_overlay.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_transition.widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

part 'capture.store.g.dart';

class CaptureStore extends _CaptureStore with _$CaptureStore {}

abstract class _CaptureStore with Store {
  // UI
  @observable
  ScreenTransitionController controller = ScreenTransitionController();

  @observable
  CaptureTextShimmerController hintTextController =
      CaptureTextShimmerController();
  @observable
  PanelController panelController = PanelController();

  @observable
  PanelController controlPanelController = PanelController();

  @observable
  double offset = 1;

  @action
  void setOffset(double d) => offset = d;

  @observable
  double panelHeight = 300;

  @action
  void setPanelHeight(double p) => panelHeight = p;

  @observable
  int hintTextIndex = 0;

  @action
  void setHintTextIndex(int i) => hintTextIndex = i;

  @observable
  Incident? incident;

  @action
  void setIncident(Incident i) => incident = i;

  @observable
  IncidentType type = IncidentType.general;

  @action
  void setIncidentType(IncidentType t) => type = t;

  @observable
  Stream<Location>? locationUpdates;

  @action
  void setLocationUpdates(Stream<Location> l) => locationUpdates = l;

  @observable
  OverlayController overlayController = OverlayController();

  @observable
  List<Battery> battery = [];

  @action
  void addToBattery(Battery b) => battery.add(b);

  @observable
  bool emergencyServicesNotified = false;

  @action
  void setEmergencyServicesNotified(bool b) => emergencyServicesNotified = b;

  // STREAM
  @observable
  RtcEngine? engine;

  @action
  void setEngine(RtcEngine e) => engine = e;

  @observable
  Function? showPreview;

  @action
  void setShowPreview(Function? s) => showPreview = s;

  @observable
  Function? hidePreview;

  @action
  void setHidePreview(Function? s) => hidePreview = s;

  @observable
  bool isBackCam = true;

  @action
  void changeCam() => isBackCam = !isBackCam;

  @observable
  double enlargementState = 0;

  @action
  void setEnglargmentState(double e) => enlargementState = e;

  @observable
  Function? enlargeCameraView;

  @observable
  Function? unEnlargeCameraView;

  @action
  void setEnlargeFn(Function enlarge, Function unEnlarge) {
    enlargeCameraView = enlarge;
    unEnlargeCameraView = unEnlarge;
  }

  @observable
  bool isFlashOn = false;

  @action
  void setFlash() => isFlashOn = !isFlashOn;
}
