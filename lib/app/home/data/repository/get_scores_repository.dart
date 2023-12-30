import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

import '../datasource/get_scores_datasource.dart';
import '../models/punctuation_model.dart';

abstract class IGetScoresRepository {
  Future<Result<List<PunctuationModel>>> getScores();
}

class GetScoresRepository implements IGetScoresRepository {
  final IGetScoresDataSource dataSource;

  GetScoresRepository({required this.dataSource});

  @override
  Future<Result<List<PunctuationModel>>> getScores() async {
    final result = await dataSource.getScores();
    return ResultSuccess(result.getSuccessData);
  }
}
