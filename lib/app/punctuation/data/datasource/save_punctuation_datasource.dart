// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:simulados_anac/core/errors/base_error.dart';
import 'package:simulados_anac/core/result_wrapper/result_wrapper.dart';
import 'package:sqflite/sqflite.dart';

import '../model/params/punctuation_params.dart';

abstract class ISavePunctuationDataSource {
  Future<Result> savePunctuation({required PunctuationParams punctuation});
}

class SavePunctuationDataSource implements ISavePunctuationDataSource {
  Future<Database> get database async {
    return openDatabase(
      join(await getDatabasesPath(), 'anac_score.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE scores(id TEXT PRIMARY KEY, subject TEXT, correctAnswers INTEGER, wrongAnswers INTEGER, notAnswered INTEGER, date TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Future<Result> savePunctuation(
      {required PunctuationParams punctuation}) async {
    try {
      final Database db = await database;

      await db.insert(
        'scores',
        {
          'id': punctuation.id,
          'subject': punctuation.subject,
          'correctAnswers': punctuation.correctAnswers,
          'wrongAnswers': punctuation.wrongAnswers,
          'notAnswered': punctuation.notAnswered,
          'date': punctuation.date.toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return ResultSuccess(db);
    } catch (e) {
      return ResultError(BaseError(e.toString()));
    }
  }
}
