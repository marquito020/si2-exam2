import 'dart:convert';

class User {
  int? id;
  String correo;
  String password;

  User({
    this.id,
    required this.correo,
    required this.password,
  });

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id,
        "correo": correo,
        "password": password,
      };

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        correo: json["correo"],
        password: json["password"],
      );
}
