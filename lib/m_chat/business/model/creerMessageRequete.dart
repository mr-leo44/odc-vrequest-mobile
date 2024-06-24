
// To parse this JSON data, do
//
//     final creerMessageRequete = creerMessageRequeteFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:odc_mobile_project/m_chat/business/model/DemandeChat.dart';
import 'dart:convert';

import 'package:odc_mobile_project/m_user/business/model/User.dart';

CreerMessageRequete creerMessageRequeteFromJson(String str) => CreerMessageRequete.fromJson(json.decode(str));

String creerMessageRequeteToJson(CreerMessageRequete data) => json.encode(data.toJson());

class CreerMessageRequete {
  DemandeChat demande;
  User user;
  String contenu;

  CreerMessageRequete({
    required this.demande,
    required this.user,
    this.contenu="",
  });

  factory CreerMessageRequete.fromJson(Map<String, dynamic> json) => CreerMessageRequete(
    demande: json["demande"] ?? null,
    user: json["user"] ?? null,
    contenu: json["contenu"]?? "",
  );

  Map<String, dynamic> toJson() => {
    "demande": demande,
    "user" : user,
    "contenu": contenu,
  };
}
