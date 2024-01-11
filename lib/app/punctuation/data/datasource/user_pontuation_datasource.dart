import 'package:cloud_firestore/cloud_firestore.dart';
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
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  Future<Result> getUserPunctuation({
    required String category,
    required bool isApproved,
    required String uid,
  }) async {
    try {
      DocumentSnapshot snapshot =
          await firebase.collection('users').doc(uid).get();
      Map<String, dynamic> values = snapshot.data() as Map<String, dynamic>;
      int approvedCount = values['approvedCount'] ?? 0;
      int disapprovedCount = values['disapprovedCount'] ?? 0;

      List<dynamic> approvedList = values['approvedList'] is List
          ? List<dynamic>.from(values['approvedList'] as List<dynamic>)
          : [];

      List<dynamic> disapprovedList = values['disapprovedList'] is List
          ? List<dynamic>.from(values['disapprovedList'] as List<dynamic>)
          : [];

      var now = DateTime.now().toIso8601String();

      if (isApproved) {
        approvedCount++;
        approvedList.add(now);
      } else {
        disapprovedCount++;
        disapprovedList.add(now);
      }

      await firebase.collection('users').doc(uid).update({
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
