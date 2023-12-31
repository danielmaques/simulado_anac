import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simulados_anac/app/otp/data/repository/auth_repository.dart';

import '../../../../core/states/base_page_state.dart';

abstract class IAuthBloc extends Cubit<BaseState> {
  IAuthBloc() : super(const EmptyState());

  Future<bool> verifyPhoneNumber(String phoneNumber);
}

class AuthBloc extends IAuthBloc {
  final IAuthRepository repository;

  AuthBloc({required this.repository});

  @override
  Future<bool> verifyPhoneNumber(String phoneNumber) async {
    emit(const LoadingState());

    try {
      final result = await repository.verifyPhoneNumber(phoneNumber);
      emit(SuccessState(result.getSuccessData));
      return result.isSuccess;
    } catch (e) {
      emit(ErrorState(e.toString()));
      return false;
    }
  }
}
