import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulados_anac/app/punctuation/data/repository/user_pontuation_repository.dart';

import '../../../../core/states/base_page_state.dart';

abstract class IUserPunctuationBloc extends Cubit<BaseState> {
  IUserPunctuationBloc() : super(const EmptyState());

  Future<void> getUserPunctuation({
    required String category,
    required bool isApproved,
  });
}

class UserPunctuationBloc extends IUserPunctuationBloc {
  final IUserPunctuationRepository repository;

  UserPunctuationBloc({required this.repository});

  @override
  Future<void> getUserPunctuation(
      {required String category, required bool isApproved}) async {
    emit(const LoadingState());

    try {
      final result = await repository.getUserPunctuation(
        category: category,
        isApproved: isApproved,
        uid: '7v7KQ06mK3cRP8IyPqxbH7IIE863',
      );
      emit(SuccessState(result));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
