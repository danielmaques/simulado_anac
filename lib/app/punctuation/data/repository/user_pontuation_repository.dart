import '../../../../core/errors/base_error.dart';
import '../../../../core/result_wrapper/result_wrapper.dart';
import '../datasource/user_pontuation_datasource.dart';

abstract class IUserPunctuationRepository {
  Future<Result<bool>> getUserPunctuation({
    required String category,
    required bool isApproved,
    required String uid,
  });
}

class UserPunctuationRepository implements IUserPunctuationRepository {
  final IUserPunctuationDatasource dataSource;

  UserPunctuationRepository({required this.dataSource});

  @override
  Future<Result<bool>> getUserPunctuation({
    required String category,
    required bool isApproved,
    required String uid,
  }) async {
    try {
      await dataSource.getUserPunctuation(
        category: category,
        isApproved: isApproved,
        uid: uid,
      );
      return ResultSuccess(true);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
