class UserModel {
  int? id;
  String email;
  String username;
  String password;
  String phone;

  UserModel({
    this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
    );
  }
}