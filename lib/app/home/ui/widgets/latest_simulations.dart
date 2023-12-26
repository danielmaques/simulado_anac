import 'package:flutter/material.dart';

class LatestSimulations extends StatelessWidget {
  const LatestSimulations({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '01/12 - Navegação',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Reprovado 3 - 20',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: const Color(0xFFF55150)),
            ),
          ],
        ),
      ),
    );
  }
}
