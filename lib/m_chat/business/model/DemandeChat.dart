// To parse this JSON data, do
//
//     final demande = demandeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:odc_mobile_project/m_user/business/model/User.dart';

DemandeChat demandeFromJson(String str) => DemandeChat.fromJson(json.decode(str));

String demandeToJson(DemandeChat data) => json.encode(data.toJson());

class DemandeChat {
  final int id;
  final String ticket;
  final String motif;
  final String dateDeplacement;
  final String lieuDestination;
  final String lieuDepart;
  final String status;
  final String longitude;
  final String latitude;
  final User initiateur;
  final User chauffeur;
  final int nbrEtranger;
  final String createdAt;

  DemandeChat({
    required this.id,
    required this.ticket,
    required this.dateDeplacement,
    required this.motif,
    required this.lieuDestination,
    required this.lieuDepart,
    required this.status,
    required this.longitude,
    required this.latitude,
    required this.initiateur,
    required this.chauffeur,
    this.nbrEtranger = 0 ,
    required this.createdAt,
  });

  DemandeChat copyWith({
    int? id,
    String? ticket,
    String? motif,
    String? dateDeplacement,
    String? lieuDestination,
    String? lieuDepart,
    String? status,
    String? longitude,
    String? latitude,
    User? initiateur,
    User? chauffeur,
    int? nbrEtranger,
    String? createdAt,
  }) =>
      DemandeChat(
        id: id ?? this.id,
        ticket: ticket ?? this.ticket,
        motif: motif ?? this.motif,
        dateDeplacement: dateDeplacement ?? this.dateDeplacement,
        lieuDestination: lieuDestination ?? this.lieuDestination,
        lieuDepart: lieuDepart ?? this.lieuDepart,
        status: status ?? this.status,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        initiateur: initiateur ?? this.initiateur,
        chauffeur: chauffeur ?? this.chauffeur,
        nbrEtranger: nbrEtranger ?? this.nbrEtranger,
        createdAt: createdAt ?? this.createdAt,
      );

  factory DemandeChat.fromJson(Map<String, dynamic> json) => DemandeChat(
        id: json["id"] ?? -1,
        ticket: json["ticket"] ?? "",
        motif: json["motif"] ?? "",
        dateDeplacement: json["dateDeplacement"] ?? "",
        lieuDestination: json["lieuDestination"] ?? "",
        lieuDepart: json["lieuDepart"] ?? "",
        status: json["status"] ?? "",
        longitude: json["longitude"] ?? "",
        latitude: json["latitude"] ?? "",
        initiateur: json["initiateur"] ?? null,
        chauffeur: json["chauffeur"] ?? null,
        nbrEtranger: json["nbrEtranger"] ?? 0,
        createdAt: json["created_at"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ticket": ticket,
        "motif": motif,
        "dateDeplacement": dateDeplacement,
        "lieuDestination": lieuDestination,
        "lieuDepart": lieuDepart,
        "status": status,
        "longitude": longitude,
        "latitude": latitude,
        "initiateur" : initiateur,
        "chauffeur" : chauffeur,
        "nbrEtranger" : nbrEtranger,
        "created_at": createdAt,
      };
}
