import 'package:flutter/material.dart';

class CorrectionTile extends StatelessWidget {
  const CorrectionTile({
    super.key,
    required this.question,
    required this.correct,
    required this.wrong,
  });

  final String question;
  final String correct;
  final String wrong;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              question,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFF34D287).withOpacity(0.2),
                border: Border.all(
                  color: const Color(0xFF34D287),
                  width: 1,
                ),
              ),
              child: Text(
                correct,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 15),
            Visibility(
              visible: correct != wrong,
              child: Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFF55150).withOpacity(0.2),
                  border: Border.all(
                    color: const Color(0xFFF55150),
                    width: 1,
                  ),
                ),
                child: Text(
                  wrong,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
