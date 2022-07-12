import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe/utils/constants/constants.util.dart';

class AuthUtil {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>> sendOTP(
    String phone,
    String dialCode,
    int? resedToken,
    Function(String verificationId, int? resentToken) onCodeSend,
  ) async {
    FirebaseAuthException? exception;
    bool accountCreated = false;

    await auth.verifyPhoneNumber(
      phoneNumber: "$dialCode $phone",
      forceResendingToken: resedToken,
      timeout: kSMSTimeout,
      verificationCompleted: (creds) async {
        Map response = await signInWithCredential(creds);

        if (!response["status"]) {
          exception = response["error"];
          return;
        }

        accountCreated = true;
        return;
      },
      verificationFailed: (err) {
        exception = err;
      },
      codeSent: onCodeSend,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

    if (exception == null) {
      return {
        "status": true,
        "accountCreated": accountCreated,
      };
    }

    return {"status": false, "error": exception!};
  }

  Future<Map<String, dynamic>> verifyOTP(
    String otp,
    String verificationId,
  ) async {
    PhoneAuthCredential credentials = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    return await signInWithCredential(credentials);
  }

  Future<Map<String, dynamic>> signInWithCredential(
    AuthCredential creds,
  ) async {
    try {
      await auth.signInWithCredential(creds);
    } on FirebaseAuthException catch (e) {
      return {"status": false, "error": e};
    }

    return {
      "status": true,
    };
  }
}
