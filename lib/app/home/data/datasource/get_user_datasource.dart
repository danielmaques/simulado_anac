import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

import '../../../../core/errors/base_error.dart';
import '../models/user_model.dart';

abstract class IUserDataSource {
  Future<Result<UserModel>> getUserData(String uid);
}

class UserDataSource implements IUserDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Result<UserModel>> getUserData(String uid) async {
    try {
      final snapshot = await _firestore.collection('users').doc(uid).get();

      final Map<String, dynamic> valueMap = Map<String, dynamic>.from(snapshot.data() as Map);
      final result = UserModel.fromJson(valueMap);
      return ResultSuccess(result);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}