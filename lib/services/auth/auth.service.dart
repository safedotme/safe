import 'package:firebase_auth/firebase_auth.dart';
import 'package:safe/core.dart';
import 'package:safe/utils/constants/constants.util.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get userChanges => _auth.userChanges();

  User? get currentUser => _auth.currentUser;

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<Map<String, dynamic>> sendOTP({
    required String phone,
    required String dialCode,
    int? resedToken,
    required Function(String verificationId, int? resentToken) onCodeSend,
  }) async {
    FirebaseAuthException? exception;
    bool accountCreated = false;

    await _auth.verifyPhoneNumber(
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
      await _auth.signInWithCredential(creds);
    } on FirebaseAuthException catch (e) {
      return {"status": false, "error": e};
    }

    return {
      "status": true,
    };
  }

  Map<String, String> handleError(Core core, String error) {
    switch (error) {
      case "no-phone-number":
        return core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["firebase_errors"][error];
      case "invalid-phone-number":
        return core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["firebase_errors"][error];
      case "invalid-verification-code":
        return core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["firebase_errors"][error];
      case "user-disabled":
        return core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["firebase_errors"][error];
      default:
        return core.utils.language
                .langMap[core.state.preferences.language]!["auth"]
            ["firebase_errors"]["default"];
    }
  }
}
