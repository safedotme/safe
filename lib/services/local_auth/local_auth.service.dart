import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  static final _auth = LocalAuthentication();

  Future<bool> isAvailable() async => _auth.isDeviceSupported();

  Future<bool> authenticate(String reason) async {
    bool passed = false;
    try {
      passed = await _auth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          useErrorDialogs: true,
        ),
      );
    } on PlatformException catch (_) {
      return false;
    }

    return passed;
  }
}
