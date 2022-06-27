
class UserModel{
  final String username;
  final String score;

  UserModel({
    required this.username,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
    'UserName': username,
    'Score': score,
  };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
    username: json['UserName'],
    score: json['Score'],
  );
}