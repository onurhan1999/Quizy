
class UserModel{
  final String username;
  final int score;


  UserModel({
    required this.username,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
    'UserName': username,
    'Score': score,
    'cozulenTestler': [],
    'Avatar':"https://firebasestorage.googleapis.com/v0/b/cookcaquiz.appspot.com/o/1.png?alt=media&token=abcd8ce4-6227-4454-99b2-a3590b95246a"
  };

  UserModel fromJson(Map<String, dynamic> json) => UserModel(
    username: json['UserName'],
    score: json['Score'],
  );
}