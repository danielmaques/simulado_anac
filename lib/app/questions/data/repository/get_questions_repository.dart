import '../../../../core/result_wrapper/result_wrapper.dart';
import '../datasource/get_questions_datasource.dart';
import '../model/questions_model.dart';

abstract class IGetQuestionsRepository {
  Future<Result<List<QuestionModel>>> call({required String question});
}

class GetQuestionsRepository implements IGetQuestionsRepository {
  final IGetQuestionsDatasource datasource;

  GetQuestionsRepository({required this.datasource});

  @override
  Future<Result<List<QuestionModel>>> call({required String question}) async {
    final result = await datasource.call(question: question);
    return result;
  }
}