import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulados_anac/core/states/base_page_state.dart';

import '../../data/models/punctuation_model.dart'; // Importe o modelo PunctuationModel
import '../../data/repository/get_scores_repository.dart';

abstract class IScoreBloc extends Cubit<BaseState> {
  IScoreBloc() : super(const EmptyState());
  Future<List<PunctuationModel>> getScores();
}

class GetScoresBloc extends IScoreBloc {
  final IGetScoresRepository repository;

  GetScoresBloc({required this.repository});

  @override
  Future<List<PunctuationModel>> getScores() async {
    emit(const LoadingState());
    final scores = await repository.getScores();
    try {
      emit(SuccessState(scores.getSuccessData));
      return scores.getSuccessData;
    } catch (e) {
      emit(ErrorState(e.toString()));
      return [];
    }
  }
}
