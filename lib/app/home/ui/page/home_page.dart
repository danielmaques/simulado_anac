import 'package:flutter/material.dart';
import 'package:simulados_anac/app/home/ui/widgets/chart_card.dart';
import 'package:simulados_anac/app/home/ui/widgets/hello_bar.dart';
import 'package:simulados_anac/app/home/ui/widgets/latest_simulations.dart';

import '../widgets/simulated_grid.dart';
import '../widgets/title_action.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: const PieChartSample2(),
            ),
            const SizedBox(height: 25),
            TitleAction(
              title: 'Simulados',
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  builder: (context) {
                    return const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
            const LatestSimulations()
          ],
        ),
      ),
    );
  }
}
