// To parse this JSON data, do
//
//     final messageGroupe = messageGroupeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MessageGroupe messageGroupeFromJson(String str) => MessageGroupe.fromJson(json.decode(str));

String messageGroupeToJson(MessageGroupe data) => json.encode(data.toJson());

class MessageGroupe {
  int demandeId;
  DateTime createdAt;
  DateTime updatedAt;

  MessageGroupe({
    required this.demandeId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageGroupe.fromJson(Map<String, dynamic> json) => MessageGroupe(
    demandeId: json["demande_id"],
    createdAt: json["created_at"]!=null? DateTime.parse(json["created_at"] ?? ""): DateTime.now(),
    updatedAt: json["updated_at"]!=null? DateTime.parse(json["updated_at"] ?? ""): DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "demande_id": demandeId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
