// To parse this JSON data, do
//
//     final demande = demandeFromJson(jsonString);

import 'dart:convert';

import '../../../m_user/business/model/User.dart';

Demande demandeFromJson(String str) => Demande.fromJson(json.decode(str));

String demandeToJson(Demande data) => json.encode(data.toJson());

class Demande {
  int id;
  DateTime dateDemande;
  String motif;
  String status;
  String ticket;
  DateTime dateDeplacement;

  String lieuDepart;
  String destination;
  int nbrePassagers;
  User? initiateur;
  User? manager;
  User? chauffeur;
  double longitudelDepart;
  double latitudeDepart;
  double longitudelDestination;
  double latitudeDestination;
  DateTime createAt;

  Demande({
    this.id = 0,
    required this.dateDemande,
    this.motif = "",
    this.status = "",
    this.ticket = "",
    required this.dateDeplacement,
    this.lieuDepart = "",
    this.destination = '',
    this.nbrePassagers = 0,
    required this.initiateur,
    this.manager = null,
    this.chauffeur = null,
    this.longitudelDepart = 0.0,
    this.latitudeDepart = 0.0,
    this.longitudelDestination = 0.0,
    this.latitudeDestination = 0.0,
    required this.createAt,
  });

  factory Demande.fromJson(Map<String, dynamic> json) => Demande(
    id: json["id"] ?? 0,
    dateDemande: json["date_demande"] != null
        ? DateTime.parse(json["date_demande"])
        : DateTime.now(),
    motif: json["motif"] ?? "",
    ticket: json["ticket"] ?? "",
    status: json["status"] ?? "",
    dateDeplacement: json["date_deplacement"] != null
        ? DateTime.parse(json["date_deplacement"])
        : DateTime.now(),
    lieuDepart: json["lieu_depart"] ?? "",
    destination: json["destination"] ?? "",
    nbrePassagers: json["nbre_passagers"] ?? 0,
    initiateur: json["initiateur"] != null
        ? User.fromJson(json["initiateur"])
        : User(
        id: 0,
        emailVerifiedAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    manager: json["manager"] != null
        ? User.fromJson(json["manager"])
        : User(
        id: 0,
        emailVerifiedAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    chauffeur: json["chauffeur"] != null
        ? User.fromJson(json["chauffeur"])
        : User(
        id: 0,
        emailVerifiedAt: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now()),
    longitudelDepart: json["longitude_depart"] != null
        ? json["longitude_depart"].toDouble()
        : 0.0,
    latitudeDepart: json["latitude_depart"] != null
        ? json["latitude_depart"].toDouble()
        : 0.0,
    longitudelDestination: json["longitude_destination"] != null
        ? json["longitude_destination"].toDouble()
        : 0.0,
    latitudeDestination: json["latitude_destination"] != null
        ? json["latitude_destination"].toDouble()
        : 0.0,
    createAt: json["create_at"] != null
        ? DateTime.parse(json["create_at"])
        : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_demande":
    "${dateDemande.year.toString().padLeft(4, '0')}-${dateDemande.month.toString().padLeft(2, '0')}-${dateDemande.day.toString().padLeft(2, '0')}",
    "motif": motif,
    "ticket": ticket,
    "status": status,
    "date_deplacement":
    "${dateDeplacement.year.toString().padLeft(4, '0')}-${dateDeplacement.month.toString().padLeft(2, '0')}-${dateDeplacement.day.toString().padLeft(2, '0')}",
    "lieu_depart_id": lieuDepart,
    "destination_id": destination,
    "nbre_passagers": nbrePassagers,
    "user_id": initiateur,
    "manager_id": manager,
    "charroi_id": chauffeur,
    "longitude": longitudelDepart,
    "latitude_depart": latitudeDepart,
    "longitude_destination": longitudelDestination,
    "latitude_destination": latitudeDestination,
    "create_at":
    "${createAt.year.toString().padLeft(4, '0')}-${createAt.month.toString().padLeft(2, '0')}-${createAt.day.toString().padLeft(2, '0')}",
  };
}