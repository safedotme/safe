import 'package:shared_preferences/shared_preferences.dart';

enum Preferences {
  biometricsEnabled,
}

class PreferencesService {
  Future<bool> setBiometricsEnabled(
    bool enabled,
    SharedPreferences client,
  ) async {
    return client.setBool(Preferences.biometricsEnabled.toString(), enabled);
  }

  bool? fetchBiometricsEnabled(
    SharedPreferences client,
  ) {
    return client.getBool(Preferences.biometricsEnabled.toString());
  }
}
