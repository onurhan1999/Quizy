
class QuizModel{
  final String title;
  final String category;
  //final List<Question> questions;


  QuizModel({
    required this.title,
    required this.category,
    //required this.questions,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'category':category,
  };

  QuizModel fromJson(Map<String, dynamic> json) => QuizModel(
    title: json['title'],
    category: json['category'],
  );
}