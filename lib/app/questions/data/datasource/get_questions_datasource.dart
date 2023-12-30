import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';

import '../model/questions_model.dart';

abstract class IGetQuestionsDatasource {
  Future<Result<List<QuestionModel>>> call({required String question});
}

class GetQuestionsDatasource implements IGetQuestionsDatasource {
  @override
  Future<Result<List<QuestionModel>>> call({required String question}) async {
    final data = await rootBundle.loadString('assets/data/$question.json');
    final json = jsonDecode(data) as List;

    final questions = json
        .map((item) => QuestionModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return ResultSuccess(questions);
  }
}
