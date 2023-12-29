import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulados_anac/core/states/base_page_state.dart';

import '../../data/repository/get_questions_repository.dart';

abstract class IGetQuestionsBloc extends Cubit<BaseState> {
  IGetQuestionsBloc() : super(const EmptyState());

  Future<void> getQuestions({required String question});
}

class GetQuestionsBloc extends IGetQuestionsBloc {
  final IGetQuestionsRepository _getQuestionsRepository;

  GetQuestionsBloc(this._getQuestionsRepository);

  @override
  Future<void> getQuestions({required String question}) async {
    emit(const LoadingState());

    try {
      final result = await _getQuestionsRepository.call(question: question);
      emit(SuccessState(result));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
