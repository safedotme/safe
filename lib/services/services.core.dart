import 'package:safe/services/auth/auth.service.dart';
import 'package:safe/services/camera/camera.service.dart';
import 'package:safe/services/geocoder/geocoder.service.dart';
import 'package:safe/services/location/location.service.dart';
import 'package:safe/services/permissions/permisions.service.dart';
import 'package:safe/services/server/server.service.dart';
import 'package:safe/services/storage/storage.service.dart';

class Services {
  AuthService auth = AuthService();
  PermissionsService permissions = PermissionsService();
  ServerService server = ServerService()..init();
  CameraService cam = CameraService();
  StorageService storage = StorageService();
  LocationService location = LocationService();
  GeocoderService geocoder = GeocoderService();
}
