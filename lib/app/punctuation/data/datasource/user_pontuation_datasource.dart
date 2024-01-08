import 'package:firebase_database/firebase_database.dart';
import 'package:simulados_anac/core/errors/base_error.dart';

import '../../../../core/result_wrapper/result_wrapper.dart';

abstract class IUserPunctuationDatasource {
  Future<Result> getUserPunctuation({
    required String category,
    required bool isApproved,
    required String uid,
  });
}

class UserPunctuationDatasource implements IUserPunctuationDatasource {
  final firebase = FirebaseDatabase.instance.ref();

  @override
  Future<Result> getUserPunctuation({
    required String category,
    required bool isApproved,
    required String uid,
  }) async {
    try {
      DatabaseEvent snapshot = await firebase.child('users/$uid').once();
      Map<dynamic, dynamic> values = snapshot.snapshot.value as Map;
      int approvedCount = values['approvedCount'] ?? 0;
      int disapprovedCount = values['disapprovedCount'] ?? 0;

      DatabaseEvent approvedListSnapshot =
          await firebase.child('users/$uid/approvedList').once();
      List<dynamic> approvedList = approvedListSnapshot.snapshot.value is List
          ? List<dynamic>.from(
              approvedListSnapshot.snapshot.value as List<dynamic>)
          : [];

      DatabaseEvent disapprovedListSnapshot =
          await firebase.child('users/$uid/disapprovedList').once();
      List<dynamic> disapprovedList =
          disapprovedListSnapshot.snapshot.value is List
              ? List<dynamic>.from(
                  disapprovedListSnapshot.snapshot.value as List<dynamic>)
              : [];

      var now = DateTime.now().toIso8601String();

      if (isApproved) {
        approvedCount++;
        approvedList.add(now);
      } else {
        disapprovedCount++;
        disapprovedList.add(now);
      }

      await firebase.child('users/$uid').set({
        'approvedCount': approvedCount,
        'disapprovedCount': disapprovedCount,
        'approvedList': approvedList,
        'disapprovedList': disapprovedList,
      });

      return ResultSuccess(true);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
