import 'package:flutter/material.dart';

class LatestSimulations extends StatefulWidget {
  const LatestSimulations({
    super.key,
    required this.title,
    required this.correct,
    required this.wrong,
    required this.notAnswered,
    required this.percentage,
  });

  final String title;
  final String correct;
  final String wrong;
  final String notAnswered;
  final double percentage;

  @override
  State<LatestSimulations> createState() => _LatestSimulationsState();
}

class _LatestSimulationsState extends State<LatestSimulations> {
  late String state = '';

  void percentage() {
    switch (widget.percentage) {
      case >= 70.0:
        state = 'Aprovado';
        break;
      default:
        state = 'Reprovado';
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    percentage();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(10),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.title} - $state',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: state == 'Aprovado'
                      ? const Color(0xFF34D287)
                      : const Color(0xFFF55150)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Corretas ${widget.correct}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: const Color(0xFF34D287)),
                ),
                Text(
                  'Erradas ${widget.wrong}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: const Color(0xFFF55150)),
                ),
                Text(
                  'Não respondidas ${widget.notAnswered}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: const Color(0xFFFEBB3B)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
