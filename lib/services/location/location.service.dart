import 'package:location/location.dart' as api;
import 'package:safe/models/incident/location.model.dart';

class LocationService {
  final location = api.Location();

  Future<void> initilaize() async {
    await location.requestPermission();
  }

  Stream<Location> get stream => location.onLocationChanged.map((e) {
        return Location(
          lat: e.latitude,
          long: e.longitude,
          alt: e.altitude,
          speed: e.speed,
          accuracy: e.accuracy,
          datetime: DateTime.now(),
        );
      });
}
