import 'package:firebase_database/firebase_database.dart';
import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

import '../../../../core/errors/base_error.dart';
import '../models/user_model.dart';

abstract class IUserDataSource {
  Future<Result<UserModel>> getUserData(String uid);
}

class UserDataSource implements IUserDataSource {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  @override
  Future<Result<UserModel>> getUserData(String uid) async {
    try {
      final snapshot = await _databaseReference.child('users/$uid').once();

      final Map<String, dynamic> valueMap = Map<String, dynamic>.from(snapshot.snapshot.value as Map);
      final result = UserModel.fromJson(valueMap);
      return ResultSuccess(result);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}