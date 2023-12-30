class PunctuationParams {
  final String id;
  final String subject;
  final int correctAnswers;
  final int wrongAnswers;
  final int notAnswered;
  final DateTime date;
  final double percentage;

  PunctuationParams({
    required this.id,
    required this.subject,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.notAnswered,
    required this.date,
    required this.percentage,
  });
}
