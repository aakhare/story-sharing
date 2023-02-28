import 'dart:convert';

class User {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  User({
      required this.email,
      required this.password,
      required this.firstName,
      required this.lastName});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}