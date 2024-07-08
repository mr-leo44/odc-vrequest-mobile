// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String prenom;
  String username;
  String nom;
  String email;
  String phone;
  User? manager;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> role;

  User({
    required this.id,
    this.prenom = "",
    this.username = "",
    this.nom = "",
    this.email = "",
    this.phone = "",
    this.manager,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.role = const []
  });

  factory User.fromJson(Map json) => User(
    id: json["id"],
    prenom: json["first_name"] ?? "",
    username: json["username"] ?? "",
    nom: json["last_name"] ?? "",
    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    manager: json['manager'] != null
        ? User.fromJson(json['manager'] as Map<String, dynamic>)
        : null,
    emailVerifiedAt: json["email_verified_at"] != null
        ? DateTime.parse(json["email_verified_at"])
        : DateTime.now(),
    createdAt: json["created_at"] != null
        ? DateTime.parse(json["created_at"] ?? "")
        : DateTime.now(),
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"] ?? "")
        : DateTime.now(),
    role: json["role"] != null ? [json["role"].toString()] : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": prenom,
    "username": username,
    "last_name": nom,
    "manager": manager?.toJson(),
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "role": role,
  };
}
