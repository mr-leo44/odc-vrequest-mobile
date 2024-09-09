// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Personn welcomeFromJson(String str) => Personn.fromJson(json.decode(str));

String welcomeToJson(Personn data) => json.encode(data.toJson());

class Personn {
  int id;
  String nom;

  Personn({
    this.id = 0,
    required this.nom,
  });

  factory Personn.fromJson(Map<String, dynamic> json) => Personn(
    id: json["id"],
    nom: json["nom"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nom": nom,
  };
}
