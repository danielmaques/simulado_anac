import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/theme_manager.dart';

class HelloBar extends StatelessWidget {
  const HelloBar({
    super.key,
    required this.name,
    required this.image,
  });

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 53,
          width: 53,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: image == ''
                  ? const CachedNetworkImageProvider(
                      'https://firebasestorage.googleapis.com/v0/b/anac-eb542.appspot.com/o/2181602-mascote-piloto-forca-aerea-oficial-perfil-avatar-cartoon-ilustracao-vetor.jpg?alt=media&token=a466ab5d-d943-425f-a14c-7c984e60f0e3')
                  : CachedNetworkImageProvider(image),
              fit: BoxFit.fill,
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
