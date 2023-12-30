import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import '../../data/model/answer_model.dart';
import '../widgets/custm_button.dart';

class PunctuationPage extends StatefulWidget {
  const PunctuationPage({
    super.key,
    required this.question,
    required this.amount,
  });

  final List<AnswerModel> question;
  final int amount;

  @override
  State<PunctuationPage> createState() => _PunctuationPageState();
}

class _PunctuationPageState extends State<PunctuationPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  int get correctAnswersCount {
    return widget.question.where((answer) => answer.correct).length;
  }

  int get wrongAnswersCount {
    return widget.question.where((answer) => !answer.correct).length;
  }

  int get notAnsweredCount {
    var plus = correctAnswersCount + wrongAnswersCount;
    var total = widget.amount - plus;
    return total;
  }

  double get correctAnswersPercentage {
    var totalQuestions =
        correctAnswersCount + wrongAnswersCount + notAnsweredCount;
    return (correctAnswersCount / totalQuestions) * 100;
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 93),
              Lottie.asset(
                correctAnswersPercentage >= 70
                    ? 'assets/animations/success.json'
                    : 'assets/animations/reproved.json',
                controller: controller,
                height: 150,
              ),
              const SizedBox(height: 43),
              Text(
                'Resultado do seu simulado',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 43),
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: const Icon(
                          EvaIcons.checkmark,
                          color: Color(0xFF34D287),
                        ),
                      ),
                      const SizedBox(width: 26),
                      Expanded(
                        child: Text(
                          'Corretas',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        correctAnswersCount.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: const Icon(
                          EvaIcons.close,
                          color: Color(0xFFF55150),
                        ),
                      ),
                      const SizedBox(width: 26),
                      Expanded(
                        child: Text(
                          'Erradas',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        wrongAnswersCount.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: const Icon(
                          EvaIcons.checkmark,
                          color: Color(0xFFFEBB3B),
                        ),
                      ),
                      const SizedBox(width: 26),
                      Expanded(
                        child: Text(
                          'Não respondidas',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      Text(
                        notAnsweredCount.toString(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.16),
              CustomButton(
                label: 'Visualizar Correção',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              CustomButton(
                label: 'Finalizar',
                onTap: () {
                  Modular.to.pushReplacementNamed('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
