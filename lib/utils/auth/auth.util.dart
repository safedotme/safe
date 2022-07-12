import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe/core.dart';
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

  Map<String, String> handleError(Core core, FirebaseAuthException error) {
    switch (error.code) {
      case "invalid-phone-number":
        return {
          "header": "Hold up! You're phone number is invalid",
          "desc": "Check your phone number before continuing"
        };
      case "invalid-verification-code":
        return {
          "header": "Hold up! The verification code you entered is invalid",
          "desc":
              "Check your messages for the latest code and try entering it again"
        };
      case "user-disabled":
        return {
          "header": "Your account has been desabled",
          "desc": "Tap here to reach out to Safe's support team"
        };
      default:
        return {
          "header": "Oops, we've run into a problem signing you in",
          "desc": "Try signing {action} again later"
        };
    }
  }
}
