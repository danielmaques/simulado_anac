import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:simulados_anac/app/questions/data/model/questions_model.dart';
import 'package:simulados_anac/app/questions/ui/bloc/get_questions_bloc.dart';

import '../../../core/states/base_page_state.dart';
import '../../punctuation/data/model/answer_model.dart';
import '../../punctuation/ui/widgets/custm_button.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({
    super.key,
    required this.select,
    required this.type,
  });

  final String select;
  final String type;

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  late IGetQuestionsBloc bloc;
  late PageController pageController;
  int currentPage = 0;
  int questionLength = 0;
  Map<int, int> selectedItem = {};
  Map<int, AnswerModel> questions = {};

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
          widget.type,
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
                  style: Theme.of(context).textTheme.displaySmall,
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
                      itemCount: data.length,
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
                                    .simuladoquest
                                    ?.respostas?[index];
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedItem[currentPage] = index;
                                    });

                                    var correctAnswerIndex = data[currentPage]
                                        .simuladoquest
                                        ?.respostas
                                        ?.indexWhere((element) =>
                                            element.correta == true);
                                    var userAnswer = selectedItem[currentPage];
                                    var correct = userAnswer != null &&
                                        correctAnswerIndex == userAnswer;

                                    questions[currentPage] = AnswerModel(
                                      question: data[currentPage]
                                              .simuladoquest
                                              ?.title ??
                                          '',
                                      correct: correct,
                                      correctAnswer: data[currentPage]
                                              .simuladoquest
                                              ?.respostas?[
                                                  correctAnswerIndex ?? 0]
                                              .texto ??
                                          '',
                                      answer: data[currentPage]
                                              .simuladoquest!
                                              .respostas![index]
                                              .texto ??
                                          '',
                                    );
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
                                              item?.texto ?? '',
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
                              visible: currentPage == data.length - 1,
                              child: CustomButton(
                                label: 'Encerar Simulado',
                                onTap: () {
                                  Modular.to.pushReplacementNamed(
                                    '/punctuation',
                                    arguments: {
                                      'question': questions.values.toList(),
                                      'amount': questionLength,
                                      'type': widget.type,
                                    },
                                  );
                                },
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
