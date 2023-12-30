import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/punctuation/data/datasource/save_punctuation_datasource.dart';
import 'package:simulados_anac/app/punctuation/data/repository/save_punctuation_repository.dart';
import 'package:simulados_anac/app/punctuation/ui/page/punctuation_page.dart';

import 'ui/bloc/save_bloc.dart';

class PunctuationModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<ISavePunctuationDataSource>(SavePunctuationDataSource.new);
    i.addSingleton<ISavePunctuationRepository>(SavePunctuationRepository.new);
    i.addSingleton<ISaveBloc>(SaveBloc.new);
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
