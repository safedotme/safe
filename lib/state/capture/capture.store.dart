import 'package:camera/camera.dart';
import 'package:mobx/mobx.dart';
import 'package:safe/models/incident/incident.model.dart';
import 'package:safe/models/incident/location.model.dart';
import 'package:safe/screens/capture/local_widgets/camera_preview.widget.dart';
import 'package:safe/screens/capture/local_widgets/capture_text_shimmer.widget.dart';
import 'package:safe/utils/incident/incident.util.dart';
import 'package:safe/widgets/mutable_overlay/mutable_overlay.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_tranistion.widget.dart';
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
  CameraController? camera;

  @action
  void setCamera(CameraController c) => camera = c;

  @observable
  List<CameraDescription> cameras = [];

  @action
  void setCameras(List<CameraDescription> c) => cameras = c;

  @observable
  bool isCameraInitialized = false;

  @action
  void setIsCameraInitialized(bool v) => isCameraInitialized = v;

  @observable
  PanelController panelController = PanelController();

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
  CameraPreviewController cameraPreviewController = CameraPreviewController();

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
  bool isLoading = false;

  @action
  void setIsLoading(bool v) => isLoading = v;

  @observable
  OverlayController overlayController = OverlayController();
}
