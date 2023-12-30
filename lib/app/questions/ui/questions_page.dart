import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/questions/data/model/questions_model.dart';
import 'package:simulados_anac/app/questions/ui/bloc/get_questions_bloc.dart';

import '../../../core/states/base_page_state.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({
    super.key,
    required this.select,
  });

  final String select;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late IGetQuestionsBloc bloc;
  late PageController pageController;
  int currentPage = 0;
  int questionLength = 0;
  Map<int, int> selectedItem = {};

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<IGetQuestionsBloc>();
    bloc.getQuestions(question: widget.select);
    pageController = PageController(initialPage: currentPage - 1);
    switchString();
  }

  void switchString() {
    switch (widget.select) {
      case 'simulado5':
        questionLength = 100;
        break;
      default:
        questionLength = 20;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Text(
          'Simulado',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Questão ${currentPage + 1} de $questionLength',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Visibility(
                  visible: currentPage != 0,
                  child: IconButton(
                    onPressed: () {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 24,
                    ),
                  ),
                ),
                Visibility(
                  visible: currentPage != questionLength,
                  child: IconButton(
                    onPressed: () {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            LinearProgressIndicator(
              value: currentPage / questionLength,
              minHeight: 13,
              color: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            Expanded(
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is SuccessState<List<QuestionModel>>) {
                    var data = state.data;
                    return PageView.builder(
                      controller: pageController,
                      itemCount: data.length - 1,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              data[index].simuladoquest?.title ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data[index]
                                      .simuladoquest
                                      ?.respostas
                                      ?.length ??
                                  0,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 15),
                              itemBuilder: (context, index) {
                                var item = data[currentPage]
                                    .simuladoquest!
                                    .respostas![index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedItem[currentPage] = index;
                                    });
                                  },
                                  child: Material(
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 17),
                                      decoration: BoxDecoration(
                                        color:
                                            selectedItem[currentPage] == index
                                                ? Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.1)
                                                : Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            selectedItem[currentPage] == index
                                                ? Border.all(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    width: 0.5,
                                                  )
                                                : null,
                                      ),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              item.texto!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            Visibility(
                              visible: currentPage == data.length - 2,
                              child: Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(50),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  onTap: () {
                                    for (var i = 0; i < data.length; i++) {
                                      var question =
                                          data[i].simuladoquest!.title;
                                      var correctAnswer = data[i]
                                          .simuladoquest!
                                          .respostas![i]
                                          .correta;
                                      var userAnswer = selectedItem[i];

                                      print('Questão: $question');
                                      print('Resposta correta: $correctAnswer');
                                      print('Resposta do usuário: $userAnswer');
                                    }
                                  },
                                  child: Container(
                                    height: 56,
                                    width: 130,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      'Finalizar',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      onPageChanged: (page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
