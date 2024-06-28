// To parse this JSON data, do
//
//     final demande = demandeFromJson(jsonString);

import 'dart:convert';

import 'package:odc_mobile_project/m_user/business/model/User.dart';

Demande demandeFromJson(String str) => Demande.fromJson(json.decode(str));

String demandeToJson(Demande data) => json.encode(data.toJson());

class Demande {
  int id;
  DateTime dateDemande;
  String motif;
  String ticket;
  DateTime dateDeplacement;
  String lieuDepart;
  String destination;
  String status;
  int nbrePassagers;
  User initiateur ;
  User manager;
  User chefCharroi;
  double longitude;
  double latitude;
  DateTime createAt;

  Demande({
    this.id = 0,
    required this.dateDemande,
    this.motif = "",
    this.ticket = "",
    required this.dateDeplacement ,
    this.lieuDepart = "",
    this.destination = "",
    this.status ="",
    this.nbrePassagers = 0,
    required this.initiateur,
    required this.manager,
    required this.chefCharroi,
    this.longitude = 0.0,
    this.latitude = 0.0,
    required this.createAt,
  });

  factory Demande.fromJson(Map<String, dynamic> json) => Demande(
    id: json["id"] ?? 0,
    dateDemande:json["date_demande"] != null ? DateTime.parse(json["date_demande"]) : DateTime.now(),
    motif: json["motif"] ?? "",
    ticket: json["ticket"] ?? "",
    dateDeplacement:json["date_deplacement"] != null ? DateTime.parse(json["date_deplacement"]) : DateTime.now(),
    lieuDepart: json["lieu_depart"] ??  0,
    destination: json["destination"] ??  0,
    nbrePassagers: json["nbre_passagers"] ??  0,
    initiateur: json["initiateur"] ??  null,
    manager: json["manager"] ??  null,
    chefCharroi: json["chef_charroi"] ??  null,
    longitude: json["longitude"].toDouble() ?? 0.0,
    latitude: json["latitude"].toDouble() ?? 0.0,
    createAt: json["create_at"] != null ? DateTime.parse(json["create_at"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_demande": "${dateDemande.year.toString().padLeft(4, '0')}-${dateDemande.month.toString().padLeft(2, '0')}-${dateDemande.day.toString().padLeft(2, '0')}",
    "motif": motif,
    "status": status,
    "date_deplacement": "${dateDeplacement.year.toString().padLeft(4, '0')}-${dateDeplacement.month.toString().padLeft(2, '0')}-${dateDeplacement.day.toString().padLeft(2, '0')}",
    "lieu_depart": lieuDepart,
    "destination": destination,
    "nbre_passagers": nbrePassagers,
    "initiateur": initiateur,
    "manager": manager,
    "chef_charroi": chefCharroi,
    "longitude": longitude,
    "latitude": latitude,
    "create_at": "${createAt.year.toString().padLeft(4, '0')}-${createAt.month.toString().padLeft(2, '0')}-${createAt.day.toString().padLeft(2, '0')}",
  };

}


