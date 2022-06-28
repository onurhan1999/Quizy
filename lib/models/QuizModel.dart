
class QuizModel{
  final String aab;

  QuizModel({
    required this.aab,
  });

  Map<String, dynamic> toJson() => {
    'aaa': aab,
  };

  QuizModel fromJson(Map<String, dynamic> json) => QuizModel(
    aab: json['aaa'],
  );
}