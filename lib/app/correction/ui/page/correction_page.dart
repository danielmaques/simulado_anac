import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:simulados_anac/app/correction/ui/widgets/correction_tile.dart';

import '../../../punctuation/data/model/answer_model.dart';

class CorrectionPage extends StatelessWidget {
  const CorrectionPage({
    super.key,
    required this.question,
    required this.type,
  });

  final List<AnswerModel> question;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: false,
        title: Text(
          type,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        leading: IconButton(
          onPressed: () {
            Modular.to.pop();
          },
          icon: const Icon(
            EvaIcons.arrowBack,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              printPage(question: question);
            },
            icon: const Icon(
              EvaIcons.printerOutline,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: question.length,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return CorrectionTile(
              question: question[index].question,
              correct: question[index].correctAnswer,
              wrong: question[index].answer,
            );
          },
        ),
      ),
    );
  }
}

void printPage({required List<AnswerModel> question}) async {
  final pdf = pw.Document();

  final content = <pw.Widget>[];

  for (var i = 0; i < question.length; i++) {
    var q = question[i];
    content.add(pw.Text('Questão ${i + 1}: ${q.question}'));
    content.add(pw.Text('Resposta correta: ${q.correctAnswer}'));
    content.add(pw.Text('Sua resposta: ${q.answer}'));
    content.add(pw.SizedBox(height: 1.0 * PdfPageFormat.cm));
  }

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: content,
      ),
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
