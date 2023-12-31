import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/otp/data/datasource/auth_datasource.dart';
import 'package:simulados_anac/app/otp/data/repository/auth_repository.dart';
import 'package:simulados_anac/app/otp/ui/bloc/auth_bloc.dart';

import 'ui/page/otp_page.dart';

class OtpModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<IAuthDataSource>(AuthDataSource.new);
    i.addSingleton<IAuthRepository>(AuthRepository.new);
    i.addSingleton<IAuthBloc>(AuthBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const OtpPage());
  }
}
