// To parse this JSON data, do
//
//     final authenticate = authenticateFromJson(jsonString);

import 'dart:convert';

AuthenticateRequestBody authenticateFromJson(String str) => AuthenticateRequestBody.fromJson(json.decode(str));

String authenticateToJson(AuthenticateRequestBody data) => json.encode(data.toJson());

class AuthenticateRequestBody {
  String email;
  String password;

  AuthenticateRequestBody({
    required this.email,
    required this.password,
  });

  factory AuthenticateRequestBody.fromJson(Map<String, dynamic> json) => AuthenticateRequestBody(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
