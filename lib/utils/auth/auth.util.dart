import 'package:magic_sdk/magic_sdk.dart';

class AuthUtil {
  Magic magic = Magic.instance;

  Future<bool> loginSMS(String phone) async {
    String token = await magic.auth.loginWithSMS(phoneNumber: phone);
    print(token);

    if (token.isEmpty) {
      return false;
    }

    return true;
  }
}
