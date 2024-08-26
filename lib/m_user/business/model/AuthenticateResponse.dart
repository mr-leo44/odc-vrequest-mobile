// To parse this JSON data, do
//
//     final authenticateResponse = authenticateResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';


import 'package:odc_mobile_project/m_user/business/model/User.dart';

AuthenticateResponse authenticateResponseFromJson(String str) => AuthenticateResponse.fromJson(json.decode(str));

String authenticateResponseToJson(AuthenticateResponse data) => json.encode(data.toJson());

class AuthenticateResponse {
  int id;
  String prenom;
  String username;
  String nom;

  String email;
  String phone;
  AuthenticateResponse? manager;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String token;
  List<String> role;


  AuthenticateResponse({
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
    required this.token,
    this.role = const []
  });

  factory AuthenticateResponse.fromJson(Map json) => AuthenticateResponse(
    id: json["id"] ?? 0,
    prenom: json["first_name"] ?? "",
    username: json["username"] ?? "",
    nom: json["last_name"] ?? "",

    email: json["email"] ?? "",
    phone: json["phone"] ?? "",
    manager: json['manager'] != null ? AuthenticateResponse.fromJson(json['manager'] as Map<String, dynamic>) : null,
    emailVerifiedAt: json["email_verified_at"]!=null? DateTime.parse(json["email_verified_at"] ) : DateTime.now(),
    createdAt: json["created_at"]!=null? DateTime.parse(json["created_at"] ?? ""): DateTime.now(),
    updatedAt: json["updated_at"]!=null? DateTime.parse(json["updated_at"] ?? "") : DateTime.now(),
    token: json["token"] ?? "",
    role: json["role"] != null ? List.from(json["role"])  : [],
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
    "token": token,
    "role": role,
  };
}
