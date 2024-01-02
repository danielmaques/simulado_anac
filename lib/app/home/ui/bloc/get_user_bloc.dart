import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/user_hash/user_hash.dart';
import '../../../../core/states/base_page_state.dart';
import '../../data/repository/get_user_repository.dart';

abstract class IGetUserBloc extends Cubit<BaseState> {
  IGetUserBloc() : super(const EmptyState());

  Future<void> getUserData();
}

class GetUserBloc extends IGetUserBloc {
  final IUserRepository _getUserRepository;

  GetUserBloc(this._getUserRepository);

  @override
  Future<void> getUserData() async {
    emit(const LoadingState());
    try {
      final userHash = await UserHash.getUserHash();
      final result = await _getUserRepository.getUserData(userHash!);
      emit(SuccessState(result.getSuccessData));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
