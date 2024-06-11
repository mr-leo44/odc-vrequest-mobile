// To parse this JSON data, do
//
//     final demandeRequest = demandeRequestFromJson(jsonString);

import 'dart:convert';

String demandeRequestToJson(DemandeRequest data) => json.encode(data.toJson());

class DemandeRequest {
  String motif;
  DateTime dateDeplacement;
  int nbrePassagers;
  int lieuDepartId;
  int destinationId;

  DemandeRequest({
    required this.motif,
    required this.dateDeplacement,
    required this.nbrePassagers,
    this.lieuDepartId = 0,
    this.destinationId = 0,
  });

  Map<String, dynamic> toJson() => {
        "motif": motif,
        "date_deplacement":
            "${dateDeplacement.year.toString().padLeft(4, '0')}-${dateDeplacement.month.toString().padLeft(2, '0')}-${dateDeplacement.day.toString().padLeft(2, '0')}",
        "nbre_passagers": nbrePassagers,
        "lieu_depart_id": lieuDepartId,
        "destination_id": destinationId,
      };
}
