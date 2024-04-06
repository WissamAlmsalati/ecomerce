class AppUser {
  String id;
  String name;
  String email;
  String password;
  String phone;

  AppUser({ required this.name,  required this.email,  required this.password , required this.phone, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phone: map['phone'],
    );
  }
}