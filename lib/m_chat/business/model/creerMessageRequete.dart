
// To parse this JSON data, do
//
//     final creerMessageRequete = creerMessageRequeteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CreerMessageRequete creerMessageRequeteFromJson(String str) => CreerMessageRequete.fromJson(json.decode(str));

String creerMessageRequeteToJson(CreerMessageRequete data) => json.encode(data.toJson());

class CreerMessageRequete {
  int demandeId;
  String contenu;

  CreerMessageRequete({
    required this.demandeId,
    this.contenu="",
  });

  factory CreerMessageRequete.fromJson(Map<String, dynamic> json) => CreerMessageRequete(
    demandeId: json["demande_id"],
    contenu: json["contenu"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "demande_id": demandeId,
    "contenu": contenu,
  };
}
