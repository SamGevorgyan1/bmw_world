import 'dart:convert';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String imageUrl;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        imageUrl: json['imageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'imageUrl': imageUrl,
      };

  String toJsonString() => jsonEncode(toJson());

  factory User.fromJsonString(String jsonString) => User.fromJson(json.decode(jsonString));
}
