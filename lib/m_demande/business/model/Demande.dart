// To parse this JSON data, do
//
//     final demande = demandeFromJson(jsonString);

import 'dart:convert';

Demande demandeFromJson(String str) => Demande.fromJson(json.decode(str));

String demandeToJson(Demande data) => json.encode(data.toJson());

class Demande {
  int id;
  DateTime dateDemande;
  String motif;
  DateTime dateDeplacement;
  int lieuDepartId;
  int destinationId;
  int nbrePassagers;
  int userId;
  int managerId;
  int charroiId;
  double longitude;
  double latitude;
  DateTime createAt;

  Demande({
    this.id = 0,
    required this.dateDemande,
    this.motif = "",
    required this.dateDeplacement ,
    this.lieuDepartId = 0,
    this.destinationId = 0,
    this.nbrePassagers = 0,
    required this.userId,
    required this.managerId,
    required this.charroiId,
    this.longitude = 0.0,
    this.latitude = 0.0,
    required this.createAt,
  });

  factory Demande.fromJson(Map<String, dynamic> json) => Demande(
    id: json["id"] ?? 0,
    dateDemande:json["date_demande"] != null ? DateTime.parse(json["date_demande"]) : DateTime.now(),
    motif: json["motif"] ?? "",
    dateDeplacement:json["date_deplacement"] != null ? DateTime.parse(json["date_deplacement"]) : DateTime.now(),
    lieuDepartId: json["lieu_depart_id"] ??  0,
    destinationId: json["destination_id"] ??  0,
    nbrePassagers: json["nbre_passagers"] ??  0,
    userId: json["user_id"] ??  0,
    managerId: json["manager_id"] ??  0,
    charroiId: json["charroi_id"] ??  0,
    longitude: json["longitude"].toDouble() ?? 0.0,
    latitude: json["latitude"].toDouble() ?? 0.0,
    createAt: json["create_at"] != null ? DateTime.parse(json["create_at"]) : DateTime.now(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_demande": "${dateDemande.year.toString().padLeft(4, '0')}-${dateDemande.month.toString().padLeft(2, '0')}-${dateDemande.day.toString().padLeft(2, '0')}",
    "motif": motif,
    "date_deplacement": "${dateDeplacement.year.toString().padLeft(4, '0')}-${dateDeplacement.month.toString().padLeft(2, '0')}-${dateDeplacement.day.toString().padLeft(2, '0')}",
    "lieu_depart_id": lieuDepartId,
    "destination_id": destinationId,
    "nbre_passagers": nbrePassagers,
    "user_id": userId,
    "manager_id": managerId,
    "charroi_id": charroiId,
    "longitude": longitude,
    "latitude": latitude,
    "create_at": "${createAt.year.toString().padLeft(4, '0')}-${createAt.month.toString().padLeft(2, '0')}-${createAt.day.toString().padLeft(2, '0')}",
  };

}
