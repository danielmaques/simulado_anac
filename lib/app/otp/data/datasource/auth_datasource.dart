import 'package:firebase_auth/firebase_auth.dart';
import 'package:simulados_anac/core/errors/base_error.dart';
import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

abstract class IAuthDataSource {
  Future<Result<bool>> signInWithPhoneNumber(
      String smsCode, String verificationId);
  Future<Result<bool>> verifyPhoneNumber(String phoneNumber);
}

class AuthDataSource implements IAuthDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Result<bool>> signInWithPhoneNumber(
      String smsCode, String verificationId) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final UserCredential response =
          await firebaseAuth.signInWithCredential(credential);

      return ResultSuccess(response.user != null);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }

  @override
  Future<Result<bool>> verifyPhoneNumber(String phoneNumber) async {
    try {
      verificationCompleted(PhoneAuthCredential credential) async {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        if (userCredential.user != null) {
          print(
              'Phone number automatically verified and user signed in: ${userCredential.user!.uid}');
        } else {
          print('Failed to sign in with phone number');
          throw FirebaseAuthException(
              code: 'ERROR_INVALID_VERIFICATION_CODE',
              message: 'The verification code for the phone number is invalid');
        }
      }

      verificationFailed(FirebaseAuthException e) {
        print(
            'Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
      }

      codeSent(String verificationId, int? resendToken) async {
        print('Verification code sent to the phone number');
      }

      codeAutoRetrievalTimeout(String verificationId) {
        print('Verification code auto-retrieval timeout');
      }

      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );

      return ResultSuccess(true);
    } catch (e) {
      print('Failed to Verify Phone Number: $e');
      return ResultError(BaseError(e.toString()));
    }
  }
}
