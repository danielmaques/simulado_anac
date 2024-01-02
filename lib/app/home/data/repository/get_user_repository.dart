import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';
import '../datasource/get_user_datasource.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  Future<Result<UserModel>> getUserData(String uid);
}

class UserRepository implements IUserRepository {
  final IUserDataSource _userDataSource;

  UserRepository(this._userDataSource);

  @override
  Future<Result<UserModel>> getUserData(String uid) async {
    return await _userDataSource.getUserData(uid);
  }
}