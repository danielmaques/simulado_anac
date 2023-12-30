import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:simulados_anac/app/home/ui/bloc/score_bloc.dart';
import 'package:simulados_anac/app/home/ui/widgets/hello_bar.dart';
import 'package:simulados_anac/app/home/ui/widgets/latest_simulations.dart';

import '../../../../core/states/base_page_state.dart';
import '../../data/models/punctuation_model.dart';
import '../widgets/chart_card.dart';
import '../widgets/simulated_grid.dart';
import '../widgets/title_action.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late IScoreBloc _bloc;
  late double approved = 0.0;
  late double disapproved = 0.0;

  @override
  void initState() {
    super.initState();
    _bloc = Modular.get<IScoreBloc>();
    _bloc.getScores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            top: true,
            child: Column(
              children: [
                const HelloBar(
                  name: 'Nome do Usuário',
                ),
                const SizedBox(height: 25),
                Material(
                  elevation: 1,
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  child: const BarChartSample2(),
                ),
                const SizedBox(height: 25),
                TitleAction(
                  title: 'Simulados',
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      builder: (context) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: SimulatedGrid(
                            cardCount: 6,
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 15),
                const SimulatedGrid(),
                const SizedBox(height: 25),
                TitleAction(
                  title: 'Últimos Simulados',
                  onTap: () {},
                ),
                const SizedBox(height: 15),
                BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is SuccessState<List<PunctuationModel>>) {
                      final punctuation = state.data;
                      return ListView.separated(
                        itemCount:
                            punctuation.length >= 4 ? 4 : punctuation.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          return LatestSimulations(
                            title:
                                '${DateFormat('dd/MM').format(punctuation[index].date)} ${punctuation[index].subject}',
                            correct: '${punctuation[index].correctAnswers}',
                            wrong: '${punctuation[index].wrongAnswers}',
                            notAnswered: '${punctuation[index].notAnswered}',
                            percentage: punctuation[index].percentage,
                          );
                        },
                      );
                    } else {
                      return SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(
                            'Nenhum simulado avaliado',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
