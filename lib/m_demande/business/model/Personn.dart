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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Personn && other.id == id; // Comparaison par ID
  }

  @override
  int get hashCode => id.hashCode; // Utilisation de l'ID pour le hash
}
