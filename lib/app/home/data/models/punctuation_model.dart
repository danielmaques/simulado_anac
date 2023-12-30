// ignore_for_file: prefer_null_aware_operators

class PunctuationModel {
  final String id;
  final String subject;
  final int correctAnswers;
  final int wrongAnswers;
  final int notAnswered;
  final DateTime date;
  final double percentage;

  PunctuationModel({
    required this.id,
    required this.subject,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.notAnswered,
    required this.date,
    required this.percentage,
  });

  factory PunctuationModel.fromJson(Map<String, dynamic> json) {
    return PunctuationModel(
      id: json['id'],
      subject: json['subject'],
      correctAnswers: json['correctAnswers'],
      wrongAnswers: json['wrongAnswers'],
      notAnswered: json['notAnswered'],
      date: DateTime.parse(json['date']),
      percentage: (json['percentage'] as double?) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'notAnswered': notAnswered,
      'date': date.toIso8601String(),
      'percentage': percentage,
    };
  }
}
