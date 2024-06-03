// To parse this JSON data, do
//
//     final authenticateResponse = authenticateResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AuthenticateResponse authenticateResponseFromJson(String str) => AuthenticateResponse.fromJson(json.decode(str));

String authenticateResponseToJson(AuthenticateResponse data) => json.encode(data.toJson());

class AuthenticateResponse {
  int id;
  String name;
  String email;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String token;

  AuthenticateResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
  });

  factory AuthenticateResponse.fromJson(Map json) => AuthenticateResponse(
    id: json["id"],
    name: json["name"] ?? "",
    email: json["email"] ?? "",
    emailVerifiedAt: json["email_verified_at"]!=null? DateTime.parse(json["email_verified_at"] ) : DateTime.now(),
    createdAt: json["created_at"]!=null? DateTime.parse(json["created_at"] ?? ""): DateTime.now(),
    updatedAt: json["updated_at"]!=null? DateTime.parse(json["updated_at"] ?? "") : DateTime.now(),
    token: json["token"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "token": token,
  };
}
