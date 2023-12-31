import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/otp/otp_module.dart';
import 'package:simulados_anac/app/questions/questions_module.dart';
import 'package:simulados_anac/core/theme/app_theme.dart';

import 'app/correction/correction_module.dart';
import 'app/home/home_module.dart';
import 'app/punctuation/punctuation_module.dart';
import 'core/theme/theme_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            title: 'My Smart App',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: Modular.routerConfig,
          );
        },
      ),
    );
  }
}

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(ThemeCubit.new);
  }

  @override
  void routes(r) {
    r.module('/', module: OtpModule());
    r.module('/home', module: HomeModule());
    r.module('/questions', module: QuestionsModule());
    r.module('/punctuation', module: PunctuationModule());
    r.module('/correction', module: CorrectionModule());
  }
}
