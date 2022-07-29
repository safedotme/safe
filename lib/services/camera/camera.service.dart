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

  CameraDescription? flipCamera({
    required CameraLensDirection oldDirection,
    required List<CameraDescription> cameras,
  }) {
    CameraLensDirection? direction;

    switch (oldDirection) {
      case CameraLensDirection.back:
        direction = CameraLensDirection.front;
        break;
      case CameraLensDirection.front:
        direction = CameraLensDirection.back;
        break;
      case CameraLensDirection.external:
        return null;
    }

    CameraDescription? camera =
        getCamera(direction: direction, cameras: cameras);

    return camera;
  }

  Future<List<CameraDescription>> get cameras => availableCameras();
}
