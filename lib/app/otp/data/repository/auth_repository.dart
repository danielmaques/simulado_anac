import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

import '../datasource/auth_datasource.dart';

abstract class IAuthRepository {
  Future<Result<bool>> signInWithPhoneNumber(
      String smsCode, String verificationId);
  Future<Result<bool>> verifyPhoneNumber(String phoneNumber);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  @override
  Future<Result<bool>> signInWithPhoneNumber(
      String smsCode, String verificationId) async {
    final result =
        await authDataSource.signInWithPhoneNumber(smsCode, verificationId);
    return result;
  }

  @override
  Future<Result<bool>> verifyPhoneNumber(String phoneNumber) async {
    final result = await authDataSource.verifyPhoneNumber(phoneNumber);
    return result;
  }
}
