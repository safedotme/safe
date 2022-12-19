import 'package:safe/services/agora/agora.service.dart';
import 'package:safe/services/auth/auth.service.dart';
import 'package:safe/services/camera/camera.service.dart';
import 'package:safe/services/geocoder/geocoder.service.dart';
import 'package:safe/services/location/location.service.dart';
import 'package:safe/services/permissions/permisions.service.dart';
import 'package:safe/services/server/server.service.dart';
import 'package:safe/services/twilio/twilio.service.dart';

class Services {
  AuthService auth = AuthService();
  PermissionsService permissions = PermissionsService();
  ServerService server = ServerService()..init();
  CameraService cam = CameraService();
  LocationService location = LocationService();
  GeocoderService geocoder = GeocoderService();
  TwilioService twilio = TwilioService();
  AgoraService agora = AgoraService();
}
