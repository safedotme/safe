import 'package:safe/services/agora/agora.service.dart';
import 'package:safe/services/auth/auth.service.dart';
import 'package:safe/services/geocoder/geocoder.service.dart';
import 'package:safe/services/location/location.service.dart';
import 'package:safe/services/permissions/permisions.service.dart';
import 'package:safe/services/server/server.service.dart';
import 'package:safe/services/token_server/token_server.service.dart';
import 'package:safe/services/twilio/twilio.service.dart';

class Services {
  AuthService auth = AuthService();
  PermissionsService permissions = PermissionsService();
  ServerService server = ServerService()..init();
  LocationService location = LocationService();
  GeocoderService geocoder = GeocoderService();
  TwilioService twilio = TwilioService();
  TokenServer token = TokenServer();
  AgoraService agora = AgoraService();
}
