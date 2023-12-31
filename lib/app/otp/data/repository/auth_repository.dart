import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

import '../datasource/auth_datasource.dart';

abstract class IAuthRepository {
  Future<Result<String>> signInWithGoogle();
  Future<Result<String>> signInWithFacebook();
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource authDataSource;

  AuthRepository({required this.authDataSource});

  @override
  Future<Result<String>> signInWithGoogle() async {
    final result = await authDataSource.signInWithGoogle();
    return ResultSuccess(result.getSuccessData);
  }

  @override
  Future<Result<String>> signInWithFacebook() async {
    final result = await authDataSource.signInWithFacebook();
    return ResultSuccess(result.getSuccessData);
  }
}
