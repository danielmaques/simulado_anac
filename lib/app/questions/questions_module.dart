import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/questions/data/datasource/get_questions_datasource.dart';
import 'package:simulados_anac/app/questions/data/repository/get_questions_repository.dart';
import 'package:simulados_anac/app/questions/ui/bloc/get_questions_bloc.dart';

import 'ui/questions_page.dart';

class QuestionsModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<IGetQuestionsDatasource>(GetQuestionsDatasource.new);
    i.addSingleton<IGetQuestionsRepository>(GetQuestionsRepository.new);
    i.addSingleton<IGetQuestionsBloc>(GetQuestionsBloc.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => QuestionsPage(
        select: r.args.data['select'],
      ),
    );
  }
}
