// To parse this JSON data, do
//
//     final demandeRequest = demandeRequestFromJson(jsonString);

import 'dart:convert';

String demandeRequestToJson(DemandeRequest data) => json.encode(data.toJson());

class DemandeRequest {
  String motif;
  String ticket;
  DateTime date;
  DateTime dateDeplacement;
  int nbrePassagers;
  int userId;
  int managerId;
  String lieuDepart;
  String destination;
  double longitudeDepart;
  double latitudeDepart;
  double latitudeDestination;
  double longitudeDestination;

  DemandeRequest({
    required this.motif,
    required this.ticket,
    required this.date,
    required this.dateDeplacement,
    required this.nbrePassagers,
    required this.userId,
    required this.managerId,
    this.lieuDepart = "",
    this.destination = "",
    this.latitudeDepart = 0.0,
    this.longitudeDepart = 0.0,
    this.latitudeDestination = 0.0,
    this.longitudeDestination = 0.0,
  });

  Map<String, dynamic> toJson() => {
        "motif": motif,
        "ticket": ticket,
        "date_deplacement":
            "${dateDeplacement.year.toString().padLeft(4, '0')}-${dateDeplacement.month.toString().padLeft(2, '0')}-${dateDeplacement.day.toString().padLeft(2, '0')} ${dateDeplacement.hour.toString().padLeft(2, '0')}:${dateDeplacement.minute.toString().padLeft(2, '0')}",
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "nbre_passagers": nbrePassagers,
        "user_id": userId,
        "manager_id": managerId,
        "lieu_depart": lieuDepart,
        "destination": destination,
        "latitude_depart": latitudeDepart,
        "longitude_depart": longitudeDepart,
        "latitude_destination": latitudeDestination,
        "longitude_destination": longitudeDestination,
      };

  bool validate() {
    // Vérifier que le motif n'est pas nul ou vide
    if (motif.trim().isEmpty ?? true) {
      return false;
    }
    if (ticket.trim().isEmpty ?? true) {
      return false;
    }

    // Vérifier que la date de déplacement est valide
    if (dateDeplacement == DateTime.fromMillisecondsSinceEpoch(0)) {
      return false;
    }
    if (date == DateTime.fromMillisecondsSinceEpoch(0)) {
      return false;
    }

    // Vérifier que le nombre de passagers est positif
    if (nbrePassagers <= 0) {
      return false;
    }
    if (userId <= 0) {
      return false;
    }
    if (managerId <= 0) {
      return false;
    }
    /* if (userId <= 0) {
      return false;
    }*/

    // Vérifier que les lieux de départ et de destination ne sont pas nuls ou vides
    if (lieuDepart.trim().isEmpty ??
        true || destination.trim().isEmpty ??
        true) {
      return false;
    }

    // Vérifier que les coordonnées sont valides
    if (longitudeDepart == 0.0 && latitudeDepart == 0.0) {
      return false;
    }

    if (longitudeDestination == 0.0 && latitudeDestination == 0.0) {
      return false;
    }

    // Si tous les tests sont passés, les données sont valides
    return true;
  }
}
