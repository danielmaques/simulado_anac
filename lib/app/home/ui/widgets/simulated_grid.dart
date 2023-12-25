// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SimulatedGrid extends StatelessWidget {
  const SimulatedGrid({
    super.key,
    this.cardCount = 4,
  });

  final int cardCount;

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius = BorderRadius.circular(16);
    final List<Map<String, dynamic>> cards = [
      {
        'title': 'TEORIA DE VOO',
        'icon': 'assets/icons/airplane.svg',
        'color': const Color(0xFFFA7242)
      },
      {
        'title': 'METEOROLOGIA',
        'icon': 'assets/icons/cloud.svg',
        'color': const Color(0xFF2DB759)
      },
      {
        'title': 'NAVEGAÇÃO',
        'icon': 'assets/icons/map.svg',
        'color': const Color(0xFF41BFBB)
      },
      {
        'title': 'REGULAMENTOS',
        'icon': 'assets/icons/book.svg',
        'color': const Color(0xFF8D74ED)
      },
      {
        'title': 'C TECNICOS',
        'icon': 'assets/icons/information.svg',
        'color': const Color.fromARGB(255, 253, 0, 253)
      },
      {
        'title': 'S COMPLETO',
        'icon': 'assets/icons/note.svg',
        'color': const Color.fromARGB(255, 230, 237, 31)
      },
      // Adicione mais mapas aqui
    ].take(cardCount).toList();
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 172 / 66,
      mainAxisSpacing: 13,
      crossAxisSpacing: 13,
      children: cards.map((card) {
        return Material(
          elevation: 1,
          borderRadius: borderRadius,
          child: InkWell(
            onTap: () {},
            borderRadius: borderRadius,
            child: Ink(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: borderRadius,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    card['icon'],
                    color: card['color'],
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    card['title'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
