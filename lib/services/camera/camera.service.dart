import 'package:camera/camera.dart';

class CameraService {
  CameraDescription? getCamera({
    required CameraLensDirection direction,
    required List<CameraDescription> cameras,
  }) {
    for (CameraDescription cam in cameras) {
      if (cam.lensDirection == direction) {
        return cam;
      }
    }

    return null;
  }

  Future<List<CameraDescription>> get cameras => availableCameras();
}
