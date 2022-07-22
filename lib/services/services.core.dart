import 'package:safe/services/auth/auth.service.dart';
import 'package:safe/services/camera/camera.service.dart';
import 'package:safe/services/permissions/permisions.service.dart';
import 'package:safe/services/server/server.service.dart';

class Services {
  AuthService auth = AuthService();
  PermissionsService permissions = PermissionsService();
  ServerService server = ServerService()..init();
  CameraService cam = CameraService();
}
