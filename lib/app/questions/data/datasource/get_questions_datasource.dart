import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

import '../model/questions_model.dart';

abstract class IGetQuestionsDatasource {
  Future<Result<QuestionModel>> call({required String question});
}

class GetQuestionsDatasource implements IGetQuestionsDatasource {
  @override
  Future<Result<QuestionModel>> call({required String question}) async {
    final data = await rootBundle.loadString('assets/$question.json');
    final json = jsonDecode(data);

    final questions = QuestionModel.fromJson(json);

    return ResultSuccess(questions);
  }
}
