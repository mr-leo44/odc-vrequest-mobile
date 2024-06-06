// To parse this JSON data, do
//
//     final messageDetails = messageDetailsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MessageDetails messageDetailsFromJson(String str) => MessageDetails.fromJson(json.decode(str));

String messageDetailsToJson(MessageDetails data) => json.encode(data.toJson());

class MessageDetails {
  int messageGroupeId;
  int expediteurId;
  String contenu;
  DateTime createdAt;
  DateTime updatedAt;

  MessageDetails({
    required this.messageGroupeId,
    required this.expediteurId,
    this.contenu="",
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageDetails.fromJson(Map<String, dynamic> json) => MessageDetails(
    messageGroupeId: json["MessageGroupe_id"],
    expediteurId: json["expediteur_id"],
    contenu: json["contenu"] ?? "",
    createdAt: json["created_at"]!=null? DateTime.parse(json["created_at"] ?? ""): DateTime.now(),
    updatedAt: json["updated_at"]!=null? DateTime.parse(json["updated_at"] ?? ""): DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "MessageGroupe_id": messageGroupeId,
    "expediteur_id": expediteurId,
    "contenu": contenu,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
