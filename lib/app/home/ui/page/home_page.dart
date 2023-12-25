import 'package:flutter/material.dart';
import 'package:simulados_anac/app/home/ui/widgets/hello_bar.dart';

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
            const SizedBox(height: 16),
            TitleAction(
              title: 'Simulados',
              onTap: () {
                showModalBottomSheet(
                  context: context,
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
            const SizedBox(height: 16),
            const SimulatedGrid(),
          ],
        ),
      ),
    );
  }
}
