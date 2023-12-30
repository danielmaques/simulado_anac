import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

import '../../../../core/errors/base_error.dart';
import '../datasource/save_punctuation_datasource.dart';
import '../model/params/punctuation_params.dart';

abstract class ISavePunctuationRepository {
  Future<Result<bool>> savePunctuation(
      {required PunctuationParams punctuation});
}

class SavePunctuationRepository implements ISavePunctuationRepository {
  final ISavePunctuationDataSource dataSource;

  SavePunctuationRepository({required this.dataSource});

  @override
  Future<Result<bool>> savePunctuation(
      {required PunctuationParams punctuation}) async {
    try {
      await dataSource.savePunctuation(punctuation: punctuation);
      return ResultSuccess(true);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
