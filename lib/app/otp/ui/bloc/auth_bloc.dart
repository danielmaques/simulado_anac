import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/otp/data/repository/auth_repository.dart';

import '../../../../core/services/user_hash/user_hash.dart';
import '../../../../core/states/base_page_state.dart';

abstract class IAuthBloc extends Cubit<BaseState> {
  IAuthBloc() : super(const EmptyState());

  Future<void> loginGoogle();
  Future<void> loginFacebook();
}

class AuthBloc extends IAuthBloc {
  final IAuthRepository repository;

  AuthBloc({required this.repository}) {
    _checkUserHash();
  }

  Future<void> _checkUserHash() async {
    final userHash = await UserHash.getUserHash();

    if (userHash != null && userHash.isNotEmpty) {
      Modular.to.pushReplacementNamed('/home/');
    }
  }

  @override
  Future<void> loginGoogle() async {
    emit(const LoadingState());

    try {
      final result = await repository.signInWithGoogle();

      await UserHash.saveUserHash(result.getSuccessData);

      Modular.to.pushReplacementNamed('/home/');
      emit(SuccessState(result.getSuccessData));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  @override
  Future<void> loginFacebook() async {
    emit(const LoadingState());

    try {
      final result = await repository.signInWithFacebook();
      emit(SuccessState(result.getSuccessData));

      await UserHash.saveUserHash(result.getSuccessData);

      Modular.to.pushReplacementNamed('/home/');
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
