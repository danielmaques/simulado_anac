import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/questions/ui/bloc/get_questions_bloc.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
} 

class _QuestionsPageState extends State<QuestionsPage> {
  late IGetQuestionsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<IGetQuestionsBloc>();
    bloc.getQuestions(question: 'simulado1');
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
