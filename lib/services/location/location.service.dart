import 'package:location/location.dart' as api;
import 'package:safe/models/incident/location.model.dart';

class LocationService {
  final location = api.Location();

  void listen() {
    location.onLocationChanged.listen((event) {
      print(event.accuracy);
    });
  }
}
