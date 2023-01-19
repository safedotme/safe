import 'package:shared_preferences/shared_preferences.dart';

enum Preferences {
  biometricsEnabled,
}

class PreferencesService {
  SharedPreferences? _client;

  Future<void> initialize() async {
    _client = await SharedPreferences.getInstance();
  }

  Future<bool> setBiometricsEnabled(bool enabled) async {
    assert(_client != null, "Shared preferences have not been initialized");

    return _client!.setBool(Preferences.biometricsEnabled.toString(), enabled);
  }

  bool? fetchBiometricsEnabled() {
    assert(_client != null, "Shared preferences have not been initialized");

    return _client!.getBool(Preferences.biometricsEnabled.toString());
  }
}
