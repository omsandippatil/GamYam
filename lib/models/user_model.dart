class UserModel {
  final String id;
  final String name;
  final int points;

  UserModel({required this.id, required this.name, required this.points});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      points: json['points'],
    );
  }
}
