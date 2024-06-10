// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String prenom;
  String name;
  String postnom;
  String sexe;
  String email;
  String telephone;
  int managerId;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;

  User({
   required this.id,
    this.prenom = "",
    this.name = "",
    this.postnom = "",
    this.sexe = "",
    this.email = "",
    this.telephone = "",
    this.managerId = 0,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map json) => User(
    id: json["id"],
    prenom: json["prenom"] ?? "",
    name: json["name"] ?? "",
    postnom: json["postnom"] ?? "",
    sexe: json["sexe"] ?? "",
    email: json["email"] ?? "",
    telephone: json["telephone"] ?? "",
    managerId: json["manager_id"]?? "",
    emailVerifiedAt: json["email_verified_at"]!=null? DateTime.parse(json["email_verified_at"] ) : DateTime.now(),
    createdAt: json["created_at"]!=null? DateTime.parse(json["created_at"] ?? ""): DateTime.now(),
    updatedAt: json["updated_at"]!=null? DateTime.parse(json["updated_at"] ?? "") : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "prenom": prenom,
    "name": name,
    "postnom": postnom,
    "sexe": sexe,
    "email": email,
    "telephone": telephone,
    "manager_id": managerId,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
