import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/home/data/datasource/get_scores_datasource.dart';
import 'package:simulados_anac/app/home/data/repository/get_scores_repository.dart';
import 'package:simulados_anac/app/home/ui/bloc/score_bloc.dart';

import 'ui/page/home_page.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<IGetScoresDataSource>(GetScoresDataSource.new);
    i.addSingleton<IGetScoresRepository>(GetScoresRepository.new);
    i.addSingleton<IScoreBloc>(GetScoresBloc.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const HomePage());
  }
}
