import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/core/states/base_page_state.dart';

import '../../data/model/params/punctuation_params.dart';
import '../../data/repository/save_punctuation_repository.dart';

abstract class ISaveBloc extends Cubit<BaseState> {
  ISaveBloc() : super(const EmptyState());

  Future<void> savePunctuation(PunctuationParams punctuation);
}

class SaveBloc extends ISaveBloc {
  final ISavePunctuationRepository repository;

  SaveBloc({required this.repository});

  @override
  Future<void> savePunctuation(PunctuationParams punctuation) async {
    emit(const LoadingState());

    try {
      final result = await repository.savePunctuation(punctuation: punctuation);
      emit(SuccessState(result));
      Modular.to.pushReplacementNamed('/home/');
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
