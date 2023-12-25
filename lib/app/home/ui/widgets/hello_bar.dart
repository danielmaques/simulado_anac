import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme_manager.dart';

class HelloBar extends StatelessWidget {
  const HelloBar({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 53,
          width: 53,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage('https://i.pravatar.cc/900'),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Olá',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
        const Spacer(),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return Material(
              type: MaterialType.transparency,
              child: Transform.scale(
                scale: 0.7,
                child: IconButton(
                  onPressed: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  icon: Icon(
                    themeMode != ThemeMode.dark
                        ? Icons.nightlight
                        : Icons.sunny,
                    color: themeMode != ThemeMode.dark
                        ? Colors.blueGrey[800]
                        : Colors.yellow[800],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
