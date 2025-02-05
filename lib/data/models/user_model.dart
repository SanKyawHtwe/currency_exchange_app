import 'dart:convert';

class User {
  final String? name;
  final String email;
  final String password;

  // Constructor to initialize User object with name, email, and password
  User({this.name, required this.email, required this.password});

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'], // 'name' can be null, which is acceptable
      email: json['email'],
      password: json['password'],
    );
  }

  // Convert User object to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  // Convert User object to JSON string
  String toJson() => json.encode(toMap());

  // Convert JSON string to User object
  factory User.fromJsonString(String source) {
    return User.fromJson(json.decode(source));
  }
}
