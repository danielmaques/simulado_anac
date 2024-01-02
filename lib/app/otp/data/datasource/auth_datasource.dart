import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:simulados_anac/core/errors/base_error.dart';
import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

abstract class IAuthDataSource {
  Future<Result<String>> signInWithGoogle();
  Future<Result<String>> signInWithFacebook();
  Future<Result<String>> signInWithApple();
}

class AuthDataSource implements IAuthDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final databaseReference = FirebaseDatabase.instance.ref();

  @override
  Future<Result<String>> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        return ResultError(BaseError('Sign in aborted by user'));
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential response =
          await firebaseAuth.signInWithCredential(credential);

      await databaseReference.child('users/${response.user!.uid}').set({
        'name': googleUser.displayName,
        'email': googleUser.email,
        'photoUrl': googleUser.photoUrl,
        'uid': response.user!.uid,
      });

      return ResultSuccess(response.user!.uid);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }

  @override
  Future<Result<String>> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        return ResultError(BaseError('Sign in aborted by user'));
      }

      final OAuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      final UserCredential response =
          await firebaseAuth.signInWithCredential(credential);

      return ResultSuccess(response.user!.uid);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }

  @override
  Future<Result<String>> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      final UserCredential response =
          await firebaseAuth.signInWithCredential(oauthCredential);

      return ResultSuccess(response.user!.uid);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
