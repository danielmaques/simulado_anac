import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/punctuation/data/datasource/save_punctuation_datasource.dart';
import 'package:simulados_anac/app/punctuation/data/datasource/user_pontuation_datasource.dart';
import 'package:simulados_anac/app/punctuation/data/repository/save_punctuation_repository.dart';
import 'package:simulados_anac/app/punctuation/data/repository/user_pontuation_repository.dart';
import 'package:simulados_anac/app/punctuation/ui/page/punctuation_page.dart';

import 'ui/bloc/save_bloc.dart';
import 'ui/bloc/user_pontuation_bloc.dart';

class PunctuationModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ISavePunctuationDataSource>(SavePunctuationDataSource.new);
    i.addSingleton<ISavePunctuationRepository>(SavePunctuationRepository.new);
    i.addSingleton<ISaveBloc>(SaveBloc.new);

    i.addSingleton<IUserPunctuationDatasource>(UserPunctuationDatasource.new);
    i.addSingleton<IUserPunctuationRepository>(UserPunctuationRepository.new);
    i.addSingleton<IUserPunctuationBloc>(UserPunctuationBloc.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => PunctuationPage(
        question: r.args.data['question'],
        amount: r.args.data['amount'],
        type: r.args.data['type'],
      ),
    );
  }
}
