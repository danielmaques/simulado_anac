// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../core/errors/base_error.dart';
import '../../../../core/result_wrapper/result_wrapper.dart';
import '../models/punctuation_model.dart';

abstract class IGetScoresDataSource {
  Future<Result<List<PunctuationModel>>> getScores();
}

class GetScoresDataSource implements IGetScoresDataSource {
  Future<Database> get database async {
    return openDatabase(
      join(await getDatabasesPath(), 'anac_score.db'),
    );
  }

  @override
  Future<Result<List<PunctuationModel>>> getScores() async {
    try {
      final Database db = await database;

      final List<Map<String, dynamic>> maps = await db.query('scores');

      final List<PunctuationModel> scores =
          maps.map((map) => PunctuationModel.fromJson(map)).toList();

      return ResultSuccess(scores);
    } catch (e) {
      return ResultError(BaseError(e.
      toString()));
    }
  }
}
