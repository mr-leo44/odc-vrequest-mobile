// To parse this JSON data, do
//
//     final creerMessageRequete = creerMessageRequeteFromJson(jsonString);

import 'package:odc_mobile_project/m_demande/business/model/Demande.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

import 'package:odc_mobile_project/m_user/business/model/User.dart';

CreerMessageRequete creerMessageRequeteFromJson(String str) =>
    CreerMessageRequete.fromJson(json.decode(str));

String creerMessageRequeteToJson(CreerMessageRequete data) =>
    json.encode(data.toJson());

class CreerMessageRequete {
  Demande demande;
  User user;
  String contenu;
  XFile? file;
  bool isVideo;
  bool isPicture;

  CreerMessageRequete({
    required this.demande,
    required this.user,
    this.contenu = "",
    this.file = null,
    this.isVideo = false,
    this.isPicture = false,
  });

  factory CreerMessageRequete.fromJson(Map<String, dynamic> json) =>
      CreerMessageRequete(
        demande: json["demande"] ?? null,
        user: json["user"] ?? null,
        contenu: json["contenu"] ?? "",
        file: json["file"] ?? null,
        isVideo: json["isVideo"] ?? false,
        isPicture: json["isPicture"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "demande": demande,
        "user": user,
        "contenu": contenu,
        "file": file,
        "isVideo": isVideo,
        "isPicture": isPicture,
      };
}
