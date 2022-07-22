import 'package:camera/camera.dart';
import 'package:mobx/mobx.dart';
import 'package:safe/screens/capture/local_widgets/capture_text_shimmer.widget.dart';
import 'package:safe/widgets/mutable_screen_transition/mutable_screen_tranistion.widget.dart';

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
}
