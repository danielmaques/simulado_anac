class AnswerModel {
  final String question;
  final bool correct;
  final String correctAnswer;
  final String answer;

  AnswerModel({
    required this.question,
    required this.correct,
    required this.correctAnswer,
    required this.answer,
  });

  Map<String, dynamic> toJson() => {
        'question': question,
        'correct': correct,
        'correctAnswer': correctAnswer,
        'answer': answer,
      };

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        question: json['question'],
        correct: json['correct'],
        correctAnswer: json['correctAnswer'],
        answer: json['answer'],
      );
}
